-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `userdevice` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `userdevice` ;


CREATE TABLE IF NOT EXISTS `userdevice`.`account` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`device` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `unique_id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`device_account` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `device_id` INT(11) NOT NULL,
  `account_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_device_account_accountid` (`account_id` ASC) VISIBLE,
  INDEX `fk_device_account_deviceid` (`device_id` ASC) VISIBLE,
  CONSTRAINT `fk_device_account_accountid`
    FOREIGN KEY (`account_id`)
    REFERENCES userdevice.`account` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_device_account_deviceid`
    FOREIGN KEY (`device_id`)
    REFERENCES userdevice.`device` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(255) NULL DEFAULT NULL,
  `last_name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`user_account` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `account_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_account_accountid` (`account_id` ASC) VISIBLE,
  INDEX `fk_user_account_userid` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_account_accountid`
    FOREIGN KEY (`account_id`)
    REFERENCES userdevice.`account` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_account_userid`
    FOREIGN KEY (`user_id`)
    REFERENCES userdevice.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`user_device` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `device_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_device_deviceid` (`device_id` ASC) VISIBLE,
  INDEX `fk_user_device_userid` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_device_deviceid`
    FOREIGN KEY (`device_id`)
    REFERENCES userdevice.`device` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_device_userid`
    FOREIGN KEY (`user_id`)
    REFERENCES userdevice.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS userdevice.`user_role` (
  `user_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_user_role_roleid_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role_roleid`
    FOREIGN KEY (`role_id`)
    REFERENCES userdevice.`role` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_userid`
    FOREIGN KEY (`user_id`)
    REFERENCES userdevice.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
