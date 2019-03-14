-- MySQL Script generated by MySQL Workbench
-- Wed 13 Mar 2019 03:52:26 PM CST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sql_judge
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sql_judge
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sql_judge` ;
USE `sql_judge` ;

-- -----------------------------------------------------
-- Table `sql_judge`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Student` (
  `id` VARCHAR(15) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `session` VARCHAR(128) NULL,
  `name` VARCHAR(16) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `session_UNIQUE` (`session` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Schema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Schema` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `path_UNIQUE` (`path` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idSchema` INT NOT NULL,
  `title` VARCHAR(1000) NOT NULL,
  `text` VARCHAR(5000) NOT NULL,
  `score` INT NOT NULL DEFAULT 5,
  `result` VARCHAR(10000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `idSchema_idx` (`idSchema` ASC) VISIBLE,
  CONSTRAINT `fkSchema_Question`
    FOREIGN KEY (`idSchema`)
    REFERENCES `sql_judge`.`Schema` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idQuestion` INT NOT NULL,
  `data` VARCHAR(400) NOT NULL,
  `json` VARCHAR(600) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fkQuestion_Answer`
    FOREIGN KEY (`idQuestion`)
    REFERENCES `sql_judge`.`Question` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Segmentation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Segmentation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idAnswer` INT NOT NULL,
  `rank` INT NOT NULL,
  `score` INT NOT NULL,
  `data` TEXT(150) NOT NULL,
  `extra` TEXT(150) NULL,
  PRIMARY KEY (`id`),
  INDEX `idAnswer_idx` (`idAnswer` ASC) VISIBLE,
  CONSTRAINT `fkAnswer_Segmentation`
    FOREIGN KEY (`idAnswer`)
    REFERENCES `sql_judge`.`Answer` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Submit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Submit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idStudent` VARCHAR(15) NOT NULL,
  `idQuestion` INT NOT NULL,
  `score` INT NOT NULL,
  `answer` VARCHAR(300) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id`),
  INDEX `idStudent_idx` (`idStudent` ASC) VISIBLE,
  INDEX `idQuestion_idx` (`idQuestion` ASC) VISIBLE,
  CONSTRAINT `fkStudent_Submit`
    FOREIGN KEY (`idStudent`)
    REFERENCES `sql_judge`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkQuestion_Submit`
    FOREIGN KEY (`idQuestion`)
    REFERENCES `sql_judge`.`Question` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Table` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idSchema` INT NOT NULL,
  `sql` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idSchema_idx` (`idSchema` ASC) VISIBLE,
  CONSTRAINT `fkSchema_Table`
    FOREIGN KEY (`idSchema`)
    REFERENCES `sql_judge`.`Schema` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Insert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Insert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idTable` INT NOT NULL,
  `sql` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idTable_idx` (`idTable` ASC) VISIBLE,
  CONSTRAINT `fkTable_Insert`
    FOREIGN KEY (`idTable`)
    REFERENCES `sql_judge`.`Table` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql_judge`.`Admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_judge`.`Admin` (
  `name` VARCHAR(30) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `session` VARCHAR(128) NULL,
  `extra` VARCHAR(500) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
