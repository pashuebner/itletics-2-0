import { endpoints } from './endpoints';
import { httpClient } from './httpClient';
import { API_BASE_URL } from './config';
import type {
  LoginRequest,
  LoginResponse,
  TestUsersResponse,
  DatabaseQueryOptions,
  DatabaseRowResponse,
  DatabaseRowsResponse,
  DatabaseTablesResponse,
  UploadResponse,
} from './types';

type DatabaseRecord = Record<string, unknown>;

interface TableResource<TRecord extends DatabaseRecord = DatabaseRecord> {
  readonly tableName: string;
  list: (options?: DatabaseQueryOptions) => Promise<DatabaseRowsResponse<TRecord>>;
  get: (rowId: string | number) => Promise<DatabaseRowResponse<TRecord>>;
  create: (payload: DatabaseRecord) => Promise<DatabaseRowResponse<TRecord>>;
  update: (rowId: string | number, payload: DatabaseRecord) => Promise<DatabaseRowResponse<TRecord>>;
  remove: (rowId: string | number) => Promise<void>;
}

function buildTableRowsPath(tableName: string, options: DatabaseQueryOptions = {}): string {
  const params = new URLSearchParams();

  if (options.limit !== undefined) {
    params.set('limit', String(options.limit));
  }

  if (options.offset !== undefined) {
    params.set('offset', String(options.offset));
  }

  if (options.sortBy) {
    params.set('sortBy', options.sortBy);
  }

  if (options.sortOrder) {
    params.set('sortOrder', options.sortOrder);
  }

  const basePath = endpoints.database.tableRows(tableName);
  const queryString = params.toString();
  return queryString ? `${basePath}?${queryString}` : basePath;
}

function createTableResource<TRecord extends DatabaseRecord = DatabaseRecord>(tableName: string): TableResource<TRecord> {
  return {
    tableName,
    list: (options?: DatabaseQueryOptions) =>
      httpClient.get<DatabaseRowsResponse<TRecord>>(buildTableRowsPath(tableName, options)),
    get: (rowId: string | number) =>
      httpClient.get<DatabaseRowResponse<TRecord>>(endpoints.database.tableRow(tableName, rowId)),
    create: (payload: DatabaseRecord) =>
      httpClient.post<DatabaseRowResponse<TRecord>, DatabaseRecord>(endpoints.database.tableRows(tableName), payload),
    update: (rowId: string | number, payload: DatabaseRecord) =>
      httpClient.patch<DatabaseRowResponse<TRecord>, DatabaseRecord>(endpoints.database.tableRow(tableName, rowId), payload),
    remove: (rowId: string | number) =>
      httpClient.delete<void>(endpoints.database.tableRow(tableName, rowId)),
  };
}

const database = {
  listTables: () => httpClient.get<DatabaseTablesResponse>(endpoints.database.tables),

  listRows: <TRecord extends Record<string, unknown> = Record<string, unknown>>(
    tableName: string,
    options?: DatabaseQueryOptions
  ) => httpClient.get<DatabaseRowsResponse<TRecord>>(buildTableRowsPath(tableName, options)),

  getRow: <TRecord extends Record<string, unknown> = Record<string, unknown>>(tableName: string, rowId: string | number) =>
    httpClient.get<DatabaseRowResponse<TRecord>>(endpoints.database.tableRow(tableName, rowId)),

  createRow: <TRecord extends Record<string, unknown> = Record<string, unknown>>(
    tableName: string,
    payload: Record<string, unknown>
  ) => httpClient.post<DatabaseRowResponse<TRecord>, Record<string, unknown>>(endpoints.database.tableRows(tableName), payload),

  updateRow: <TRecord extends Record<string, unknown> = Record<string, unknown>>(
    tableName: string,
    rowId: string | number,
    payload: Record<string, unknown>
  ) => httpClient.patch<DatabaseRowResponse<TRecord>, Record<string, unknown>>(endpoints.database.tableRow(tableName, rowId), payload),

  deleteRow: (tableName: string, rowId: string | number) =>
    httpClient.delete<void>(endpoints.database.tableRow(tableName, rowId)),
};

const userResource = createTableResource('md_user');
const teamResource = createTableResource('team');
const leagueResource = createTableResource('lm_league');
const tournamentResource = createTableResource('tournament');
const playerResource = createTableResource('player');
const matchResource = createTableResource('match');
const eventResource = createTableResource('event');
const refereeResource = createTableResource('referee');

const users = {
  ...userResource,
  roles: createTableResource('md_role'),
  roleAssignments: createTableResource('user_to_role'),
  clubRoleAssignments: createTableResource('club_to_user_to_role'),
};

const teams = {
  ...teamResource,
  leaders: createTableResource('team_leader'),
  members: createTableResource('team_member'),
  memberLinks: createTableResource('team_member_link'),
  memberEventStates: createTableResource('team_member_event_state'),
  memberPenaltyAssignments: createTableResource('team_member_to_penalty_catalog'),
  memberRoleAssignments: createTableResource('team_member_to_user_to_role'),
  roleAssignments: createTableResource('team_to_user_to_role'),
  links: createTableResource('team_link'),
  playerAssignments: createTableResource('player_to_team'),
};

