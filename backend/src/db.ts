import fs from 'node:fs';
import path from 'node:path';
import initSqlJs, { type Database, type QueryExecResult, type SqlJsStatic } from 'sql.js';

export interface TableColumn {
	name: string;
	type: string;
	notNull: boolean;
	defaultValue: string | null;
	isPrimaryKey: boolean;
}

export interface TableMetadata {
	name: string;
	columns: TableColumn[];
	primaryKey: string | null;
}

export interface ListRowsOptions {
	limit?: number;
	offset?: number;
	sortBy?: string;
	sortOrder?: 'asc' | 'desc';
}

const DEFAULT_LIMIT = 100;
const MAX_LIMIT = 500;

let sqlJsPromise: Promise<SqlJsStatic> | null = null;
let databasePromise: Promise<Database> | null = null;

function inferPrimaryKey(columns: TableColumn[]): string | null {
	return columns.find((column) => column.isPrimaryKey)?.name
		?? columns.find((column) => column.name.endsWith('_id'))?.name
		?? columns[0]?.name
		?? null;
}

function getPrimaryKeyColumn(table: TableMetadata): TableColumn | undefined {
	if (!table.primaryKey) {
		return undefined;
	}

	return table.columns.find((column) => column.name === table.primaryKey);
}

function isNumericColumnType(columnType: string): boolean {
	return /\b(?:tinyint|smallint|mediumint|bigint|int|integer)\b/i.test(columnType);
}

function getNextNumericPrimaryKeyValue(database: Database, table: TableMetadata): number | null {
	const primaryKeyColumn = getPrimaryKeyColumn(table);
	if (!primaryKeyColumn || !isNumericColumnType(primaryKeyColumn.type)) {
		return null;
	}

	const result = normalizeExecRows(
		database.exec(
			`SELECT COALESCE(MAX(${quoteIdentifier(primaryKeyColumn.name)}), 0) + 1 AS next_id FROM ${quoteIdentifier(table.name)};`
		)[0]
	);

	const nextId = Number(result[0]?.next_id ?? 1);
	return Number.isFinite(nextId) ? nextId : 1;
}

function getDatabaseFilePath(): string {
	const databaseUrl = process.env.DATABASE_URL;
	if (!databaseUrl) {
		throw new Error('DATABASE_URL is not configured');
	}

	if (!databaseUrl.startsWith('sqlite:///')) {
		throw new Error(`Unsupported DATABASE_URL: ${databaseUrl}`);
	}

	let databasePath = databaseUrl.slice('sqlite:///'.length);
	if (databaseUrl.startsWith('sqlite:////')) {
		databasePath = `/${databaseUrl.slice('sqlite:////'.length)}`;
	}

	return path.isAbsolute(databasePath) ? databasePath : path.resolve(databasePath);
}

function getSqlJs(): Promise<SqlJsStatic> {
	if (!sqlJsPromise) {
		sqlJsPromise = initSqlJs({
			locateFile: (file: string) => path.join(process.cwd(), 'node_modules', 'sql.js', 'dist', file),
		});
	}

	return sqlJsPromise!;
}

async function openDatabase(): Promise<Database> {
	const SQL = await getSqlJs();
	const databaseFilePath = getDatabaseFilePath();
	const databaseDir = path.dirname(databaseFilePath);

	fs.mkdirSync(databaseDir, { recursive: true });

	const fileBuffer = fs.existsSync(databaseFilePath)
		? fs.readFileSync(databaseFilePath)
		: undefined;

	const database = new SQL.Database(fileBuffer);
	database.exec('PRAGMA foreign_keys = ON;');
	return database;
}

async function getDatabase(): Promise<Database> {
	if (!databasePromise) {
		databasePromise = openDatabase();
	}

	return databasePromise;
}

function saveDatabase(database: Database): void {
	const databaseFilePath = getDatabaseFilePath();
	fs.writeFileSync(databaseFilePath, Buffer.from(database.export()));
}

