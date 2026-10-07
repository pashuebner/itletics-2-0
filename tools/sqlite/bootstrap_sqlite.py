import re
import sqlite3
import sys
from pathlib import Path


def extract_primary_keys(sql_text: str) -> dict[str, str]:
    primary_keys: dict[str, str] = {}

    for match in re.finditer(r"ALTER\s+TABLE\s+`(?P<table>[^`]+)`\s+(?P<body>[\s\S]*?);", sql_text, flags=re.IGNORECASE):
        primary_key_match = re.search(r"ADD\s+PRIMARY\s+KEY\s*\(\s*`(?P<column>[^`]+)`\s*\)", match.group("body"), flags=re.IGNORECASE)
        if primary_key_match:
            primary_keys[match.group("table")] = primary_key_match.group("column")

    return primary_keys


def extract_auto_increment_columns(sql_text: str) -> dict[str, str]:
    auto_increment_columns: dict[str, str] = {}

    for match in re.finditer(r"ALTER\s+TABLE\s+`(?P<table>[^`]+)`\s+(?P<body>[\s\S]*?);", sql_text, flags=re.IGNORECASE):
        auto_increment_match = re.search(
            r"MODIFY\s+`(?P<column>[^`]+)`\s+[^;]*?AUTO_INCREMENT",
            match.group("body"),
            flags=re.IGNORECASE,
        )
        if auto_increment_match:
            auto_increment_columns[match.group("table")] = auto_increment_match.group("column")

    return auto_increment_columns


def inject_primary_keys_into_create_tables(
    sql_text: str,
    primary_keys: dict[str, str],
    auto_increment_columns: dict[str, str],
) -> str:
    create_table_pattern = re.compile(
        r"CREATE\s+TABLE\s+`(?P<table>[^`]+)`\s*\((?P<body>[\s\S]*?)\)\s*ENGINE[^;]*;",
        flags=re.IGNORECASE,
    )

    def replace_create_table(match: re.Match[str]) -> str:
        table_name = match.group("table")
        body = match.group("body")
        primary_key = primary_keys.get(table_name)

        if not primary_key:
            return match.group(0)

        auto_increment_column = auto_increment_columns.get(table_name)
        updated_lines: list[str] = []

        for line in body.splitlines():
            column_match = re.match(r"^(?P<indent>\s*)`(?P<column>[^`]+)`\s+(?P<definition>.*?)(?P<comma>,?)\s*$", line)
            if not column_match or column_match.group("column") != primary_key:
                updated_lines.append(line)
                continue

            indent = column_match.group("indent")
            column_name = column_match.group("column")
            definition = column_match.group("definition")
            comma = column_match.group("comma")

            if auto_increment_column == column_name and re.search(r"\b(?:tinyint|smallint|mediumint|bigint|int|integer)\b", definition, flags=re.IGNORECASE):
                updated_lines.append(f"{indent}`{column_name}` INTEGER PRIMARY KEY AUTOINCREMENT{comma}")
                continue

            cleaned_definition = re.sub(r"\bPRIMARY\s+KEY\b", "", definition, flags=re.IGNORECASE)
            cleaned_definition = re.sub(r"\bNOT\s+NULL\b", "", cleaned_definition, flags=re.IGNORECASE)
            cleaned_definition = re.sub(r"\s+", " ", cleaned_definition).strip()
            updated_lines.append(f"{indent}`{column_name}` {cleaned_definition} PRIMARY KEY{comma}".rstrip())

        return f"CREATE TABLE `{table_name}` (\n" + "\n".join(updated_lines) + "\n);"

    return create_table_pattern.sub(replace_create_table, sql_text)