const leagues = {
  ...leagueResource,
  groups: createTableResource('lm_group'),
  groupClasses: createTableResource('lm_group_class'),
  seasons: createTableResource('lm_season'),
  seasonStages: createTableResource('lm_season_stage'),
  seasonStageTypes: createTableResource('lm_season_stage_type'),
  seasonStageAssignments: createTableResource('lm_season_to_season_stage'),
  seasonStageTeams: createTableResource('lm_season_stage_to_team'),
  matchdays: createTableResource('lm_matchday'),
  matchdayMatches: createTableResource('lm_matchday_match'),
  matchdayMatchEvents: createTableResource('lm_matchday_match_event'),
  matchLocations: createTableResource('lm_matchday_match_location'),
  matchLocationSeasons: createTableResource('lm_matchday_match_location_to_season'),
  matchLineups: createTableResource('lm_matchday_match_to_team_lineup'),
  teams: createTableResource('lm_team'),
  teamLinks: createTableResource('lm_team_link'),
  teamSeasonAssignments: createTableResource('lm_team_to_season'),
  teamRoleAssignments: createTableResource('lm_team_to_role_administration'),
  playerAssignments: createTableResource('lm_player_to_league_team'),
  players: createTableResource('lm_player'),
  playerSuspensions: createTableResource('lm_player_suspension'),
  playerDocumentTypes: createTableResource('lm_player_to_document_type'),
  roleAssignments: createTableResource('lm_league_to_role_administration'),
};

const tournaments = {
  ...tournamentResource,
  stages: createTableResource('tournament_to_stage'),
  teams: createTableResource('tournament_to_team'),
  roleAssignments: createTableResource('tournament_to_role_administration'),
};

const players = {
  ...playerResource,
  positions: createTableResource('player_position'),
  teamAssignments: createTableResource('player_to_team'),
  leaguePlayers: createTableResource('lm_player'),
  leaguePlayerAssignments: createTableResource('lm_player_to_league_team'),
  leaguePlayerSuspensions: createTableResource('lm_player_suspension'),
};

const matches = {
  ...matchResource,
  events: createTableResource('match_event'),
  eventCategories: createTableResource('match_event_category'),
  referees: createTableResource('match_to_referee'),
  lineUps: createTableResource('match_to_team_line_up'),
  leagueMatchdays: createTableResource('lm_matchday'),
  leagueMatchdayMatches: createTableResource('lm_matchday_match'),
  leagueMatchdayEvents: createTableResource('lm_matchday_match_event'),
  leagueLocations: createTableResource('lm_matchday_match_location'),
};

const events = {
  ...eventResource,
  categories: createTableResource('event_category'),
  actuals: createTableResource('event_actual'),
  actualParticipants: createTableResource('event_actual_to_team_member'),
  plans: createTableResource('event_plan'),
  planParticipants: createTableResource('event_plan_to_team_member'),
  history: createTableResource('event_history_log'),
};

const referees = {
  ...refereeResource,
  licenceTypes: createTableResource('licence_type'),
  refereeLicences: createTableResource('referee_to_licence_type'),
  refereeTypes: createTableResource('referee_type'),
};

const masterData = {
  countries: createTableResource('country'),
  associations: createTableResource('md_association'),
  clubs: createTableResource('md_club'),
  contractTypes: createTableResource('md_contract_type'),
  matchEventTypes: createTableResource('md_match_event_type'),
  matchTypes: createTableResource('md_match_type'),
  playerDocumentTypes: createTableResource('md_player_document_type'),
  playerPositions: createTableResource('md_player_position'),
  roles: createTableResource('md_role'),
  teamTypes: createTableResource('md_team_type'),
};

const auth = {
  login: (payload: LoginRequest) =>
    httpClient.post<LoginResponse, LoginRequest>(endpoints.auth.login, payload),
  listTestUsers: () => httpClient.get<TestUsersResponse>(endpoints.auth.testUsers),
};

const files = {
  uploadLogo: async (file: File): Promise<UploadResponse> => {
    const formData = new FormData();
    formData.append('file', file);

    const normalizedBase = API_BASE_URL.endsWith('/') ? API_BASE_URL.slice(0, -1) : API_BASE_URL;
    const normalizedPath = endpoints.upload.logo.startsWith('/') ? endpoints.upload.logo : `/${endpoints.upload.logo}`;

    const response = await fetch(`${normalizedBase}${normalizedPath}`, {
      method: 'POST',
      body: formData,
      credentials: 'include',
    });

    if (!response.ok) {
      let errorMessage = `Upload fehlgeschlagen (HTTP ${response.status})`;
      try {
        const errorData = await response.json() as { error?: string };
        if (errorData.error) {
          errorMessage = errorData.error;
        }
      } catch {
        // Wenn die Response kein JSON ist, nutze HTTP-Status als Fallback
        errorMessage = response.statusText || errorMessage;
      }
      throw new Error(errorMessage);
    }

    try {
      return await response.json() as UploadResponse;
    } catch (parseError) {
      throw new Error(`Upload-Response konnte nicht geparst werden: ${parseError instanceof Error ? parseError.message : 'Unbekannter Fehler'}`);
    }
  },
};

export const apiManagement = {
  health: () => httpClient.get<{ status?: string; [key: string]: unknown }>(endpoints.health),
  auth,
  database,
  files,
  users,
  teams,
  leagues,
  tournaments,
  players,
  matches,
  events,
  referees,
  masterData,
} as const;

export type ApiManagement = typeof apiManagement;