function normalizeExecRows(result?: QueryExecResult): Record<string, unknown>[] {
	if (!result) {
		return [];
	}

	return result.values.map((row: Array<string | number | null>) => {
		const mappedRow: Record<string, unknown> = {};
		result.columns.forEach((column: string, index: number) => {
			mappedRow[column] = row[index];
		});
		return mappedRow;
	});
}

function quoteIdentifier(identifier: string): string {
	return `"${identifier.replace(/"/g, '""')}"`;
}

function normalizeLimit(limit?: number): number {
	if (!Number.isFinite(limit) || !limit || limit < 1) {
		return DEFAULT_LIMIT;
	}

	return Math.min(limit, MAX_LIMIT);
}

function normalizeOffset(offset?: number): number {
	if (!Number.isFinite(offset) || !offset || offset < 0) {
		return 0;
	}

	return offset;
}

async function ensureTableExists(tableName: string): Promise<TableMetadata> {
	const tables = await getTables();
	const table = tables.find((entry) => entry.name === tableName);
	if (!table) {
		throw new Error(`Unknown table: ${tableName}`);
	}

	return table;
}

export async function getTables(): Promise<TableMetadata[]> {
	const database = await getDatabase();
	const tableRows = normalizeExecRows(
		database.exec(`
			SELECT name
			FROM sqlite_master
			WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
			ORDER BY name ASC;
		`)[0]
	);

	return tableRows.map((row) => {
		const name = String(row.name);
		const columns = normalizeExecRows(database.exec(`PRAGMA table_info(${quoteIdentifier(name)});`)[0]).map((column) => ({
			name: String(column.name),
			type: String(column.type ?? ''),
			notNull: Number(column.notnull ?? 0) === 1,
			defaultValue: column.dflt_value == null ? null : String(column.dflt_value),
			isPrimaryKey: Number(column.pk ?? 0) === 1,
		}));

		return {
			name,
			columns,
			primaryKey: inferPrimaryKey(columns),
		};
	});
}

export async function listRows(tableName: string, options: ListRowsOptions = {}): Promise<{ rows: Record<string, unknown>[]; total: number; }> {
	const table = await ensureTableExists(tableName);
	const database = await getDatabase();
	const limit = normalizeLimit(options.limit);
	const offset = normalizeOffset(options.offset);
	const sortBy = options.sortBy && table.columns.some((column) => column.name === options.sortBy)
		? options.sortBy
		: table.primaryKey ?? table.columns[0]?.name;
	const sortOrder = options.sortOrder === 'desc' ? 'DESC' : 'ASC';

	const totalRows = normalizeExecRows(
		database.exec(`SELECT COUNT(*) AS total FROM ${quoteIdentifier(table.name)};`)[0]
	);

	const query = `
		SELECT *
		FROM ${quoteIdentifier(table.name)}
		ORDER BY ${quoteIdentifier(sortBy ?? table.name)} ${sortOrder}
		LIMIT ${limit}
		OFFSET ${offset};
	`;

	const rows = normalizeExecRows(database.exec(query)[0]);
	return {
		rows,
		total: Number(totalRows[0]?.total ?? 0),
	};
}

export async function getRowById(tableName: string, rowId: string): Promise<Record<string, unknown> | null> {
	const table = await ensureTableExists(tableName);
	const database = await getDatabase();

	if (!table.primaryKey) {
		throw new Error(`Table ${tableName} has no primary key`);
	}

	const statement = database.prepare(
		`SELECT * FROM ${quoteIdentifier(table.name)} WHERE ${quoteIdentifier(table.primaryKey)} = ? LIMIT 1;`
	);
	statement.bind([rowId]);

	const rows: Record<string, unknown>[] = [];
	while (statement.step()) {
		rows.push(statement.getAsObject() as Record<string, unknown>);
	}
	statement.free();

	return rows[0] ?? null;
}

