-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema squadgoalsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `squadgoalsdb` ;

-- -----------------------------------------------------
-- Schema squadgoalsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `squadgoalsdb` DEFAULT CHARACTER SET utf8 ;
USE `squadgoalsdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `first_name` VARCHAR(99) NULL,
  `last_name` VARCHAR(99) NULL,
  `role` VARCHAR(45) NULL,
  `bio` TEXT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS squad;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'squad' IDENTIFIED BY 'squad';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'squad';
SET SQL_MODE = '';
DROP USER IF EXISTS squadgoals@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'squadgoals'@'localhost' IDENTIFIED BY 'squadgoals';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'squadgoals'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`) VALUES (1, 'originaltom', 'myspace', 'tom@myspace.com', 'Tom', 'MySpace', '1', 'Hi, I\'m Tom, and I\'m friends with everyone!', 1);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`) VALUES (2, 'godzilla', 'godzilla', 'godzilla@monster.rawr', 'Go', 'Shira', '2', 'Hi, name\'s Godzilla. Love smashing cities and chasing damsels up skyscrapers. Oh, is that my cousin, King Kong? Oops.', 1);

COMMIT;

