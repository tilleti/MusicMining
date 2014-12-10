-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: millionsong
-- Source Schemata: millionsong
-- Created: Tue Oct 14 15:48:18 2014
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema millionsong
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `millionsong` ;
CREATE SCHEMA IF NOT EXISTS `millionsong` ;

-- ----------------------------------------------------------------------------
-- Table millionsong.artist
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`artist` (
  `artistId` VARCHAR(50) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `latitude` INT(11) NULL DEFAULT NULL,
  `longitude` INT(11) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `familiarity` VARCHAR(45) NULL DEFAULT NULL,
  `hotness` VARCHAR(45) NULL DEFAULT NULL,
  `mbId` INT(11) NULL DEFAULT NULL,
  `playmeId` INT(11) NULL DEFAULT NULL,
  `7digitalId` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`artistId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.artist_song
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`artist_song` (
  `artistId` VARCHAR(50) NOT NULL,
  `songId` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`artistId`, `songId`),
  INDEX `FK_artist_song2_idx` (`songId` ASC),
  CONSTRAINT `FK_artist_song1`
    FOREIGN KEY (`artistId`)
    REFERENCES `millionsong`.`artist` (`artistId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_artist_song2`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.song
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`song` (
  `songId` VARCHAR(50) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `hotness` VARCHAR(45) NULL DEFAULT NULL,
  `track_7digitalId` INT(11) NULL DEFAULT NULL,
  `danceability` INT(11) NULL DEFAULT NULL,
  `loudness` INT(11) NULL DEFAULT NULL,
  `tempo` INT(11) NULL DEFAULT NULL,
  `trackId` VARCHAR(50) NULL DEFAULT NULL,
  `duration` FLOAT NULL DEFAULT NULL,
  `year` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`songId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.song_association
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`song_association` (
  `songA` varchar(50) NOT NULL,
  `songC` varchar(50) NOT NULL,
  `support` float NOT NULL,
  `confidence` float NOT NULL,
  `lift` float NOT NULL,
  KEY `FK_song_association_idx` (`songA`,`songC`),
  KEY `FK_song_assoc1_idx` (`songA`),
  KEY `FK_song_assoc2_idx` (`songC`),
  CONSTRAINT `FK_song_assoc1` FOREIGN KEY (`songA`) REFERENCES `song` (`songId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_song_assoc2` FOREIGN KEY (`songC`) REFERENCES `song` (`songId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.artist_term
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`artist_term` (
  `artistId` VARCHAR(50) NOT NULL,
  `termId` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`artistId`, `termId`),
  INDEX `FK_artist_term2_idx` (`termId` ASC),
  CONSTRAINT `FK_artist_term1`
    FOREIGN KEY (`artistId`)
    REFERENCES `millionsong`.`artist` (`artistId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  -- CONSTRAINT `FK_artist_term2`
  --  FOREIGN KEY (`termId`)
   -- REFERENCES `millionsong`.`term` (`termId`)
   -- ON DELETE CASCADE
   -- ON UPDATE CASCADE
   )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