export async function insertRow(tableName: string, payload: Record<string, unknown>): Promise<Record<string, unknown> | null> {
	const table = await ensureTableExists(tableName);
	const database = await getDatabase();
	const normalizedPayload = { ...payload };

	if (table.primaryKey) {
		const providedPrimaryKey = normalizedPayload[table.primaryKey];
		if (providedPrimaryKey === undefined || providedPrimaryKey === null || providedPrimaryKey === '') {
			const generatedPrimaryKey = getNextNumericPrimaryKeyValue(database, table);
			if (generatedPrimaryKey !== null) {
				normalizedPayload[table.primaryKey] = generatedPrimaryKey;
			}
		}
	}

	const entries = Object.entries(normalizedPayload).filter(([column]) => table.columns.some((tableColumn) => tableColumn.name === column));
	if (entries.length === 0) {
		throw new Error('No valid columns provided');
	}

	const columns = entries.map(([column]) => quoteIdentifier(column)).join(', ');
	const placeholders = entries.map(() => '?').join(', ');
	const values = entries.map(([, value]) => value ?? null);

	const statement = database.prepare(
		`INSERT INTO ${quoteIdentifier(table.name)} (${columns}) VALUES (${placeholders});`
	);
	statement.run(values);
	statement.free();
	saveDatabase(database);

	if (!table.primaryKey) {
		return null;
	}

	const providedPrimaryKey = normalizedPayload[table.primaryKey];
	if (providedPrimaryKey !== undefined && providedPrimaryKey !== null) {
		return getRowById(table.name, String(providedPrimaryKey));
	}

	const lastInsertRows = normalizeExecRows(database.exec('SELECT last_insert_rowid() AS id;')[0]);
	const insertedId = String(lastInsertRows[0]?.id ?? '');
	return getRowById(table.name, insertedId);
}

export async function updateRow(tableName: string, rowId: string, payload: Record<string, unknown>): Promise<Record<string, unknown> | null> {
	const table = await ensureTableExists(tableName);
	const database = await getDatabase();

	if (!table.primaryKey) {
		throw new Error(`Table ${tableName} has no primary key`);
	}

	const entries = Object.entries(payload)
		.filter(([column]) => column !== table.primaryKey)
		.filter(([column]) => table.columns.some((tableColumn) => tableColumn.name === column));

	if (entries.length === 0) {
		throw new Error('No valid columns provided');
	}

	const assignments = entries.map(([column]) => `${quoteIdentifier(column)} = ?`).join(', ');
	const values = entries.map(([, value]) => value ?? null);
	values.push(rowId);

	const statement = database.prepare(
		`UPDATE ${quoteIdentifier(table.name)} SET ${assignments} WHERE ${quoteIdentifier(table.primaryKey)} = ?;`
	);
	statement.run(values);
	statement.free();
	saveDatabase(database);

	return getRowById(table.name, rowId);
}

export async function deleteRow(tableName: string, rowId: string): Promise<boolean> {
	const table = await ensureTableExists(tableName);
	const database = await getDatabase();

	if (!table.primaryKey) {
		throw new Error(`Table ${tableName} has no primary key`);
	}

	const statement = database.prepare(
		`DELETE FROM ${quoteIdentifier(table.name)} WHERE ${quoteIdentifier(table.primaryKey)} = ?;`
	);
	statement.run([rowId]);
	statement.free();
	saveDatabase(database);
	return true;
}

export async function selectRows(
	query: string,
	params: Array<string | number | null> = []
): Promise<Record<string, unknown>[]> {
	const database = await getDatabase();
	const statement = database.prepare(query);
	statement.bind(params);

	const rows: Record<string, unknown>[] = [];
	while (statement.step()) {
		rows.push(statement.getAsObject() as Record<string, unknown>);
	}

	statement.free();
	return rows;
}

