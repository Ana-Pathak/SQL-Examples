/**CREATING DATABASE: **/
CREATE DATABASE IF NOT EXISTS National_Hockey_League;
SET foreign_key_checks = 0;
drop table if exists teams;
SET foreign_key_checks = 1;
drop table if exists plays;
drop table if exists injury;
drop table if exists player;


/**Teams table: **/
CREATE TABLE IF NOT EXISTS teams (
 team_name VARCHAR(50),
 coach VARCHAR(50),
 captain VARCHAR(50),
 city VARCHAR(50),
 PRIMARY KEY (team_name)
)ENGINE = InnoDB;

/**Player table: **/
CREATE TABLE IF NOT EXISTS player (
 player_name VARCHAR(50),
 skill_level VARCHAR(100),
 player_position VARCHAR(50),
 team_name VARCHAR(50),
 PRIMARY KEY (player_name),
 FOREIGN KEY (team_name) REFERENCES teams (team_name)
)ENGINE = InnoDB;

/**Games table: **/
CREATE TABLE IF NOT EXISTS plays (
 team_host VARCHAR(100),
 team_guest VARCHAR(100),
 date_played DATETIME,
 score VARCHAR(10),
 PRIMARY KEY (date_played, team_host, team_guest),
 FOREIGN KEY (team_host) REFERENCES teams (team_name),
 FOREIGN KEY (team_guest) REFERENCES teams (team_name)
)ENGINE = InnoDB;


/**Injury table: **/
CREATE TABLE IF NOT EXISTS injury (
 injury VARCHAR(150),
 injury_ID VARCHAR(50),
 player_name VARCHAR(50),
 PRIMARY KEY (injury_ID, player_name),
 FOREIGN KEY (player_name) REFERENCES player (player_name)
)ENGINE = InnoDB;

/**Inserting data into teams table: **/
INSERT INTO teams VALUES ('New York Rangers', ' David Quinn', 'Chris Kreider', 'New York');
INSERT INTO teams VALUES('Arizona Coyotes', 'Rick Tocchet', 'Oliver Ekman-Larsson', 'Arizona');

/**Inserting data of 2 players into players table: **/
INSERT INTO player VALUES('Tony DeAngelo', 'high', 'goalie', 'New York Rangers');
INSERT INTO player VALUES('Chris Kreider', 'high', 'forward', 'New York Rangers');
INSERT INTO player VALUES('Oliver Ekman-Larsson', 'mid', 'center-forward', 'Arizona Coyotes');
INSERT INTO player VALUES('Lawson Crouse', 'low', 'goalie', 'Arizona Coyotes');


/**Inserting data into games table: **/
INSERT INTO plays VALUES('New York Rangers', 'Arizona Coyotes', '2019-03-04', '4-2');
INSERT INTO plays VALUES('Arizona Coyotes','New York Rangers','2020-10-22', '3-4');

/**Inserting data into injury table: **/
INSERT INTO injury VALUES('pulled a hamstring on  10/22/2020. Cannot play for 2 weeks', 1111,'Tony DeAngelo' );


/**Query: **/
SELECT one.captain AS 'Host', two.captain AS 'Guest', date_played AS 'DATE', score
	FROM plays, teams AS one, teams AS two
    WHERE one.team_name = plays.team_host
    AND two.team_name = plays.team_guest;
