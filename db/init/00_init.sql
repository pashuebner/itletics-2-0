CREATE DATABASE IF NOT EXISTS itletics;

USE itletics;

-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 10.10.2.7
-- Generation Time: Oct 14, 2021 at 09:17 PM
-- Server version: 8.0.26
-- PHP Version: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sport_stats`
--

-- --------------------------------------------------------

--
-- Table structure for table `club_to_user_to_role`
--

CREATE TABLE `club_to_user_to_role` (
  `club_to_user_to_role_id` int NOT NULL,
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_sign` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `citizenship` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country`, `country_sign`, `citizenship`) VALUES
(1, 'sports_app.common.countries.germany', 'GER', ''),
(2, 'sports_app.common.countries.switzerland', 'CHE', ' '),
(3, 'sports_app.common.countries.austria', 'AUT', ' ');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_id` int NOT NULL,
  `event_category_id` int NOT NULL,
  `event_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_no_participants` int NOT NULL DEFAULT '0',
  `total_no_refuses` int NOT NULL DEFAULT '0',
  `total_no_maybes` int NOT NULL DEFAULT '0',
  `event_comment` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `participation_response_expiration_date` datetime DEFAULT NULL,
  `is_maybe_state_activated` tinyint NOT NULL DEFAULT '0',
  `is_forced_event_refuse_reason_activated` tinyint NOT NULL DEFAULT '0',
  `event_deletion_date` datetime DEFAULT NULL,
  `team_id` int NOT NULL,
  `event_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_actual`
--

