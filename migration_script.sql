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

CREATE TABLE IF NOT EXISTS `millionsong`.`song_association` (
  `songA` varchar(50) NOT NULL,
  `songC` varchar(50) NOT NULL,
  `support` float NOT NULL,
  `confidence` float NOT NULL,
  `lift` float NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

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

-- ----------------------------------------------------------------------------
-- Table millionsong.term
-- ----------------------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `millionsong`.`term` (
--  `termId` INT(11) NOT NULL,
--  `name` VARCHAR(45) NOT NULL,
--  PRIMARY KEY (`termId`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.bars
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`bars` (
  `songId` VARCHAR(50) NOT NULL,
  `barStart` FLOAT NOT NULL,
  PRIMARY KEY (`songId`, `barStart`),
  CONSTRAINT `FK_song_bar`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.beats
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`beats` (
  `songId` VARCHAR(50) NOT NULL,
  `beatStart` FLOAT NOT NULL,
  PRIMARY KEY (`songId`, `beatStart`),
  CONSTRAINT `FK_song_beats1`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.sections
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`sections` (
  `songId` VARCHAR(50) NOT NULL,
  `sectionStart` FLOAT NOT NULL,
  PRIMARY KEY (`songId`, `sectionStart`),
  CONSTRAINT `FK_song_sections`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.segments
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`segments` (
  `songId` VARCHAR(50) NOT NULL,
  `segmentStart` FLOAT NOT NULL,
  `segmentTimbre` FLOAT NOT NULL,
  `segmentLoudnessStart` FLOAT NOT NULL,
  `segmentLoudnessMax` FLOAT NOT NULL,
  PRIMARY KEY (`songId`, `segmentStart`),
  CONSTRAINT `FK_song_segments`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.similar_artists
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`similar_artists` (
  `artistId1` VARCHAR(50) NOT NULL,
  `artistId2` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`artistId1`, `artistId2`),
  INDEX `FK_artist_artist2_idx` (`artistId2` ASC),
  CONSTRAINT `FK_artist_artist1`
    FOREIGN KEY (`artistId1`)
    REFERENCES `millionsong`.`artist` (`artistId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_artist_artist2`
    FOREIGN KEY (`artistId2`)
    REFERENCES `millionsong`.`artist` (`artistId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table millionsong.tatums
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `millionsong`.`tatums` (
  `songId` VARCHAR(50) NOT NULL,
  `tatumStart` FLOAT NOT NULL,
  PRIMARY KEY (`songId`, `tatumStart`),
  CONSTRAINT `FK_song_tatums`
    FOREIGN KEY (`songId`)
    REFERENCES `millionsong`.`song` (`songId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
SET FOREIGN_KEY_CHECKS = 1;
