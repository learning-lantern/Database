-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema learning-lantern-assistant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema learning-lantern-assistant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `learning-lantern-assistant` DEFAULT CHARACTER SET utf8 ;
USE `learning-lantern-assistant` ;

-- -----------------------------------------------------
-- Table `learning-lantern-assistant`.`TranslateRequest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-assistant`.`TranslateRequest` (
  `Id` INT NOT NULL,
  `Word` NVARCHAR(50) NOT NULL,
  `Count` INT NULL DEFAULT 1,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-assistant`.`Synonym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-assistant`.`Synonym` (
  `Id` INT NOT NULL,
  `Count` INT NULL DEFAULT 1,
  `Meaning` NVARCHAR(250) NOT NULL,
  `RequestId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_synonym_Student_Translate_Request_idx` (`RequestId` ASC) VISIBLE,
  CONSTRAINT `fk_synonym_Student_Translate_Request`
    FOREIGN KEY (`RequestId`)
    REFERENCES `learning-lantern-assistant`.`TranslateRequest` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