CREATE TABLE `event_actual` (
  `event_actual_id` int NOT NULL,
  `event_id` int NOT NULL,
  `event_date_actual_start` date NOT NULL,
  `event_time_actual_start` time DEFAULT NULL,
  `event_date_actual_end` date NOT NULL,
  `event_time_actual_end` time DEFAULT NULL,
  `event_color_actual_hex` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '#ffffff',
  `event_actual_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_actual_to_team_member`
--

CREATE TABLE `event_actual_to_team_member` (
  `event_actual_to_team_member_id` int NOT NULL,
  `event_actual_id` int NOT NULL,
  `team_member_id` int NOT NULL,
  `no_participants` int NOT NULL DEFAULT '0',
  `event_refuse_reason` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `team_member_event_state_id` int NOT NULL,
  `is_set_for_event` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_category`
--

CREATE TABLE `event_category` (
  `event_category_id` int NOT NULL,
  `event_category_description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_category_color_hex` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '#ffffff',
  `event_category_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_category`
--

INSERT INTO `event_category` (`event_category_id`, `event_category_description`, `event_category_color_hex`, `event_category_hash_value`) VALUES
(1, 'Allgemein', '#ff8800', '');

-- --------------------------------------------------------

--
-- Table structure for table `event_history_log`
--

CREATE TABLE `event_history_log` (
  `event_history_log_id` int NOT NULL,
  `event_id` int NOT NULL,
  `event_history_log_date` datetime NOT NULL,
  `event_history_log_reason` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_plan`
--

CREATE TABLE `event_plan` (
  `event_plan_id` int NOT NULL,
  `event_id` int NOT NULL,
  `event_date_plan_start` date NOT NULL,
  `event_time_plan_start` time DEFAULT NULL,
  `event_date_plan_end` date NOT NULL,
  `event_time_plan_end` time DEFAULT NULL,
  `event_color_plan_hex` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '#ffffff',
  `event_plan_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_plan_to_team_member`
--

CREATE TABLE `event_plan_to_team_member` (
  `event_plan_to_team_member_id` int NOT NULL,
  `event_plan_id` int NOT NULL,
  `team_member_id` int NOT NULL,
  `no_participants` int NOT NULL DEFAULT '0',
  `event_refuse_reason` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `team_member_event_state_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `licence_type`
--

CREATE TABLE `licence_type` (
  `licence_type_id` int NOT NULL,
  `licence_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lm_group`
--

CREATE TABLE `lm_group` (
  `group_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Group description.',
  `league_id` int NOT NULL COMMENT 'League reference identifier.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Group related data of league module (Group A, Group B, ...).';

-- --------------------------------------------------------

--
-- Table structure for table `lm_group_class`
--

CREATE TABLE `lm_group_class` (
  `group_class_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'League group class description.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='League group class master data (U13, U16, Seniors, ...).';

--
-- Dumping data for table `lm_group_class`
--

INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (-2, 'unknown');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (1, 'U7');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (2, 'U9');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (3, 'U11');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (4, 'U13');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (5, 'U14');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (6, 'U15');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (7, 'U17');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (8, 'U20');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (9, 'Herren');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (10, 'Frauen');
INSERT INTO `itletics`.`lm_group_class` (`group_class_id`, `description`) VALUES (11, 'Ü35');

-- --------------------------------------------------------

--
-- Table structure for table `lm_league`
--

CREATE TABLE `lm_league` (
  `league_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League description.',
  `logo_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Reference path of league logo.',
  `association_id` int NOT NULL COMMENT 'Association reference identifier.',
  `league_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League hash value.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='League related data of league module.';

--
-- Dumping data for table `lm_league`
--

INSERT INTO `lm_league` (`league_id`, `description`, `logo_path`, `association_id`, `league_hash_value`) VALUES
(27, 'itletics-League', NULL, 1, 'vtdagwsff1qw');

-- --------------------------------------------------------

--
-- Table structure for table `lm_league_to_role_administration`
--

CREATE TABLE `lm_league_to_role_administration` (
  `league_to_role_administration_id` int NOT NULL COMMENT 'Unique identifier.',
  `league_id` int NOT NULL COMMENT 'League reference identifier.',
  `user_id` int NOT NULL COMMENT 'User reference identifier.',
  `role_id` int NOT NULL COMMENT 'Role reference identifier.',
  `parent_league_to_role_administration_id` int DEFAULT NULL COMMENT 'Self referencing identifier of parent relation.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='League related role administration.';

--
-- Dumping data for table `lm_league_to_role_administration`
--

INSERT INTO `lm_league_to_role_administration` (`league_to_role_administration_id`, `league_id`, `user_id`, `role_id`, `parent_league_to_role_administration_id`) VALUES
(42, 27, 2, 15, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday`
--

CREATE TABLE `lm_matchday` (
  `matchday_id` int NOT NULL COMMENT 'Unique identifier.',
  `matchday_no` int NOT NULL COMMENT 'Number of matchday in related season.',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Matchday description.',
  `start_date` datetime DEFAULT NULL COMMENT 'Start date of matchday.',
  `end_date` datetime DEFAULT NULL COMMENT 'End date of matchday.',
  `season_id` int NOT NULL COMMENT 'League season reference identifier.',
  `matchday_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League matchday hash value'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Matchday related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday_match`
--

CREATE TABLE `lm_matchday_match` (
  `matchday_match_id` int NOT NULL COMMENT 'Unique identifier.',
  `match_type_id` int NOT NULL COMMENT 'Match type reference identifier.',
  `matchday_id` int NOT NULL COMMENT 'League matchday reference identifier.',
  `date` date NOT NULL COMMENT 'Matchday date.',
  `start_time` time NOT NULL COMMENT 'Start time of matchday.',
  `end_time` time DEFAULT NULL COMMENT 'End time of matchday.',
  `gates` int NOT NULL COMMENT 'Total gates (goals).',
  `home_team_id` int DEFAULT NULL COMMENT 'Reference identifier of home team.',
  `guest_team_id` int DEFAULT NULL COMMENT 'Reference identifier of guest team.',
  `first_third_goals_home` int NOT NULL DEFAULT '0' COMMENT 'Number goals home team in first third.',
  `first_third_goals_guest` int NOT NULL DEFAULT '0' COMMENT 'Number goals guest team in first third.',
  `second_third_goals_home` int NOT NULL DEFAULT '0' COMMENT 'Number goals home team in second third.',
  `second_third_goals_guest` int NOT NULL DEFAULT '0' COMMENT 'Number goals guest team in second third.',
  `third_third_goals_home` int NOT NULL DEFAULT '0' COMMENT 'Number goals home team in third third.',
  `third_third_goals_guest` int NOT NULL DEFAULT '0' COMMENT 'Number goals guest team in third third.',
  `has_overtime` tinyint(1) NOT NULL COMMENT 'Flag, if match has overtime.',
  `overtime_goals_home` int NOT NULL DEFAULT '0' COMMENT 'Number goals home team in overtime.',
  `overtime_goals_guest` int NOT NULL DEFAULT '0' COMMENT 'Number goals guest team in overtime.',
  `has_penalty` tinyint(1) NOT NULL COMMENT 'Flag, if match has penalty shoot-out',
  `penalty_goals_home` int NOT NULL DEFAULT '0' COMMENT 'Number goals home team in penalty shoot-out.',
  `penalty_goals_guest` int NOT NULL DEFAULT '0' COMMENT 'Number goals guest team in penalty shoot-out.',
  `final_result_home` int NOT NULL DEFAULT '0' COMMENT 'Final result number of goals of home team.',
  `final_result_guest` int NOT NULL DEFAULT '0' COMMENT 'Final result number of goals of guest team.',
  `penalty_minutes_match_home` int NOT NULL DEFAULT '0' COMMENT 'Penalty minutes in match of home team.',
  `penalty_minutes_match_guest` int NOT NULL DEFAULT '0' COMMENT 'Penalty minutes in match of guest team.',
  `penalty_minutes_disciplinary_home` int NOT NULL DEFAULT '0' COMMENT 'Penalty minutes (disciplinary) of home team.',
  `penalty_minutes_disciplinary_guest` int NOT NULL DEFAULT '0' COMMENT 'Penalty minutes (disciplinary) of guest team.',
  `no_players_guest` int NOT NULL COMMENT 'Number players of guest team.',
  `no_players_home` int NOT NULL COMMENT 'Number players of home team.',
  `clock_rotation_back` tinyint(1) NOT NULL COMMENT 'Clock rotation set back.',
  `season_stage_id` int DEFAULT NULL COMMENT 'League season reference identifier',
  `has_started` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Match has started.',
  `has_ended` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Match has ended.',
  `matchday_match_location_id` int NOT NULL COMMENT 'League matchday match location reference identifier.',
  `matchday_match_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League matchday match hash value.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Matchday match related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday_match_event`
--

CREATE TABLE `lm_matchday_match_event` (
  `matchday_match_event_id` int NOT NULL COMMENT 'Unique identifier.',
  `match_event_time` time NOT NULL COMMENT 'Match event time.',
  `matchday_match_id` int NOT NULL COMMENT 'League matchday match reference identifier.',
  `match_event_type_id` int NOT NULL COMMENT 'Match event type reference identifier.',
  `team_id` int DEFAULT NULL COMMENT 'League team reference identifier.',
  `player_id` int DEFAULT NULL COMMENT 'League player reference identifier.',
  `match_event_grouping_id` int DEFAULT NULL COMMENT 'Match event grouping id for league matchday match event grouping.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Matchday to match event related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday_match_location`
--

CREATE TABLE `lm_matchday_match_location` (
  `matchday_match_location_id` int NOT NULL COMMENT 'Unique identifier.',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Location name.',
  `street` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Street name.',
  `zip_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Zip code.',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'City name.',
  `location_info_text_short` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Generic location info text (short).',
  `location_info_text_long` varchar(8000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Generic location info text (long).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Matchday match location related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday_match_location_to_season`
--

CREATE TABLE `lm_matchday_match_location_to_season` (
  `matchday_match_location_to_season_id` int NOT NULL COMMENT 'Unique identifier.',
  `matchday_match_location_matchday_match_location_id` int NOT NULL COMMENT 'Matchday match location reference identifier to lm_matchday_match_location table.',
  `season_id` int NOT NULL COMMENT 'Season reference identifier to lm_season table.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Matchday match location to season related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_matchday_match_to_team_lineup`
--

CREATE TABLE `lm_matchday_match_to_team_lineup` (
  `matchday_match_to_team_lineup_id` int NOT NULL COMMENT 'Unique identifier.',
  `matchday_match_id` int NOT NULL COMMENT 'Matchday match reference identifier.',
  `team_id` int NOT NULL COMMENT 'Team reference identifier.',
  `player_id` int NOT NULL COMMENT 'Player reference identifier.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team lineup to matchday match related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_player`
--

CREATE TABLE `lm_player` (
  `player_id` int NOT NULL COMMENT 'Unique identifier.',
  `pass_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Pass number.',
  `weight` int DEFAULT '0' COMMENT 'Weight of player.',
  `length` int DEFAULT '0' COMMENT 'Length of player.',
  `handed` int DEFAULT NULL COMMENT 'Default hand of player (left-handed, right-handed).',
  `contract_type_id` int DEFAULT NULL COMMENT 'Contract type reference identifier.',
  `player_position_id` int NOT NULL COMMENT 'Player position reference identifier.',
  `picture_reference_path` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Reference path to player picture.',
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'First name of player.',
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Last name of player.',
  `user_id` int DEFAULT NULL COMMENT 'User reference identifier.',
  `birth_date` date DEFAULT NULL COMMENT 'Date of birth.',
  `birth_place` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place of birth.',
  `has_lifetime_suspension` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag, if a player has a lifetime suspension and is never allowed to play.',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Flag, if a player is active.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Player related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_player_suspension`
--

CREATE TABLE `lm_player_suspension` (
  `player_suspension_id` int NOT NULL COMMENT 'Unique identifier.',
  `player_id` int NOT NULL COMMENT 'Player reference identifier.',
  `season_id` int NOT NULL COMMENT 'Season reference identifier',
  `suspension_info_text` varchar(8000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Freetext info of suspension.',
  `is_full_season_suspension` tinyint(1) NOT NULL COMMENT 'Flag, if a player is suspended for the full season.',
  `no_matchdays_suspended` int NOT NULL DEFAULT '1' COMMENT 'Number of matchdays a player is suspended.',
  `suspension_start_date` date DEFAULT NULL COMMENT 'Start date of suspension.',
  `suspension_end_date` date DEFAULT NULL COMMENT 'End date of suspension.',
  `is_finished` tinyint(1) NOT NULL COMMENT 'Flag, if a suspension is finished.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Player suspension related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_player_to_document_type`
--

CREATE TABLE `lm_player_to_document_type` (
  `player_to_document_type_id` int NOT NULL COMMENT 'Unique identifier.',
  `player_id` int NOT NULL COMMENT 'League player reference identifier.',
  `player_document_type_id` int NOT NULL COMMENT 'League player document type reference identifier.',
  `player_document_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Reference path to player document.',
  `upload_date` date NOT NULL COMMENT 'Date, document was uploaded.',
  `valid_to_date` date DEFAULT NULL COMMENT 'Date until document is valid to. If set, column can_expire has to be set to true.',
  `can_expire` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Flag, if a document can expire.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Player to document type relation data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_player_to_league_team`
--

CREATE TABLE `lm_player_to_league_team` (
  `player_to_team_id` int NOT NULL COMMENT 'Unique identifier.',
  `player_id` int NOT NULL COMMENT 'League player reference identifier.',
  `team_id` int NOT NULL COMMENT 'League team reference identifier.',
  `player_position_id` int NOT NULL COMMENT 'Player position reference identifier. Reference to master data table in master_module db has to be ensured by code.',
  `player_no` int NOT NULL COMMENT 'Player number in team.',
  `is_team_captain` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag, if a player is captain of the team.',
  `is_team_assistant_captain` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag, if a player is assistant captain of the team.'
) ;

-- --------------------------------------------------------

--
-- Table structure for table `lm_season`
--

CREATE TABLE `lm_season` (
  `season_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Season description.',
  `start_year` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Start year of season.',
  `end_year` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'End year of season.',
  `no_matchdays` int NOT NULL DEFAULT '0' COMMENT 'No matchdays in season.',
  `league_id` int NOT NULL COMMENT 'League reference identifier.',
  `group_class_id` int NOT NULL COMMENT 'League group class reference identifier.',
  `is_score_mode` tinyint(1) NOT NULL COMMENT 'Flag, if score mode is used for win.',
  `is_extended_mode` tinyint(1) NOT NULL COMMENT 'Flag, if is extended application mode.',
  `is_public_visible` tinyint(1) NOT NULL COMMENT 'Flag, if season is public visible.',
  `score_mode_calculation_code` smallint NOT NULL COMMENT 'Calculation code of season score.',
  `season_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_match_sessions` int NOT NULL COMMENT 'Number of match sessions (2/2, 3/3,4/4).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Season related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_season_stage`
--

CREATE TABLE `lm_season_stage` (
  `season_stage_id` int NOT NULL COMMENT 'Unique identifier',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Season stage description.',
  `max_no_teams` int NOT NULL COMMENT 'Maximum number of teams allowed.',
  `season_stage_type_id` int NOT NULL COMMENT 'League season stage type reference identifier.',
  `stage_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League stage hash value.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Season stage related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_season_stage_to_team`
--

CREATE TABLE `lm_season_stage_to_team` (
  `season_stage_to_team_id` int NOT NULL COMMENT 'Unique identifier.',
  `season_stage_id` int NOT NULL COMMENT 'League season stage reference identifier.',
  `team_id` int NOT NULL COMMENT 'League team reference identifier.',
  `points` int NOT NULL COMMENT 'Number of points.',
  `goals` int NOT NULL COMMENT 'Number of goals.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Season stage to team related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_season_stage_type`
--

CREATE TABLE `lm_season_stage_type` (
  `season_stage_type_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Season stage type description.',
  `level` int NOT NULL COMMENT 'Stage type level of season.',
  `parent_level` int DEFAULT NULL COMMENT 'Parent stage type level of season.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Season stage type related data of league module.';

--
-- Dumping data for table `lm_season_stage_type`
--

INSERT INTO `lm_season_stage_type` (`season_stage_type_id`, `description`, `level`, `parent_level`) VALUES
(1, 'Manual Entry', -1, NULL),
(2, 'Group phase', 4, 3),
(3, 'Round of Last', 3, 2),
(4, 'Quarter Finals', 2, 1),
(5, 'Semi Finals', 1, 0),
(6, 'Final', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lm_season_to_season_stage`
--

CREATE TABLE `lm_season_to_season_stage` (
  `season_to_season_stage_id` int NOT NULL COMMENT 'Unique identifier.',
  `season_stage_id` int NOT NULL COMMENT 'League season stage reference identifier.',
  `season_id` int NOT NULL COMMENT 'League season reference identifier.',
  `max_no_teams` int NOT NULL COMMENT 'Maximum number of teams allowed.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Season to season stage relation data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_team`
--

CREATE TABLE `lm_team` (
  `team_id` int NOT NULL COMMENT 'Unique identifier.',
  `team` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Team description.',
  `team_abbreviation` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Team abbreviation.',
  `no_players` int NOT NULL COMMENT 'No players in team.',
  `logo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Reference path to team logo.',
  `team_type_id` int NOT NULL COMMENT 'Team type reference identifier.',
  `club_id` int NOT NULL COMMENT 'Club reference identifier.',
  `team_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'league team hash value.',
  `team_info_text` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Freetext info of team.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_team_link`
--

CREATE TABLE `lm_team_link` (
  `team_link_id` int NOT NULL COMMENT 'Unique identifier.',
  `team_id` int NOT NULL COMMENT 'League team reference identifier.',
  `team_link_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Link description.',
  `team_link_creation_date` datetime NOT NULL COMMENT 'Creation date of link.',
  `team_link_sent_date` datetime DEFAULT NULL COMMENT 'Sent date of link.',
  `team_link_expiration_date` datetime DEFAULT NULL COMMENT 'Expiration date of link.',
  `team_link_hash_value` char(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'League team link hash value.',
  `team_link_sent` datetime DEFAULT NULL COMMENT 'DateTime-Flag to indicate, if link has been sent.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team related link data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_team_to_role_administration`
--

CREATE TABLE `lm_team_to_role_administration` (
  `team_to_role_administration_id` int NOT NULL COMMENT 'Unique identifier.',
  `team_id` int NOT NULL COMMENT 'Team reference identifier.',
  `user_id` int NOT NULL COMMENT 'User reference identifier.',
  `role_id` int NOT NULL COMMENT 'Role reference identifier.',
  `parent_team_to_role_administration_id` int DEFAULT NULL COMMENT 'Self referencing identifier of parent relation.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team related role administration.';

-- --------------------------------------------------------

--
-- Table structure for table `lm_team_to_season`
--

CREATE TABLE `lm_team_to_season` (
  `team_to_season_id` int NOT NULL COMMENT 'Unique identifier.',
  `team_id` int NOT NULL COMMENT 'League team reference identifier.',
  `season_id` int NOT NULL COMMENT 'League season reference identifier.',
  `group_id` int NOT NULL COMMENT 'League group reference identifier.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team to season related data of league module.';

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int NOT NULL COMMENT 'Unique identifier.',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Location name.',
  `street` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Street name.',
  `zip_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Zip code.',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'City name.',
  `location_info_text_short` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Generic location info text (short).',
  `location_info_text_long` varchar(8000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Generic location info text (long).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location_to_tournament`
--

CREATE TABLE `location_to_tournament` (
  `location_to_tournament_id` int NOT NULL COMMENT 'Unique identifier.',
  `location_id` int NOT NULL COMMENT 'Location reference identifier to location table.',
  `tournament_id` int NOT NULL COMMENT 'Tournament reference identifier to tournament table.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Location to tournament related data of tournament module.';

-- --------------------------------------------------------

--
-- Table structure for table `match`
--

CREATE TABLE `match` (
  `match_id` int NOT NULL,
  `match_type_id` int NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `organizer` varchar(100) CHARACTER SET latin1 NOT NULL,
  `league_id` int DEFAULT NULL,
  `gates` int NOT NULL,
  `home_team_id` int DEFAULT NULL,
  `guest_team_id` int DEFAULT NULL,
  `first_third_goals_home` int NOT NULL DEFAULT '0',
  `first_third_goals_guest` int NOT NULL DEFAULT '0',
  `second_third_goals_home` int NOT NULL DEFAULT '0',
  `second_third_goals_guest` int NOT NULL DEFAULT '0',
  `third_third_goals_home` int NOT NULL DEFAULT '0',
  `third_third_goals_guest` int NOT NULL DEFAULT '0',
  `has_overtime` tinyint(1) NOT NULL,
  `overtime_goals_home` int NOT NULL DEFAULT '0',
  `overtime_goals_guest` int NOT NULL DEFAULT '0',
  `has_penalty` tinyint(1) NOT NULL,
  `penalty_goals_home` int NOT NULL DEFAULT '0',
  `penalty_goals_guest` int NOT NULL DEFAULT '0',
  `final_result_home` int NOT NULL DEFAULT '0',
  `final_result_guest` int NOT NULL DEFAULT '0',
  `penalty_minutes_match_home` int NOT NULL DEFAULT '0',
  `penalty_minutes_match_guest` int NOT NULL DEFAULT '0',
  `penalty_minutes_disciplinary_home` int NOT NULL DEFAULT '0',
  `penalty_minutes_disciplinary_guest` int NOT NULL DEFAULT '0',
  `league_reception_date` date DEFAULT NULL,
  `no_players_guest` int NOT NULL,
  `no_players_home` int NOT NULL,
  `clock_rotation_back` tinyint(1) NOT NULL,
  `stage_id` int DEFAULT NULL,
  `has_started` tinyint(1) NOT NULL DEFAULT '0',
  `has_ended` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int NOT NULL,
  `match_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `match_event`
--

CREATE TABLE `match_event` (
  `match_event_id` int NOT NULL,
  `match_event_time` time NOT NULL,
  `match_id` int NOT NULL,
  `match_event_type_id` int NOT NULL,
  `player_id` int DEFAULT NULL,
  `match_event_grouping_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `match_event_category`
--

CREATE TABLE `match_event_category` (
  `match_event_category_id` int NOT NULL,
  `match_event_category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `match_event_category_type_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `match_event_category`
--

INSERT INTO `match_event_category` (`match_event_category_id`, `match_event_category`, `match_event_category_type_code`) VALUES
(1, 'Game', 'game'),
(2, 'Penalty', 'penalty'),
(3, 'Goal', 'goal'),
(4, 'Special', 'special'),
(5, 'Clock', 'clock');

-- --------------------------------------------------------

--
-- Table structure for table `match_to_referee`
--

CREATE TABLE `match_to_referee` (
  `match_to_referee_id` int NOT NULL,
  `match_id` int NOT NULL,
  `referee_no` int NOT NULL,
  `referee_id` int NOT NULL,
  `referee_type_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `match_to_team_line_up`
--

CREATE TABLE `match_to_team_line_up` (
  `match_to_team_line_up_id` int NOT NULL,
  `match_id` int NOT NULL,
  `team_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_position_id` int NOT NULL,
  `row_no` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `md_association`
--

CREATE TABLE `md_association` (
  `association_id` int NOT NULL,
  `association` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `association_abbreviation` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_id` int NOT NULL COMMENT 'Country reference identifier.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_association`
--

INSERT INTO `md_association` (`association_id`, `association`, `association_abbreviation`, `logo_path`, `country_id`) VALUES
(1, 'DRIV Inlinehockey', 'DRIV', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `md_club`
--

CREATE TABLE `md_club` (
  `club_id` int NOT NULL,
  `club` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `club_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `md_club` (`club_id`, `club`, `club_hash_value`) VALUES
(1, 'Standard-Club', '4f46dcf860a929f7a867282c9ef125ba');


-- --------------------------------------------------------

--
-- Table structure for table `md_contract_type`
--

CREATE TABLE `md_contract_type` (
  `contract_type_id` int NOT NULL,
  `contract_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `md_match_event_type`
--

CREATE TABLE `md_match_event_type` (
  `match_event_type_id` int NOT NULL,
  `match_event_type` varchar(100) CHARACTER SET utf8 NOT NULL,
  `match_event_type_code` varchar(10) CHARACTER SET utf8 NOT NULL,
  `data_type_code` int NOT NULL COMMENT '0 = NVARCHAR\n1 = BIGINT\n2 = DATETIME\n...',
  `match_event_category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `md_match_type`
--

CREATE TABLE `md_match_type` (
  `match_type_id` int NOT NULL,
  `match_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_match_type`
--

INSERT INTO `md_match_type` (`match_type_id`, `match_type`) VALUES
(1, 'Regular');

-- --------------------------------------------------------

--
-- Table structure for table `md_player_document_type`
--

CREATE TABLE `md_player_document_type` (
  `player_document_type_id` int NOT NULL COMMENT 'Unique identifier.',
  `player_document_type_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique identifying player document type code.',
  `player_document_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Player document type description.',
  `sort_order` int NOT NULL COMMENT 'Sort order for display order.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Player document type related data.';

--
-- Dumping data for table `md_player_document_type`
--

INSERT INTO `md_player_document_type` (`player_document_type_id`, `player_document_type_code`, `player_document_type`, `sort_order`) VALUES
(1, '001', 'Athletenvereinbarung', 1),
(2, '002', 'Schiedsvereinbarung', 1),
(3, '003', 'Ehrenerklärung', 1),
(4, '004', 'Arztbescheinigung', 1),
(5, '005', 'Datenschutzerklärung', 1),
(6, '006', 'Genehmigung Medienerstellung', 1);

-- --------------------------------------------------------

--
-- Table structure for table `md_player_position`
--

CREATE TABLE `md_player_position` (
  `player_position_id` int NOT NULL,
  `player_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_player_position`
--

INSERT INTO `md_player_position` (`player_position_id`, `player_position`) VALUES
(1, 'sports_app.common.label.goalkeeper'),
(2, 'sports_app.common.label.defense'),
(3, 'sports_app.common.label.forward');

-- --------------------------------------------------------

--
-- Table structure for table `md_role`
--

CREATE TABLE `md_role` (
  `role_id` int NOT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_role`
--

INSERT INTO `md_role` (`role_id`, `role`) VALUES
(1, 'Admin'),
(2, 'Trainer'),
(3, 'Player'),
(4, 'Teammanager'),
(5, 'Team carer'),
(6, 'Board'),
(7, 'Bankdienst'),
(8, 'Ligenleitung'),
(9, 'Referee'),
(10, 'League committee'),
(11, 'Obmann'),
(12, 'Jugendobmann'),
(13, 'Schiedsrichterobmann'),
(14, 'Landestrainer'),
(15, 'Turnierleitung'),
(16, 'Team - Trainer'),
(17, 'Club - Admin'),
(18, 'Standard');

-- --------------------------------------------------------

--
-- Table structure for table `md_team_type`
--

CREATE TABLE `md_team_type` (
  `team_type_id` int NOT NULL,
  `team_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_team_type`
--

INSERT INTO `md_team_type` (`team_type_id`, `team_type`) VALUES
(1, 'Standard-Team');

-- --------------------------------------------------------

--
-- Table structure for table `md_user`
--

CREATE TABLE `md_user` (
  `user_id` int NOT NULL,
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `street` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `zip_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `telephone_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT NOW(),
  `shutdown_date` datetime DEFAULT NULL,
  `user_info` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_verified` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `md_user`
--

INSERT INTO `md_user` (`user_id`, `login_name`, `password`, `email`, `first_name`, `last_name`, `street`, `zip_code`, `city`, `country_id`, `telephone_no`, `mobile_no`, `birth_date`, `birth_place`, `creation_date`, `shutdown_date`, `user_info`, `user_hash_value`, `is_verified`) VALUES
(1, 'stefan', '$2y$13$5jgI6iweYWf0imf9w46SnuqorOxMHrDjQFP5UeqjNnThVCf8OoRcO', 'stefan@stefans-entwicklerecke.de', 'Stefan', 'Müller', 'Blub 123', '87600', 'Kaufbeuren', 1, '12345', '0123456789123', '1991-12-30', 'Kaufbeuren', '2015-10-10 00:00:00', NULL, NULL, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 1),
(2, 'alexuhrle', '$2y$13$PmiQz.I/9M9N0JjvcV8nRuiKDGkgR0/8jbjwGEwfg0z6zBRlkmA2G', 'alex.uhrle@web.de', 'Alex', 'Uhrle', 'Teststrasse 1', '87600', 'Kaufbeuren', 1, '01234', '01234', '1975-01-01', 'Kaufbeuren', '2016-01-10 15:38:28', NULL, NULL, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 1),
(3, 'juergen', '$2y$13$D36l0BaavyvnU7XI/8WnTe0wj0.rNTPiouX9pfokkxLXY8R6YkRLe', 'jguehrer@web.de', 'Jürgen', 'Gührer', 'Teststrasse 1', '86150', 'Augsburg', 1, '01234', '01234', '1966-01-05', 'Augsburg', '2016-01-10 15:55:20', NULL, NULL, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 1),
(43, 'PascalHuebner', '$2y$13$ZKr1MIZxQHMQIFy/coBwsuyOD96hZAhyqe29xfmZNcCjonbXrSa4.', 'info@impredia.de', 'Pascal', 'Hübner', NULL, NULL, NULL, NULL, NULL, NULL, '2000-01-01', NULL, '2021-05-24 18:57:02', NULL, NULL, 'xyz67usimqva', 1),
(44, 'sreutter75', '$2y$13$Ibbi3l6DSCjwFsjCAN6m4.lSLlnn3g/KUNw9MYeV1snLcoL0p8Why', 'sreutter75@gmail.com', 'Sven', 'Reutter', NULL, NULL, NULL, NULL, NULL, NULL, '2000-01-01', NULL, '2021-06-01 20:18:09', NULL, NULL, 'xcsml699ng89', 1),
(50, 'grebestein@prhl.de', 'test', 'grebestein@prhl.de', 'Tobi', 'Grebestein', 'Mussterstraße 12', '322342', 'Teststadt', NULL, NULL, NULL, '2005-01-01', NULL, '2021-06-24 20:28:09', NULL, NULL, 'ldhcb5xngz4f', 0);

-- --------------------------------------------------------

--
-- Table structure for table `official`
--

CREATE TABLE `official` (
  `official_id` int NOT NULL,
  `club_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `official_position`
--

CREATE TABLE `official_position` (
  `official_position_id` int NOT NULL,
  `official_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `official_to_position`
--

CREATE TABLE `official_to_position` (
  `official_to_position_id` int NOT NULL,
  `official_id` int NOT NULL,
  `official_position_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parent_to_child_stage_relation`
--

CREATE TABLE `parent_to_child_stage_relation` (
  `parent_to_child_stage_relation_id` int NOT NULL,
  `parent_stage_id` int NOT NULL,
  `child_stage_home_id` int NOT NULL,
  `rank_home` int NOT NULL,
  `child_stage_guest_id` int NOT NULL,
  `rank_guest` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `penalty_catalog`
--

CREATE TABLE `penalty_catalog` (
  `penalty_catalog_id` int NOT NULL,
  `penalty_catalog_description` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `penalty_fee` decimal(18,2) DEFAULT '0.00',
  `penalty_catalog_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `permission_id` int NOT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`permission_id`, `permission`) VALUES
(1, 'ROLE_BACKEND_LOGIN'),
(2, 'ROLE_CREATE_PLAYER'),
(3, 'ROLE_CREATE_TEAM'),
(4, 'ROLE_EDIT_OWN_PROFILE'),
(5, 'ROLE_MANAGE_TEAM_PLAYERS'),
(6, 'ROLE_ADD_PLAYER_TO_TEAM'),
(7, 'ROLE_CREATE_STATISTICS'),
(8, 'ROLE_ADMIN'),
(9, 'ROLE_EDIT_MATCH'),
(10, 'ROLE_CREATE_TOURNAMENT'),
(11, 'ROLE_CREATE_EVENT'),
(12, 'ROLE_GENERATE_TEAM_LINKS'),
(13, 'ROLE_MANAGE_TEAM'),
(14, 'ROLE_MANAGE_TOURNAMENT'),
(15, 'ROLE_MANAGE_TEAM_LINKS'),
(16, 'ROLE_CREATE_LEAGUE');

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `pass_no` varchar(20) CHARACTER SET latin1 NOT NULL,
  `weight` int DEFAULT '0',
  `length` int DEFAULT '0',
  `handed` int DEFAULT NULL,
  `contract_type_id` int DEFAULT NULL,
  `player_position_id` int NOT NULL,
  `picture_reference_path` longtext CHARACTER SET latin1,
  `first_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `user_id` int DEFAULT NULL,
  `birth_date` date DEFAULT NULL COMMENT 'Date of birth.',
  `birth_place` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place of birth.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_position`
--

CREATE TABLE `player_position` (
  `player_position_id` int NOT NULL,
  `player_position` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `player_position`
--

INSERT INTO `player_position` (`player_position_id`, `player_position`) VALUES
(1, 'sports_app.common.label.goalkeeper'),
(2, 'sports_app.common.label.defence'),
(3, 'sports_app.common.label.forward');

-- --------------------------------------------------------

--
-- Table structure for table `player_to_team`
--

CREATE TABLE `player_to_team` (
  `player_to_team_id` int NOT NULL,
  `player_id` int NOT NULL,
  `team_id` int NOT NULL,
  `player_position_id` int NOT NULL,
  `player_no` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referee`
--

CREATE TABLE `referee` (
  `referee_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referee_to_licence_type`
--

CREATE TABLE `referee_to_licence_type` (
  `referee_to_licence_type_id` int NOT NULL,
  `referee_id` int NOT NULL,
  `licence_type_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referee_type`
--

CREATE TABLE `referee_type` (
  `referee_type_id` int NOT NULL,
  `referee_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_to_permission`
--

CREATE TABLE `role_to_permission` (
  `role_to_permission_id` int NOT NULL,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_to_permission`
--

INSERT INTO `role_to_permission` (`role_to_permission_id`, `role_id`, `permission_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 8),
(8, 7, 9),
(11, 16, 11),
(12, 18, 1),
(13, 18, 4),
(14, 15, 12),
(15, 7, 7),
(16, 15, 9),
(17, 1, 13),
(18, 15, 13),
(19, 15, 5),
(20, 15, 6),
(21, 7, 1),
(22, 15, 5),
(23, 15, 6),
(24, 15, 2),
(25, 4, 5),
(26, 4, 2),
(27, 15, 14),
(28, 15, 10),
(29, 8, 16),
(30, 8, 15),
(31, 15, 15),
(34, 4, 13);

-- --------------------------------------------------------

--
-- Table structure for table `stage`
--

CREATE TABLE `stage` (
  `stage_id` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stage_type_id` int NOT NULL,
  `max_no_teams` int NOT NULL,
  `stage_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stage_to_team`
--

CREATE TABLE `stage_to_team` (
  `stage_to_team_id` int NOT NULL,
  `stage_id` int NOT NULL,
  `team_id` int NOT NULL,
  `points` int NOT NULL,
  `goals` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stage_type`
--

CREATE TABLE `stage_type` (
  `stage_type_id` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `level` int NOT NULL,
  `parent_level` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stage_type`
--

INSERT INTO `stage_type` (`stage_type_id`, `description`, `level`, `parent_level`) VALUES
(1, 'Manual Entry', -1, NULL),
(2, 'Group Phase', 4, 3),
(3, 'Round of Last', 3, 2),
(4, 'Quarter Finals', 2, 1),
(5, 'Semi Finals', 1, 0),
(6, 'Final', 0, NULL),
(7, 'Intermediate Round', 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `team_id` int NOT NULL,
  `team` varchar(100) CHARACTER SET latin1 NOT NULL,
  `no_players` int NOT NULL,
  `logo_path` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `league_id` int DEFAULT NULL,
  `team_type_id` int NOT NULL,
  `club_id` int NOT NULL,
  `team_hash_value` char(64) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_leader`
--

CREATE TABLE `team_leader` (
  `team_leader_id` int NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_leader`
--

INSERT INTO `team_leader` (`team_leader_id`, `first_name`, `last_name`, `email`, `telephone_no`, `mobile_no`) VALUES
(1, 'Max', 'Mustermann', 'mu.stefan@googlemail.com', '012345', '01235');

-- --------------------------------------------------------

--
-- Table structure for table `team_link`
--

CREATE TABLE `team_link` (
  `team_link_id` bigint NOT NULL,
  `team_team_id` int NOT NULL,
  `team_link_description` varchar(255) CHARACTER SET utf8 NOT NULL,
  `team_link_creation_date` datetime NOT NULL,
  `team_link_expiration_date` datetime DEFAULT NULL,
  `team_link_hash_value` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `team_member`
--

CREATE TABLE `team_member` (
  `team_member_id` int NOT NULL,
  `user_id` int NOT NULL,
  `team_id` int NOT NULL,
  `team_member_hash_value` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `team_member_event_state`
--

CREATE TABLE `team_member_event_state` (
  `team_member_event_state_id` int NOT NULL,
  `team_member_event_state_description` varchar(50) CHARACTER SET utf8 NOT NULL,
  `is_maybe_state` tinyint NOT NULL DEFAULT '0',
  `is_event_refuse_state` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team_member_event_state`
--

INSERT INTO `team_member_event_state` (`team_member_event_state_id`, `team_member_event_state_description`, `is_maybe_state`, `is_event_refuse_state`) VALUES
(1, 'Zusagen', 0, 0),
(2, 'Absagen', 0, 1),
(3, 'Vielleicht', 1, 0),
(5, 'Nicht abgestimmt', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `team_member_link`
--

CREATE TABLE `team_member_link` (
  `team_member_link_id` bigint NOT NULL,
  `team_member_id` int NOT NULL,
  `team_member_link_description` varchar(255) CHARACTER SET utf8 NOT NULL,
  `team_member_link_creation_date` datetime NOT NULL,
  `team_member_link_expiration_date` datetime DEFAULT NULL,
  `team_member_link_hash_value` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `team_member_to_penalty_catalog`
--

CREATE TABLE `team_member_to_penalty_catalog` (
  `team_member_to_penalty_catalog_id` int NOT NULL,
  `penalty_catalog_id` int NOT NULL,
  `team_member_id` int NOT NULL,
  `penalty_creation_date` datetime NOT NULL,
  `penalty_payment_date` datetime DEFAULT NULL,
  `penalty_fee` decimal(18,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_member_to_user_to_role`
--

CREATE TABLE `team_member_to_user_to_role` (
  `team_member_to_user_to_role_id` int NOT NULL,
  `team_member_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_to_user_to_role`
--

CREATE TABLE `team_to_user_to_role` (
  `team_to_user_to_role_id` int NOT NULL,
  `team_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tournament`
--

CREATE TABLE `tournament` (
  `tournament_id` int NOT NULL COMMENT 'Unique identifier.',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tournament description.',
  `start_date` datetime NOT NULL COMMENT 'Start date of tournament.',
  `end_date` datetime NOT NULL COMMENT 'End date of tournament.',
  `max_no_teams` int NOT NULL COMMENT 'Maximum number of teams that can participate at the tournament.',
  `is_score_mode` tinyint(1) NOT NULL COMMENT 'Flag, if score mode is used for win.',
  `is_extended_mode` tinyint(1) NOT NULL COMMENT 'Flag, if is extended application mode.',
  `is_public_visible` tinyint(1) NOT NULL COMMENT 'Flag, if tournament is public visible.',
  `score_mode_calculation_code` smallint NOT NULL COMMENT 'Calculation code of tournament score.',
  `tournament_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tournament hash value for link generation.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tournament`
--

INSERT INTO `tournament` (`tournament_id`, `description`, `start_date`, `end_date`, `max_no_teams`, `is_score_mode`, `is_extended_mode`, `is_public_visible`, `score_mode_calculation_code`, `tournament_hash_value`) VALUES
(53, 'toast_Turnier', '2021-07-25 00:00:00', '2021-07-28 00:00:00', 8, 1, 1, 1, 0, 'xjtzslya2qr6');

-- --------------------------------------------------------

--
-- Table structure for table `tournament_to_role_administration`
--

CREATE TABLE `tournament_to_role_administration` (
  `tournament_to_role_administration_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `tournament_id` int NOT NULL,
  `parent_tournament_to_role_administration_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tournament_to_role_administration`
--

INSERT INTO `tournament_to_role_administration` (`tournament_to_role_administration_id`, `user_id`, `role_id`, `tournament_id`, `parent_tournament_to_role_administration_id`) VALUES
(107, 2, 15, 53, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tournament_to_stage`
--

CREATE TABLE `tournament_to_stage` (
  `tournament_to_stage_id` int NOT NULL,
  `stage_id` int NOT NULL,
  `tournament_id` int NOT NULL,
  `max_no_teams` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tournament_to_team`
--

CREATE TABLE `tournament_to_team` (
  `tournament_to_team_id` int NOT NULL,
  `tournament_id` int NOT NULL,
  `team_id` int NOT NULL,
  `team_leader_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trainer`
--

CREATE TABLE `trainer` (
  `trainer_id` int NOT NULL,
  `trainer_type_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trainer`
--

INSERT INTO `trainer` (`trainer_id`, `trainer_type_id`, `user_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `trainer_to_licence_type`
--

CREATE TABLE `trainer_to_licence_type` (
  `trainer_to_licence_type_id` int NOT NULL,
  `trainer_id` int NOT NULL,
  `licence_type_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trainer_to_team`
--

CREATE TABLE `trainer_to_team` (
  `trainer_to_team_id` int NOT NULL,
  `trainer_id` int NOT NULL,
  `team_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trainer_type`
--

CREATE TABLE `trainer_type` (
  `trainer_type_id` int NOT NULL,
  `trainer_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trainer_type`
--

INSERT INTO `trainer_type` (`trainer_type_id`, `trainer_type`) VALUES
(1, 'Test');

-- --------------------------------------------------------

--
-- Table structure for table `user_link`
--

CREATE TABLE `user_link` (
  `user_link_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `user_link_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_link_creation_date` datetime NOT NULL,
  `user_link_expiration_date` datetime DEFAULT NULL,
  `user_link_hash_value` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_to_role`
--

CREATE TABLE `user_to_role` (
  `user_to_role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_to_role`
--

INSERT INTO `user_to_role` (`user_to_role_id`, `user_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 1, 15),
(5, 2, 15),
(6, 3, 15),
(7, 1, 8),
(8, 2, 8),
(9, 3, 8),
(10, 43, 1),
(11, 43, 15),
(12, 43, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `club_to_user_to_role`
--
ALTER TABLE `club_to_user_to_role`
  ADD PRIMARY KEY (`club_to_user_to_role_id`),
  ADD KEY `fk_club_to_user_to_role_club2_idx` (`club_id`),
  ADD KEY `fk_club_to_user_to_role_user1_idx` (`user_id`),
  ADD KEY `fk_club_to_user_to_role_role1_idx` (`role_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `fk_event_event_category1_idx` (`event_category_id`),
  ADD KEY `fk_event_team1_idx` (`team_id`);

--
-- Indexes for table `event_actual`
--
ALTER TABLE `event_actual`
  ADD PRIMARY KEY (`event_actual_id`),
  ADD KEY `fk_event_actual_event1_idx` (`event_id`);

--
-- Indexes for table `event_actual_to_team_member`
--
ALTER TABLE `event_actual_to_team_member`
  ADD PRIMARY KEY (`event_actual_to_team_member_id`),
  ADD KEY `fk_event_actual_to_team_member_event_actual1_idx` (`event_actual_id`),
  ADD KEY `fk_event_actual_to_team_member_team_member1_idx` (`team_member_id`),
  ADD KEY `fk_event_actual_to_team_member_team_member_event_state1_idx` (`team_member_event_state_id`);

--
-- Indexes for table `event_category`
--
ALTER TABLE `event_category`
  ADD PRIMARY KEY (`event_category_id`);

--
-- Indexes for table `event_history_log`
--
ALTER TABLE `event_history_log`
  ADD PRIMARY KEY (`event_history_log_id`),
  ADD KEY `fk_event_history_log_event1_idx` (`event_id`),
  ADD KEY `fk_event_history_log_user1_idx` (`user_id`);

--
-- Indexes for table `event_plan`
--
ALTER TABLE `event_plan`
  ADD PRIMARY KEY (`event_plan_id`),
  ADD KEY `fk_event_plan_event1_idx` (`event_id`);

--
-- Indexes for table `event_plan_to_team_member`
--
ALTER TABLE `event_plan_to_team_member`
  ADD PRIMARY KEY (`event_plan_to_team_member_id`),
  ADD KEY `fk_event_plan_to_team_member_event_plan1_idx` (`event_plan_id`),
  ADD KEY `fk_event_plan_to_team_member_team_member1_idx` (`team_member_id`),
  ADD KEY `fk_event_plan_to_team_member_team_member_event_state1_idx` (`team_member_event_state_id`);

--
-- Indexes for table `licence_type`
--
ALTER TABLE `licence_type`
  ADD PRIMARY KEY (`licence_type_id`);

--
-- Indexes for table `lm_group`
--
ALTER TABLE `lm_group`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `fk_lm_group_lm_league1_idx` (`league_id`);

--
-- Indexes for table `lm_group_class`
--
ALTER TABLE `lm_group_class`
  ADD PRIMARY KEY (`group_class_id`);

--
-- Indexes for table `lm_league`
--
ALTER TABLE `lm_league`
  ADD PRIMARY KEY (`league_id`),
  ADD KEY `fk_lm_league_md_association1_idx` (`association_id`);

--
-- Indexes for table `lm_league_to_role_administration`
--
ALTER TABLE `lm_league_to_role_administration`
  ADD PRIMARY KEY (`league_to_role_administration_id`),
  ADD KEY `fk_league_to_role_administration_league1_idx` (`league_id`),
  ADD KEY `fk_league_to_role_administration_league_to_role_administrat_idx` (`parent_league_to_role_administration_id`),
  ADD KEY `fk_lm_league_to_role_administration_md_role1_idx` (`role_id`),
  ADD KEY `fk_lm_league_to_role_administration_md_user1_idx` (`user_id`);

--
-- Indexes for table `lm_matchday`
--
ALTER TABLE `lm_matchday`
  ADD PRIMARY KEY (`matchday_id`),
  ADD KEY `fk_matchday_season1_idx` (`season_id`);

--
-- Indexes for table `lm_matchday_match`
--
ALTER TABLE `lm_matchday_match`
  ADD PRIMARY KEY (`matchday_match_id`),
  ADD KEY `fk_matchday_match_matchday1_idx` (`matchday_id`),
  ADD KEY `fk_matchday_match_league_team1_idx` (`home_team_id`),
  ADD KEY `fk_matchday_match_league_team2_idx` (`guest_team_id`),
  ADD KEY `fk_matchday_match_season_stage1_idx` (`season_stage_id`),
  ADD KEY `fk_lm_matchday_match_md_match_type1_idx` (`match_type_id`),
  ADD KEY `fk_matchday_match_matchday_match_location1_idx` (`matchday_match_location_id`);

--
-- Indexes for table `lm_matchday_match_event`
--
ALTER TABLE `lm_matchday_match_event`
  ADD PRIMARY KEY (`matchday_match_event_id`),
  ADD KEY `fk_matchday_match_event_matchday_match1_idx` (`matchday_match_id`),
  ADD KEY `fk_matchday_match_event_league_player1_idx` (`player_id`),
  ADD KEY `fk_lm_matchday_match_event_md_match_event_type1_idx` (`match_event_type_id`),
  ADD KEY `fk_lm_matchday_match_event_lm_team1_idx` (`team_id`);

--
-- Indexes for table `lm_matchday_match_location`
--
ALTER TABLE `lm_matchday_match_location`
  ADD PRIMARY KEY (`matchday_match_location_id`);

--
-- Indexes for table `lm_matchday_match_location_to_season`
--
ALTER TABLE `lm_matchday_match_location_to_season`
  ADD PRIMARY KEY (`matchday_match_location_to_season_id`),
  ADD UNIQUE KEY `uix_matchday_match_location_season` (`matchday_match_location_matchday_match_location_id`,`season_id`),
  ADD KEY `fk_lm_matchday_match_location_to_season_lm_matchday_match_l_idx` (`matchday_match_location_matchday_match_location_id`),
  ADD KEY `fk_lm_matchday_match_location_to_season_lm_season1_idx` (`season_id`);

--
-- Indexes for table `lm_matchday_match_to_team_lineup`
--
ALTER TABLE `lm_matchday_match_to_team_lineup`
  ADD PRIMARY KEY (`matchday_match_to_team_lineup_id`),
  ADD KEY `fk_lm_match_to_team_lineup_lm_team1_idx` (`team_id`),
  ADD KEY `fk_lm_match_to_team_lineup_lm_player1_idx` (`player_id`),
  ADD KEY `fk_lm_matchday_match_to_team_lineup_lm_matchday_match1_idx` (`matchday_match_id`);

--
-- Indexes for table `lm_player`
--
ALTER TABLE `lm_player`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `fk_lm_player_md_player_position1_idx` (`player_position_id`),
  ADD KEY `fk_lm_player_md_contract_type1_idx` (`contract_type_id`),
  ADD KEY `fk_lm_player_md_user1_idx` (`user_id`);

--
-- Indexes for table `lm_player_suspension`
--
ALTER TABLE `lm_player_suspension`
  ADD PRIMARY KEY (`player_suspension_id`),
  ADD KEY `fk_lm_player_suspension_lm_player1_idx` (`player_id`),
  ADD KEY `fk_lm_player_suspension_lm_season1_idx` (`season_id`);

--
-- Indexes for table `lm_player_to_document_type`
--
ALTER TABLE `lm_player_to_document_type`
  ADD PRIMARY KEY (`player_to_document_type_id`),
  ADD KEY `fk_lm_player_to_document_type_md_player_document_type1_idx` (`player_document_type_id`),
  ADD KEY `fk_lm_player_to_document_type_lm_player1_idx` (`player_id`);

--
-- Indexes for table `lm_player_to_league_team`
--
ALTER TABLE `lm_player_to_league_team`
  ADD PRIMARY KEY (`player_to_team_id`);

--
-- Indexes for table `lm_season`
--
ALTER TABLE `lm_season`
  ADD PRIMARY KEY (`season_id`),
  ADD KEY `fk_season_league1_idx` (`league_id`),
  ADD KEY `fk_season_league_group_class1_idx` (`group_class_id`);

--
-- Indexes for table `lm_season_stage`
--
ALTER TABLE `lm_season_stage`
  ADD PRIMARY KEY (`season_stage_id`),
  ADD KEY `fk_season_stage_season_stage_type_id1_idx` (`season_stage_type_id`);

--
-- Indexes for table `lm_season_stage_to_team`
--
ALTER TABLE `lm_season_stage_to_team`
  ADD PRIMARY KEY (`season_stage_to_team_id`),
  ADD KEY `fk_season_stage_to_league_team_season_stage1_idx` (`season_stage_id`),
  ADD KEY `fk_season_stage_to_league_team_league_team1_idx` (`team_id`);

--
-- Indexes for table `lm_season_stage_type`
--
ALTER TABLE `lm_season_stage_type`
  ADD PRIMARY KEY (`season_stage_type_id`);

--
-- Indexes for table `lm_season_to_season_stage`
--
ALTER TABLE `lm_season_to_season_stage`
  ADD PRIMARY KEY (`season_to_season_stage_id`),
  ADD KEY `fk_season_to_season_stage_season_stage1_idx` (`season_stage_id`),
  ADD KEY `fk_season_to_season_stage_season1_idx` (`season_id`);

--
-- Indexes for table `lm_team`
--
ALTER TABLE `lm_team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `fk_lm_team_md_team_type1_idx` (`team_type_id`),
  ADD KEY `fk_lm_team_md_club1_idx` (`club_id`);

--
-- Indexes for table `lm_team_link`
--
ALTER TABLE `lm_team_link`
  ADD PRIMARY KEY (`team_link_id`),
  ADD KEY `fk_league_team_link_league_team1_idx` (`team_id`);

--
-- Indexes for table `lm_team_to_role_administration`
--
ALTER TABLE `lm_team_to_role_administration`
  ADD PRIMARY KEY (`team_to_role_administration_id`),
  ADD KEY `fk_lm_team_to_role_administration_md_user1_idx` (`user_id`),
  ADD KEY `fk_lm_team_to_role_administration_md_role1_idx` (`role_id`),
  ADD KEY `fk_lm_team_to_role_administration_lm_team1_idx` (`team_id`),
  ADD KEY `fk_lm_team_to_role_administration_lm_team_to_role_administr_idx` (`parent_team_to_role_administration_id`);

--
-- Indexes for table `lm_team_to_season`
--
ALTER TABLE `lm_team_to_season`
  ADD PRIMARY KEY (`team_to_season_id`),
  ADD KEY `fk_league_team_to_league_season_league_team1_idx` (`team_id`),
  ADD KEY `fk_league_team_to_league_season_league_season1_idx` (`season_id`),
  ADD KEY `fk_league_team_to_league_season_league_group1_idx` (`group_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `location_to_tournament`
--
ALTER TABLE `location_to_tournament`
  ADD PRIMARY KEY (`location_to_tournament_id`),
  ADD UNIQUE KEY `uix_location_tournament` (`location_id`,`tournament_id`),
  ADD KEY `fk_location_to_tournament_location1_idx` (`location_id`),
  ADD KEY `fk_location_to_tournament_tournament1_idx` (`tournament_id`);

--
-- Indexes for table `match`
--
ALTER TABLE `match`
  ADD PRIMARY KEY (`match_id`),
  ADD KEY `FK_match_match_type` (`match_type_id`),
  ADD KEY `FK_match_team_guest` (`guest_team_id`),
  ADD KEY `FK_match_team_home` (`home_team_id`),
  ADD KEY `fk_match_stage1_idx` (`stage_id`),
  ADD KEY `fk_match_location1_idx` (`location_id`);

--
-- Indexes for table `match_event`
--
ALTER TABLE `match_event`
  ADD PRIMARY KEY (`match_event_id`),
  ADD KEY `fk_match_event_match1_idx` (`match_id`),
  ADD KEY `fk_match_event_match_event_type1_idx` (`match_event_type_id`),
  ADD KEY `fk_match_event_player1_idx` (`player_id`);

--
-- Indexes for table `match_event_category`
--
ALTER TABLE `match_event_category`
  ADD PRIMARY KEY (`match_event_category_id`);

--
-- Indexes for table `match_to_referee`
--
ALTER TABLE `match_to_referee`
  ADD PRIMARY KEY (`match_to_referee_id`),
  ADD KEY `FK_match_to_referee_match` (`match_id`),
  ADD KEY `FK_match_to_referee_referee` (`referee_id`),
  ADD KEY `FK_match_to_referee_referee_type` (`referee_type_id`);

--
-- Indexes for table `match_to_team_line_up`
--
ALTER TABLE `match_to_team_line_up`
  ADD PRIMARY KEY (`match_to_team_line_up_id`),
  ADD KEY `FK_match_to_team_line_up_player` (`player_id`),
  ADD KEY `FK_match_to_team_line_up_match` (`match_id`),
  ADD KEY `FK_match_to_team_line_up_player_position` (`player_position_id`),
  ADD KEY `FK_match_to_team_line_up_team` (`team_id`);

--
-- Indexes for table `md_association`
--
ALTER TABLE `md_association`
  ADD PRIMARY KEY (`association_id`),
  ADD KEY `fk_md_association_country_idx` (`country_id`);

--
-- Indexes for table `md_club`
--
ALTER TABLE `md_club`
  ADD PRIMARY KEY (`club_id`);

--
-- Indexes for table `md_contract_type`
--
ALTER TABLE `md_contract_type`
  ADD PRIMARY KEY (`contract_type_id`);

--
-- Indexes for table `md_match_event_type`
--
ALTER TABLE `md_match_event_type`
  ADD PRIMARY KEY (`match_event_type_id`),
  ADD KEY `fk_match_event_type_match_event_category1_idx` (`match_event_category_id`);

--
-- Indexes for table `md_match_type`
--
ALTER TABLE `md_match_type`
  ADD PRIMARY KEY (`match_type_id`);

--
-- Indexes for table `md_player_document_type`
--
ALTER TABLE `md_player_document_type`
  ADD PRIMARY KEY (`player_document_type_id`),
  ADD UNIQUE KEY `uix_player_document_type_code` (`player_document_type_code`);

--
-- Indexes for table `md_player_position`
--
ALTER TABLE `md_player_position`
  ADD PRIMARY KEY (`player_position_id`);

--
-- Indexes for table `md_role`
--
ALTER TABLE `md_role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `md_team_type`
--
ALTER TABLE `md_team_type`
  ADD PRIMARY KEY (`team_type_id`);

--
-- Indexes for table `md_user`
--
ALTER TABLE `md_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `official`
--
ALTER TABLE `official`
  ADD PRIMARY KEY (`official_id`),
  ADD KEY `FK_official_club` (`club_id`),
  ADD KEY `fk_official_user1_idx` (`user_id`);

--
-- Indexes for table `official_position`
--
ALTER TABLE `official_position`
  ADD PRIMARY KEY (`official_position_id`);

--
-- Indexes for table `official_to_position`
--
ALTER TABLE `official_to_position`
  ADD PRIMARY KEY (`official_to_position_id`),
  ADD KEY `FK_official_to_position_official_position` (`official_position_id`),
  ADD KEY `FK_official_to_position_official` (`official_id`);

--
-- Indexes for table `parent_to_child_stage_relation`
--
ALTER TABLE `parent_to_child_stage_relation`
  ADD PRIMARY KEY (`parent_to_child_stage_relation_id`),
  ADD UNIQUE KEY `uix_stages` (`parent_stage_id`,`child_stage_home_id`,`child_stage_guest_id`),
  ADD KEY `fk_parent_to_child_stage_relation_stage_idx` (`parent_stage_id`),
  ADD KEY `fk_parent_to_child_stage_relation_stage1_idx` (`child_stage_home_id`),
  ADD KEY `fk_parent_to_child_stage_relation_stage2_idx` (`child_stage_guest_id`);

--
-- Indexes for table `penalty_catalog`
--
ALTER TABLE `penalty_catalog`
  ADD PRIMARY KEY (`penalty_catalog_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `FK_player_contract_type` (`contract_type_id`),
  ADD KEY `FK_player_player_position` (`player_position_id`),
  ADD KEY `fk_player_user1_idx` (`user_id`);

--
-- Indexes for table `player_position`
--
ALTER TABLE `player_position`
  ADD PRIMARY KEY (`player_position_id`);

--
-- Indexes for table `player_to_team`
--
ALTER TABLE `player_to_team`
  ADD PRIMARY KEY (`player_to_team_id`),
  ADD KEY `FK_player_to_team_player` (`player_id`),
  ADD KEY `FK_player_to_team_team` (`team_id`),
  ADD KEY `FK_player_to_team_player_to_team` (`player_position_id`);

--
-- Indexes for table `referee`
--
ALTER TABLE `referee`
  ADD PRIMARY KEY (`referee_id`),
  ADD KEY `fk_referee_user1_idx` (`user_id`);

--
-- Indexes for table `referee_to_licence_type`
--
ALTER TABLE `referee_to_licence_type`
  ADD PRIMARY KEY (`referee_to_licence_type_id`),
  ADD KEY `fk_referee_to_licence_type_referee1_idx` (`referee_id`),
  ADD KEY `fk_referee_to_licence_type_licence_type1_idx` (`licence_type_id`);

--
-- Indexes for table `referee_type`
--
ALTER TABLE `referee_type`
  ADD PRIMARY KEY (`referee_type_id`);

--
-- Indexes for table `role_to_permission`
--
ALTER TABLE `role_to_permission`
  ADD PRIMARY KEY (`role_to_permission_id`),
  ADD KEY `fk_role_to_permission_role1_idx` (`role_id`),
  ADD KEY `fk_role_to_permission_permission1_idx` (`permission_id`);

--
-- Indexes for table `stage`
--
ALTER TABLE `stage`
  ADD PRIMARY KEY (`stage_id`),
  ADD KEY `fk_stage_stage_type_idx` (`stage_type_id`);

--
-- Indexes for table `stage_to_team`
--
ALTER TABLE `stage_to_team`
  ADD PRIMARY KEY (`stage_to_team_id`),
  ADD UNIQUE KEY `uix_stage_id_team_id` (`stage_id`,`team_id`),
  ADD KEY `fk_stage_to_team_team_idx` (`team_id`),
  ADD KEY `fk_stage_to_team_stage_idx` (`stage_id`);

--
-- Indexes for table `stage_type`
--
ALTER TABLE `stage_type`
  ADD PRIMARY KEY (`stage_type_id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `FK_team_team_type` (`team_type_id`),
  ADD KEY `FK_team_league` (`league_id`),
  ADD KEY `fk_team_club1_idx` (`club_id`);

--
-- Indexes for table `team_leader`
--
ALTER TABLE `team_leader`
  ADD PRIMARY KEY (`team_leader_id`);

--
-- Indexes for table `team_link`
--
ALTER TABLE `team_link`
  ADD PRIMARY KEY (`team_link_id`),
  ADD KEY `fk_team_link_team1_idx` (`team_team_id`);

--
-- Indexes for table `team_member`
--
ALTER TABLE `team_member`
  ADD PRIMARY KEY (`team_member_id`),
  ADD KEY `fk_team_member_user1_idx` (`user_id`),
  ADD KEY `fk_team_member_team1_idx` (`team_id`);

--
-- Indexes for table `team_member_event_state`
--
ALTER TABLE `team_member_event_state`
  ADD PRIMARY KEY (`team_member_event_state_id`);

--
-- Indexes for table `team_member_link`
--
ALTER TABLE `team_member_link`
  ADD PRIMARY KEY (`team_member_link_id`),
  ADD KEY `fk_link_team_member1_idx` (`team_member_id`);

--
-- Indexes for table `team_member_to_penalty_catalog`
--
ALTER TABLE `team_member_to_penalty_catalog`
  ADD PRIMARY KEY (`team_member_to_penalty_catalog_id`),
  ADD KEY `fk_team_member_to_penalty_catalog_penalty_catalog1_idx` (`penalty_catalog_id`),
  ADD KEY `fk_team_member_to_penalty_catalog_team_member1_idx` (`team_member_id`);

--
-- Indexes for table `team_member_to_user_to_role`
--
ALTER TABLE `team_member_to_user_to_role`
  ADD PRIMARY KEY (`team_member_to_user_to_role_id`),
  ADD KEY `fk_team_member_to_user_to_role_team_member2_idx` (`team_member_id`),
  ADD KEY `fk_team_member_to_user_to_role_role1_idx` (`role_id`);

--
-- Indexes for table `team_to_user_to_role`
--
ALTER TABLE `team_to_user_to_role`
  ADD PRIMARY KEY (`team_to_user_to_role_id`),
  ADD KEY `fk_team_to_user_to_role_team2_idx` (`team_id`),
  ADD KEY `fk_team_to_user_to_role_user1_idx` (`user_id`),
  ADD KEY `fk_team_to_user_to_role_role1_idx` (`role_id`);

--
-- Indexes for table `tournament`
--
ALTER TABLE `tournament`
  ADD PRIMARY KEY (`tournament_id`);

--
-- Indexes for table `tournament_to_role_administration`
--
ALTER TABLE `tournament_to_role_administration`
  ADD PRIMARY KEY (`tournament_to_role_administration_id`),
  ADD KEY `fk_tournament_to_role_administration_tournament_to_role_adm_idx` (`parent_tournament_to_role_administration_id`),
  ADD KEY `fk_tournament_to_role_administration_tournament_idx` (`tournament_id`),
  ADD KEY `fk_tournament_to_role_administration_role_idx` (`role_id`),
  ADD KEY `fk_tournament_to_role_administration_user_idx` (`user_id`);

--
-- Indexes for table `tournament_to_stage`
--
ALTER TABLE `tournament_to_stage`
  ADD PRIMARY KEY (`tournament_to_stage_id`),
  ADD KEY `fk_tournament_to_stage_tournament_idx` (`tournament_id`),
  ADD KEY `fk_tournament_to_stage_stage_type_idx` (`stage_id`);

--
-- Indexes for table `tournament_to_team`
--
ALTER TABLE `tournament_to_team`
  ADD PRIMARY KEY (`tournament_to_team_id`),
  ADD KEY `fk_tournament_to_team_tournament_idx` (`tournament_id`),
  ADD KEY `fk_tournament_to_team_team_idx` (`team_id`),
  ADD KEY `fk_tournament_to_team_team_leader1_idx` (`team_leader_id`);

--
-- Indexes for table `trainer`
--
ALTER TABLE `trainer`
  ADD PRIMARY KEY (`trainer_id`),
  ADD KEY `fk_trainer_trainer_type1_idx` (`trainer_type_id`),
  ADD KEY `fk_trainer_user1_idx` (`user_id`);

--
-- Indexes for table `trainer_to_licence_type`
--
ALTER TABLE `trainer_to_licence_type`
  ADD PRIMARY KEY (`trainer_to_licence_type_id`),
  ADD KEY `fk_trainer_to_licence_type_trainer1_idx` (`trainer_id`),
  ADD KEY `fk_trainer_to_licence_type_licence_type1_idx` (`licence_type_id`);

--
-- Indexes for table `trainer_to_team`
--
ALTER TABLE `trainer_to_team`
  ADD PRIMARY KEY (`trainer_to_team_id`),
  ADD KEY `fk_trainer_to_team_trainer1_idx` (`trainer_id`),
  ADD KEY `fk_trainer_to_team_team1_idx` (`team_id`);

--
-- Indexes for table `trainer_type`
--
ALTER TABLE `trainer_type`
  ADD PRIMARY KEY (`trainer_type_id`);

--
-- Indexes for table `user_link`
--
ALTER TABLE `user_link`
  ADD PRIMARY KEY (`user_link_id`),
  ADD KEY `fk_user_link_user1_idx` (`user_id`);

--
-- Indexes for table `user_to_role`
--
ALTER TABLE `user_to_role`
  ADD PRIMARY KEY (`user_to_role_id`),
  ADD KEY `fk_user_to_role_user1_idx` (`user_id`),
  ADD KEY `fk_user_to_role_role1_idx` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `club_to_user_to_role`
--
ALTER TABLE `club_to_user_to_role`
  MODIFY `club_to_user_to_role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `event_actual`
--
ALTER TABLE `event_actual`
  MODIFY `event_actual_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `event_actual_to_team_member`
--
ALTER TABLE `event_actual_to_team_member`
  MODIFY `event_actual_to_team_member_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_category`
--
ALTER TABLE `event_category`
  MODIFY `event_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `event_history_log`
--
ALTER TABLE `event_history_log`
  MODIFY `event_history_log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_plan`
--
ALTER TABLE `event_plan`
  MODIFY `event_plan_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `event_plan_to_team_member`
--
ALTER TABLE `event_plan_to_team_member`
  MODIFY `event_plan_to_team_member_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `licence_type`
--
ALTER TABLE `licence_type`
  MODIFY `licence_type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lm_group`
--
ALTER TABLE `lm_group`
  MODIFY `group_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `lm_group_class`
--
ALTER TABLE `lm_group_class`
  MODIFY `group_class_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `lm_league`
--
ALTER TABLE `lm_league`
  MODIFY `league_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `lm_league_to_role_administration`
--
ALTER TABLE `lm_league_to_role_administration`
  MODIFY `league_to_role_administration_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `lm_matchday`
--
ALTER TABLE `lm_matchday`
  MODIFY `matchday_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=265;

--
-- AUTO_INCREMENT for table `lm_matchday_match`
--
ALTER TABLE `lm_matchday_match`
  MODIFY `matchday_match_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=209;

--
-- AUTO_INCREMENT for table `lm_matchday_match_event`
--
ALTER TABLE `lm_matchday_match_event`
  MODIFY `matchday_match_event_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=234;

--
-- AUTO_INCREMENT for table `lm_matchday_match_location`
--
ALTER TABLE `lm_matchday_match_location`
  MODIFY `matchday_match_location_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `lm_matchday_match_location_to_season`
--
ALTER TABLE `lm_matchday_match_location_to_season`
  MODIFY `matchday_match_location_to_season_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `lm_matchday_match_to_team_lineup`
--
ALTER TABLE `lm_matchday_match_to_team_lineup`
  MODIFY `matchday_match_to_team_lineup_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `lm_player`
--
ALTER TABLE `lm_player`
  MODIFY `player_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `lm_player_suspension`
--
ALTER TABLE `lm_player_suspension`
  MODIFY `player_suspension_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.';

--
-- AUTO_INCREMENT for table `lm_player_to_document_type`
--
ALTER TABLE `lm_player_to_document_type`
  MODIFY `player_to_document_type_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `lm_player_to_league_team`
--
ALTER TABLE `lm_player_to_league_team`
  MODIFY `player_to_team_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.';

--
-- AUTO_INCREMENT for table `lm_season`
--
ALTER TABLE `lm_season`
  MODIFY `season_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `lm_season_stage`
--
ALTER TABLE `lm_season_stage`
  MODIFY `season_stage_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier', AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `lm_season_stage_to_team`
--
ALTER TABLE `lm_season_stage_to_team`
  MODIFY `season_stage_to_team_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `lm_season_stage_type`
--
ALTER TABLE `lm_season_stage_type`
  MODIFY `season_stage_type_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lm_season_to_season_stage`
--
ALTER TABLE `lm_season_to_season_stage`
  MODIFY `season_to_season_stage_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `lm_team`
--
ALTER TABLE `lm_team`
  MODIFY `team_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `lm_team_link`
--
ALTER TABLE `lm_team_link`
  MODIFY `team_link_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `lm_team_to_role_administration`
--
ALTER TABLE `lm_team_to_role_administration`
  MODIFY `team_to_role_administration_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `lm_team_to_season`
--
ALTER TABLE `lm_team_to_season`
  MODIFY `team_to_season_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `location_to_tournament`
--
ALTER TABLE `location_to_tournament`
  MODIFY `location_to_tournament_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `match`
--
ALTER TABLE `match`
  MODIFY `match_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=875;

--
-- AUTO_INCREMENT for table `match_event`
--
ALTER TABLE `match_event`
  MODIFY `match_event_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7173;

--
-- AUTO_INCREMENT for table `match_event_category`
--
ALTER TABLE `match_event_category`
  MODIFY `match_event_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `match_to_referee`
--
ALTER TABLE `match_to_referee`
  MODIFY `match_to_referee_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `match_to_team_line_up`
--
ALTER TABLE `match_to_team_line_up`
  MODIFY `match_to_team_line_up_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `md_association`
--
ALTER TABLE `md_association`
  MODIFY `association_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `md_club`
--
ALTER TABLE `md_club`
  MODIFY `club_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `md_contract_type`
--
ALTER TABLE `md_contract_type`
  MODIFY `contract_type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `md_match_event_type`
--
ALTER TABLE `md_match_event_type`
  MODIFY `match_event_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7970;

--
-- AUTO_INCREMENT for table `md_match_type`
--
ALTER TABLE `md_match_type`
  MODIFY `match_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `md_player_document_type`
--
ALTER TABLE `md_player_document_type`
  MODIFY `player_document_type_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `md_player_position`
--
ALTER TABLE `md_player_position`
  MODIFY `player_position_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `md_role`
--
ALTER TABLE `md_role`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `md_team_type`
--
ALTER TABLE `md_team_type`
  MODIFY `team_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `md_user`
--
ALTER TABLE `md_user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `official`
--
ALTER TABLE `official`
  MODIFY `official_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `official_position`
--
ALTER TABLE `official_position`
  MODIFY `official_position_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `official_to_position`
--
ALTER TABLE `official_to_position`
  MODIFY `official_to_position_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parent_to_child_stage_relation`
--
ALTER TABLE `parent_to_child_stage_relation`
  MODIFY `parent_to_child_stage_relation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `penalty_catalog`
--
ALTER TABLE `penalty_catalog`
  MODIFY `penalty_catalog_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `permission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `player`
--
ALTER TABLE `player`
  MODIFY `player_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4894;

--
-- AUTO_INCREMENT for table `player_position`
--
ALTER TABLE `player_position`
  MODIFY `player_position_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `player_to_team`
--
ALTER TABLE `player_to_team`
  MODIFY `player_to_team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2447;

--
-- AUTO_INCREMENT for table `referee`
--
ALTER TABLE `referee`
  MODIFY `referee_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referee_to_licence_type`
--
ALTER TABLE `referee_to_licence_type`
  MODIFY `referee_to_licence_type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referee_type`
--
ALTER TABLE `referee_type`
  MODIFY `referee_type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_to_permission`
--
ALTER TABLE `role_to_permission`
  MODIFY `role_to_permission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `stage`
--
ALTER TABLE `stage`
  MODIFY `stage_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=438;

--
-- AUTO_INCREMENT for table `stage_to_team`
--
ALTER TABLE `stage_to_team`
  MODIFY `stage_to_team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1347;

--
-- AUTO_INCREMENT for table `stage_type`
--
ALTER TABLE `stage_type`
  MODIFY `stage_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=386;

--
-- AUTO_INCREMENT for table `team_leader`
--
ALTER TABLE `team_leader`
  MODIFY `team_leader_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `team_link`
--
ALTER TABLE `team_link`
  MODIFY `team_link_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=280;

--
-- AUTO_INCREMENT for table `team_member`
--
ALTER TABLE `team_member`
  MODIFY `team_member_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `team_member_event_state`
--
ALTER TABLE `team_member_event_state`
  MODIFY `team_member_event_state_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `team_member_link`
--
ALTER TABLE `team_member_link`
  MODIFY `team_member_link_id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_member_to_penalty_catalog`
--
ALTER TABLE `team_member_to_penalty_catalog`
  MODIFY `team_member_to_penalty_catalog_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_member_to_user_to_role`
--
ALTER TABLE `team_member_to_user_to_role`
  MODIFY `team_member_to_user_to_role_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_to_user_to_role`
--
ALTER TABLE `team_to_user_to_role`
  MODIFY `team_to_user_to_role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tournament`
--
ALTER TABLE `tournament`
  MODIFY `tournament_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier.', AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `tournament_to_role_administration`
--
ALTER TABLE `tournament_to_role_administration`
  MODIFY `tournament_to_role_administration_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `tournament_to_stage`
--
ALTER TABLE `tournament_to_stage`
  MODIFY `tournament_to_stage_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=390;

--
-- AUTO_INCREMENT for table `tournament_to_team`
--
ALTER TABLE `tournament_to_team`
  MODIFY `tournament_to_team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=393;

--
-- AUTO_INCREMENT for table `trainer`
--
ALTER TABLE `trainer`
  MODIFY `trainer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trainer_to_licence_type`
--
ALTER TABLE `trainer_to_licence_type`
  MODIFY `trainer_to_licence_type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trainer_to_team`
--
ALTER TABLE `trainer_to_team`
  MODIFY `trainer_to_team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `trainer_type`
--
ALTER TABLE `trainer_type`
  MODIFY `trainer_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_link`
--
ALTER TABLE `user_link`
  MODIFY `user_link_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user_to_role`
--
ALTER TABLE `user_to_role`
  MODIFY `user_to_role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `club_to_user_to_role`
--
ALTER TABLE `club_to_user_to_role`
  ADD CONSTRAINT `fk_club_to_user_to_role_club2` FOREIGN KEY (`club_id`) REFERENCES `md_club` (`club_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_club_to_user_to_role_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_club_to_user_to_role_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `fk_event_event_category1` FOREIGN KEY (`event_category_id`) REFERENCES `event_category` (`event_category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_event_team1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `event_actual`
--
ALTER TABLE `event_actual`
  ADD CONSTRAINT `fk_event_actual_event1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`);

--
-- Constraints for table `event_actual_to_team_member`
--
ALTER TABLE `event_actual_to_team_member`
  ADD CONSTRAINT `fk_event_actual_to_team_member_event_actual1` FOREIGN KEY (`event_actual_id`) REFERENCES `event_actual` (`event_actual_id`),
  ADD CONSTRAINT `fk_event_actual_to_team_member_team_member1` FOREIGN KEY (`team_member_id`) REFERENCES `team_member` (`team_member_id`),
  ADD CONSTRAINT `fk_event_actual_to_team_member_team_member_event_state1` FOREIGN KEY (`team_member_event_state_id`) REFERENCES `team_member_event_state` (`team_member_event_state_id`);

--
-- Constraints for table `event_history_log`
--
ALTER TABLE `event_history_log`
  ADD CONSTRAINT `fk_event_history_log_event1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `fk_event_history_log_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`);

--
-- Constraints for table `event_plan`
--
ALTER TABLE `event_plan`
  ADD CONSTRAINT `fk_event_plan_event1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `event_plan_to_team_member`
--
ALTER TABLE `event_plan_to_team_member`
  ADD CONSTRAINT `fk_event_plan_to_team_member_event_plan1` FOREIGN KEY (`event_plan_id`) REFERENCES `event_plan` (`event_plan_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_event_plan_to_team_member_team_member1` FOREIGN KEY (`team_member_id`) REFERENCES `team_member` (`team_member_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_event_plan_to_team_member_team_member_event_state1` FOREIGN KEY (`team_member_event_state_id`) REFERENCES `team_member_event_state` (`team_member_event_state_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_group`
--
ALTER TABLE `lm_group`
  ADD CONSTRAINT `fk_lm_group_lm_league1` FOREIGN KEY (`league_id`) REFERENCES `lm_league` (`league_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_league`
--
ALTER TABLE `lm_league`
  ADD CONSTRAINT `fk_lm_league_md_association1` FOREIGN KEY (`association_id`) REFERENCES `md_association` (`association_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_league_to_role_administration`
--
ALTER TABLE `lm_league_to_role_administration`
  ADD CONSTRAINT `fk_league_to_role_administration_league1` FOREIGN KEY (`league_id`) REFERENCES `lm_league` (`league_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_league_to_role_administration_league_to_role_administration1` FOREIGN KEY (`parent_league_to_role_administration_id`) REFERENCES `lm_league_to_role_administration` (`league_to_role_administration_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_league_to_role_administration_md_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_league_to_role_administration_md_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_matchday`
--
ALTER TABLE `lm_matchday`
  ADD CONSTRAINT `fk_matchday_season1` FOREIGN KEY (`season_id`) REFERENCES `lm_season` (`season_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_matchday_match`
--
ALTER TABLE `lm_matchday_match`
  ADD CONSTRAINT `fk_lm_matchday_match_md_match_type1` FOREIGN KEY (`match_type_id`) REFERENCES `md_match_type` (`match_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_league_team1` FOREIGN KEY (`home_team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_league_team2` FOREIGN KEY (`guest_team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_matchday1` FOREIGN KEY (`matchday_id`) REFERENCES `lm_matchday` (`matchday_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_matchday_match_location1` FOREIGN KEY (`matchday_match_location_id`) REFERENCES `lm_matchday_match_location` (`matchday_match_location_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_season_stage1` FOREIGN KEY (`season_stage_id`) REFERENCES `lm_season_stage` (`season_stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_matchday_match_event`
--
ALTER TABLE `lm_matchday_match_event`
  ADD CONSTRAINT `fk_lm_matchday_match_event_lm_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_matchday_match_event_md_match_event_type1` FOREIGN KEY (`match_event_type_id`) REFERENCES `md_match_event_type` (`match_event_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_event_league_player1` FOREIGN KEY (`player_id`) REFERENCES `lm_player` (`player_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_matchday_match_event_matchday_match1` FOREIGN KEY (`matchday_match_id`) REFERENCES `lm_matchday_match` (`matchday_match_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_matchday_match_location_to_season`
--
ALTER TABLE `lm_matchday_match_location_to_season`
  ADD CONSTRAINT `fk_lm_matchday_match_location_to_season_lm_matchday_match_loc1` FOREIGN KEY (`matchday_match_location_matchday_match_location_id`) REFERENCES `lm_matchday_match_location` (`matchday_match_location_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_matchday_match_location_to_season_lm_season1` FOREIGN KEY (`season_id`) REFERENCES `lm_season` (`season_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_matchday_match_to_team_lineup`
--
ALTER TABLE `lm_matchday_match_to_team_lineup`
  ADD CONSTRAINT `fk_lm_match_to_team_lineup_lm_player1` FOREIGN KEY (`player_id`) REFERENCES `lm_player` (`player_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_match_to_team_lineup_lm_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_matchday_match_to_team_lineup_lm_matchday_match1` FOREIGN KEY (`matchday_match_id`) REFERENCES `lm_matchday_match` (`matchday_match_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_player`
--
ALTER TABLE `lm_player`
  ADD CONSTRAINT `fk_lm_player_md_contract_type1` FOREIGN KEY (`contract_type_id`) REFERENCES `md_contract_type` (`contract_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_player_md_player_position1` FOREIGN KEY (`player_position_id`) REFERENCES `md_player_position` (`player_position_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_player_md_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_player_suspension`
--
ALTER TABLE `lm_player_suspension`
  ADD CONSTRAINT `fk_lm_player_suspension_lm_player1` FOREIGN KEY (`player_id`) REFERENCES `lm_player` (`player_id`),
  ADD CONSTRAINT `fk_lm_player_suspension_lm_season1` FOREIGN KEY (`season_id`) REFERENCES `lm_season` (`season_id`);

--
-- Constraints for table `lm_player_to_document_type`
--
ALTER TABLE `lm_player_to_document_type`
  ADD CONSTRAINT `fk_lm_player_to_document_type_lm_player1` FOREIGN KEY (`player_id`) REFERENCES `lm_player` (`player_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_player_to_document_type_md_player_document_type1` FOREIGN KEY (`player_document_type_id`) REFERENCES `md_player_document_type` (`player_document_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_season`
--
ALTER TABLE `lm_season`
  ADD CONSTRAINT `fk_season_league1` FOREIGN KEY (`league_id`) REFERENCES `lm_league` (`league_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_season_league_group_class1` FOREIGN KEY (`group_class_id`) REFERENCES `lm_group_class` (`group_class_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_season_stage`
--
ALTER TABLE `lm_season_stage`
  ADD CONSTRAINT `fk_season_stage_season_stage_type_id1` FOREIGN KEY (`season_stage_type_id`) REFERENCES `lm_season_stage_type` (`season_stage_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_season_stage_to_team`
--
ALTER TABLE `lm_season_stage_to_team`
  ADD CONSTRAINT `fk_season_stage_to_league_team_league_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_season_stage_to_league_team_season_stage1` FOREIGN KEY (`season_stage_id`) REFERENCES `lm_season_stage` (`season_stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_season_to_season_stage`
--
ALTER TABLE `lm_season_to_season_stage`
  ADD CONSTRAINT `fk_season_to_season_stage_season1` FOREIGN KEY (`season_id`) REFERENCES `lm_season` (`season_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_season_to_season_stage_season_stage1` FOREIGN KEY (`season_stage_id`) REFERENCES `lm_season_stage` (`season_stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_team`
--
ALTER TABLE `lm_team`
  ADD CONSTRAINT `fk_lm_team_md_club1` FOREIGN KEY (`club_id`) REFERENCES `md_club` (`club_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_team_md_team_type1` FOREIGN KEY (`team_type_id`) REFERENCES `md_team_type` (`team_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_team_link`
--
ALTER TABLE `lm_team_link`
  ADD CONSTRAINT `fk_league_team_link_league_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_team_to_role_administration`
--
ALTER TABLE `lm_team_to_role_administration`
  ADD CONSTRAINT `fk_lm_team_to_role_administration_lm_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_team_to_role_administration_lm_team_to_role_administrat1` FOREIGN KEY (`parent_team_to_role_administration_id`) REFERENCES `lm_team_to_role_administration` (`team_to_role_administration_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_team_to_role_administration_md_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_lm_team_to_role_administration_md_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `lm_team_to_season`
--
ALTER TABLE `lm_team_to_season`
  ADD CONSTRAINT `fk_league_team_to_league_season_league_group1` FOREIGN KEY (`group_id`) REFERENCES `lm_group` (`group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_league_team_to_league_season_league_season1` FOREIGN KEY (`season_id`) REFERENCES `lm_season` (`season_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_league_team_to_league_season_league_team1` FOREIGN KEY (`team_id`) REFERENCES `lm_team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `location_to_tournament`
--
ALTER TABLE `location_to_tournament`
  ADD CONSTRAINT `fk_location_to_tournament_location1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_location_to_tournament_tournament1` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `match`
--
ALTER TABLE `match`
  ADD CONSTRAINT `fk_match_location1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_match_match_type` FOREIGN KEY (`match_type_id`) REFERENCES `md_match_type` (`match_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_match_stage1` FOREIGN KEY (`stage_id`) REFERENCES `stage` (`stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_match_team_guest` FOREIGN KEY (`guest_team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_match_team_home` FOREIGN KEY (`home_team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `match_event`
--
ALTER TABLE `match_event`
  ADD CONSTRAINT `fk_match_event_match1` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_match_event_match_event_type1` FOREIGN KEY (`match_event_type_id`) REFERENCES `md_match_event_type` (`match_event_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `match_to_referee`
--
ALTER TABLE `match_to_referee`
  ADD CONSTRAINT `FK_match_to_referee_match` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`),
  ADD CONSTRAINT `FK_match_to_referee_referee` FOREIGN KEY (`referee_id`) REFERENCES `referee` (`referee_id`),
  ADD CONSTRAINT `FK_match_to_referee_referee_type` FOREIGN KEY (`referee_type_id`) REFERENCES `referee_type` (`referee_type_id`);

--
-- Constraints for table `match_to_team_line_up`
--
ALTER TABLE `match_to_team_line_up`
  ADD CONSTRAINT `FK_match_to_team_line_up_match` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`),
  ADD CONSTRAINT `FK_match_to_team_line_up_player` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `FK_match_to_team_line_up_player_position` FOREIGN KEY (`player_position_id`) REFERENCES `md_player_position` (`player_position_id`),
  ADD CONSTRAINT `FK_match_to_team_line_up_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`);

--
-- Constraints for table `official`
--
ALTER TABLE `official`
  ADD CONSTRAINT `FK_official_club` FOREIGN KEY (`club_id`) REFERENCES `md_club` (`club_id`),
  ADD CONSTRAINT `fk_official_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`);

--
-- Constraints for table `official_to_position`
--
ALTER TABLE `official_to_position`
  ADD CONSTRAINT `FK_official_to_position_official` FOREIGN KEY (`official_id`) REFERENCES `official` (`official_id`),
  ADD CONSTRAINT `FK_official_to_position_official_position` FOREIGN KEY (`official_position_id`) REFERENCES `official_position` (`official_position_id`);

--
-- Constraints for table `parent_to_child_stage_relation`
--
ALTER TABLE `parent_to_child_stage_relation`
  ADD CONSTRAINT `fk_parent_to_child_stage_relation_stage` FOREIGN KEY (`parent_stage_id`) REFERENCES `stage` (`stage_id`),
  ADD CONSTRAINT `fk_parent_to_child_stage_relation_stage1` FOREIGN KEY (`child_stage_home_id`) REFERENCES `stage` (`stage_id`),
  ADD CONSTRAINT `fk_parent_to_child_stage_relation_stage2` FOREIGN KEY (`child_stage_guest_id`) REFERENCES `stage` (`stage_id`);

--
-- Constraints for table `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `FK_player_contract_type` FOREIGN KEY (`contract_type_id`) REFERENCES `md_contract_type` (`contract_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_player_player_position` FOREIGN KEY (`player_position_id`) REFERENCES `md_player_position` (`player_position_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_player_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `player_to_team`
--
ALTER TABLE `player_to_team`
  ADD CONSTRAINT `FK_player_to_team_player` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_player_to_team_player_to_team` FOREIGN KEY (`player_position_id`) REFERENCES `md_player_position` (`player_position_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_player_to_team_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `referee`
--
ALTER TABLE `referee`
  ADD CONSTRAINT `fk_referee_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`);

--
-- Constraints for table `referee_to_licence_type`
--
ALTER TABLE `referee_to_licence_type`
  ADD CONSTRAINT `fk_referee_to_licence_type_licence_type1` FOREIGN KEY (`licence_type_id`) REFERENCES `licence_type` (`licence_type_id`),
  ADD CONSTRAINT `fk_referee_to_licence_type_referee1` FOREIGN KEY (`referee_id`) REFERENCES `referee` (`referee_id`);

--
-- Constraints for table `role_to_permission`
--
ALTER TABLE `role_to_permission`
  ADD CONSTRAINT `fk_role_to_permission_permission1` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`),
  ADD CONSTRAINT `fk_role_to_permission_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`);

--
-- Constraints for table `stage`
--
ALTER TABLE `stage`
  ADD CONSTRAINT `fk_stage_stage_type` FOREIGN KEY (`stage_type_id`) REFERENCES `stage_type` (`stage_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `stage_to_team`
--
ALTER TABLE `stage_to_team`
  ADD CONSTRAINT `fk_stage_to_team_stage` FOREIGN KEY (`stage_id`) REFERENCES `stage` (`stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_stage_to_team_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `team_member`
--
ALTER TABLE `team_member`
  ADD CONSTRAINT `fk_team_member_team1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_team_member_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `team_member_link`
--
ALTER TABLE `team_member_link`
  ADD CONSTRAINT `fk_link_team_member1` FOREIGN KEY (`team_member_id`) REFERENCES `team_member` (`team_member_id`);

--
-- Constraints for table `team_member_to_penalty_catalog`
--
ALTER TABLE `team_member_to_penalty_catalog`
  ADD CONSTRAINT `fk_team_member_to_penalty_catalog_penalty_catalog1` FOREIGN KEY (`penalty_catalog_id`) REFERENCES `penalty_catalog` (`penalty_catalog_id`),
  ADD CONSTRAINT `fk_team_member_to_penalty_catalog_team_member1` FOREIGN KEY (`team_member_id`) REFERENCES `team_member` (`team_member_id`);

--
-- Constraints for table `team_member_to_user_to_role`
--
ALTER TABLE `team_member_to_user_to_role`
  ADD CONSTRAINT `fk_team_member_to_user_to_role_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`),
  ADD CONSTRAINT `fk_team_member_to_user_to_role_team_member2` FOREIGN KEY (`team_member_id`) REFERENCES `team_member` (`team_member_id`);

--
-- Constraints for table `team_to_user_to_role`
--
ALTER TABLE `team_to_user_to_role`
  ADD CONSTRAINT `fk_team_to_user_to_role_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_team_to_user_to_role_team2` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_team_to_user_to_role_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tournament_to_role_administration`
--
ALTER TABLE `tournament_to_role_administration`
  ADD CONSTRAINT `fk_tournament_to_role_administration_role` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_role_administration_self` FOREIGN KEY (`parent_tournament_to_role_administration_id`) REFERENCES `tournament_to_role_administration` (`tournament_to_role_administration_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_role_administration_tournament` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_role_administration_user` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tournament_to_stage`
--
ALTER TABLE `tournament_to_stage`
  ADD CONSTRAINT `fk_tournament_to_stage_stage` FOREIGN KEY (`stage_id`) REFERENCES `stage` (`stage_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_stage_tournament` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tournament_to_team`
--
ALTER TABLE `tournament_to_team`
  ADD CONSTRAINT `fk_tournament_to_team_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_team_team_leader1` FOREIGN KEY (`team_leader_id`) REFERENCES `team_leader` (`team_leader_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_tournament_to_team_tournament` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `trainer`
--
ALTER TABLE `trainer`
  ADD CONSTRAINT `fk_trainer_trainer_type1` FOREIGN KEY (`trainer_type_id`) REFERENCES `trainer_type` (`trainer_type_id`),
  ADD CONSTRAINT `fk_trainer_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`);

--
-- Constraints for table `trainer_to_licence_type`
--
ALTER TABLE `trainer_to_licence_type`
  ADD CONSTRAINT `fk_trainer_to_licence_type_licence_type1` FOREIGN KEY (`licence_type_id`) REFERENCES `licence_type` (`licence_type_id`),
  ADD CONSTRAINT `fk_trainer_to_licence_type_trainer1` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`trainer_id`);

--
-- Constraints for table `trainer_to_team`
--
ALTER TABLE `trainer_to_team`
  ADD CONSTRAINT `fk_trainer_to_team_team1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_trainer_to_team_trainer1` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`trainer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `user_link`
--
ALTER TABLE `user_link`
  ADD CONSTRAINT `fk_user_link_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `user_to_role`
--
ALTER TABLE `user_to_role`
  ADD CONSTRAINT `fk_user_to_role_role1` FOREIGN KEY (`role_id`) REFERENCES `md_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_user_to_role_user1` FOREIGN KEY (`user_id`) REFERENCES `md_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
