declare module 'sql.js' {
  export interface QueryExecResult {
    columns: string[];
    values: Array<Array<string | number | null>>;
  }

  export interface Statement {
    bind(values?: Array<unknown>): void;
    step(): boolean;
    getAsObject(): Record<string, unknown>;
    run(values?: Array<unknown>): void;
    free(): void;
  }

  export interface Database {
    exec(sql: string): QueryExecResult[];
    prepare(sql: string): Statement;
    export(): Uint8Array;
  }

  export interface SqlJsStatic {
    Database: new (data?: Buffer | Uint8Array) => Database;
  }

  export interface SqlJsInitConfig {
    locateFile?: (file: string) => string;
  }

  export default function initSqlJs(config?: SqlJsInitConfig): Promise<SqlJsStatic>;
}