def transform_mysql_dump(sql_text: str) -> str:
    transformed = sql_text

    # Remove MySQL conditional comments and regular line comments.
    transformed = re.sub(r"/\*![\s\S]*?\*/", "", transformed)
    transformed = re.sub(r"--.*?$", "", transformed, flags=re.MULTILINE)

    # Remove DB selection/transaction/session statements.
    transformed = re.sub(r"^\s*CREATE\s+DATABASE[\s\S]*?;\s*$", "", transformed, flags=re.IGNORECASE | re.MULTILINE)
    transformed = re.sub(r"^\s*USE\s+[^;]+;\s*$", "", transformed, flags=re.IGNORECASE | re.MULTILINE)
    transformed = re.sub(r"^\s*START\s+TRANSACTION\s*;\s*$", "", transformed, flags=re.IGNORECASE | re.MULTILINE)
    transformed = re.sub(r"^\s*COMMIT\s*;\s*$", "", transformed, flags=re.IGNORECASE | re.MULTILINE)
    transformed = re.sub(r"^\s*SET\s+[^;]+;\s*$", "", transformed, flags=re.IGNORECASE | re.MULTILINE)

    # Remove optional database qualifiers in table names like `itletics`.`table`.
    transformed = transformed.replace("`itletics`.", "")

    primary_keys = extract_primary_keys(transformed)
    auto_increment_columns = extract_auto_increment_columns(transformed)
    transformed = inject_primary_keys_into_create_tables(transformed, primary_keys, auto_increment_columns)

    # Remove ALTER TABLE blocks that are MySQL-specific or not critical for dev data preview.
    transformed = re.sub(r"ALTER\s+TABLE[\s\S]*?;", "", transformed, flags=re.IGNORECASE)

    # Remove unsupported MySQL syntax bits.
    transformed = re.sub(r"\bAUTO_INCREMENT\b", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bCHARACTER\s+SET\s+\w+", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bCOLLATE\s+\w+", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bCOLLATE\s*=\s*\w+", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bCOMMENT\s+'[^']*'", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bCOMMENT\s*=\s*'[^']*'", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bENGINE\s*=\s*\w+", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bDEFAULT\s+CHARSET\s*=\s*\w+", "", transformed, flags=re.IGNORECASE)
    transformed = re.sub(r"\bDEFAULT\s+NOW\s*\(\s*\)", "DEFAULT CURRENT_TIMESTAMP", transformed, flags=re.IGNORECASE)

    # Normalize CREATE TABLE endings like: ) ENGINE=... DEFAULT CHARSET=...;
    transformed = re.sub(
        r"\)\s*ENGINE\s*=\s*\w+[^;]*;",
        ");",
        transformed,
        flags=re.IGNORECASE,
    )

    # Replace MySQL bit literals with integer literals.
    transformed = transformed.replace("b'0'", "0").replace("b'1'", "1")

    # Cleanup duplicate commas created by removals.
    transformed = re.sub(r",\s*,", ",", transformed)
    transformed = re.sub(r",\s*\)", "\n)", transformed)

    return transformed


def split_sql_statements(sql_text: str) -> list[str]:
    parts = sql_text.split(";")
    statements = []
    for part in parts:
        stmt = part.strip()
        if stmt:
            statements.append(stmt + ";")
    return statements


def main() -> int:
    if len(sys.argv) != 3:
        print("Usage: python bootstrap_sqlite.py <input_sql_file> <output_db_file>")
        return 1

    input_sql = Path(sys.argv[1])
    output_db = Path(sys.argv[2])

    if not input_sql.exists():
        print(f"Input SQL file not found: {input_sql}")
        return 1

    output_db.parent.mkdir(parents=True, exist_ok=True)
    if output_db.exists():
        output_db.unlink()

    raw_sql = input_sql.read_text(encoding="utf-8", errors="ignore")
    sql_for_sqlite = transform_mysql_dump(raw_sql)
    statements = split_sql_statements(sql_for_sqlite)

    conn = sqlite3.connect(output_db)
    cursor = conn.cursor()

    ok = 0
    failed = 0
    failures: list[str] = []

    for statement in statements:
        try:
            cursor.execute(statement)
            ok += 1
        except Exception as ex:  # noqa: BLE001
            failed += 1
            if len(failures) < 15:
                failures.append(f"{ex}: {statement[:220]}")

    conn.commit()
    conn.close()

    print(f"Created SQLite DB: {output_db}")
    print(f"Statements applied: {ok}")
    print(f"Statements skipped: {failed}")
    if failures:
        print("Sample skipped statements:")
        for line in failures:
            print(f"- {line}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
