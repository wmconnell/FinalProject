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
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(499) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


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
  `profile_image_id` INT NOT NULL DEFAULT 1,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_user_image1_idx` (`profile_image_id` ASC),
  CONSTRAINT `fk_user_image1`
    FOREIGN KEY (`profile_image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `squad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad` ;

CREATE TABLE IF NOT EXISTS `squad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(99) NULL,
  `bio` TEXT NULL,
  `active` TINYINT NULL,
  `leader_id` INT NOT NULL,
  `profile_image_id` INT NOT NULL,
  `created_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_squad_user1_idx` (`leader_id` ASC),
  INDEX `fk_squad_image1_idx` (`profile_image_id` ASC),
  CONSTRAINT `fk_squad_user1`
    FOREIGN KEY (`leader_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_image1`
    FOREIGN KEY (`profile_image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_squad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_squad` ;

CREATE TABLE IF NOT EXISTS `user_has_squad` (
  `user_id` INT NOT NULL,
  `squad_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `squad_id`),
  INDEX `fk_user_has_squad_squad1_idx` (`squad_id` ASC),
  INDEX `fk_user_has_squad_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_squad_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_squad_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `goal` ;

CREATE TABLE IF NOT EXISTS `goal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(99) NULL,
  `description` TEXT NULL,
  `created_date` DATETIME NULL,
  `updated_date` DATETIME NULL,
  `completed_date` DATETIME NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `completed` TINYINT NULL,
  `public_visibility` TINYINT NULL,
  `public_attendance` TINYINT NULL,
  `recurring` VARCHAR(45) NULL,
  `creator_id` INT NOT NULL DEFAULT 0,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goal_user1_idx` (`creator_id` ASC),
  CONSTRAINT `fk_goal_user1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `rating` INT NULL,
  `comment` TEXT NULL,
  `goal_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `review_date` DATETIME NULL,
  `active` TINYINT NULL DEFAULT 1,
  INDEX `fk_review_goal1_idx` (`goal_id` ASC),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`goal_id`, `user_id`),
  CONSTRAINT `fk_review_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `squad_has_goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad_has_goal` ;

CREATE TABLE IF NOT EXISTS `squad_has_goal` (
  `squad_id` INT NOT NULL,
  `goal_id` INT NOT NULL,
  PRIMARY KEY (`squad_id`, `goal_id`),
  INDEX `fk_squad_has_goal_goal1_idx` (`goal_id` ASC),
  INDEX `fk_squad_has_goal_squad1_idx` (`squad_id` ASC),
  CONSTRAINT `fk_squad_has_goal_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_goal_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_goal` ;

CREATE TABLE IF NOT EXISTS `user_has_goal` (
  `user_id` INT NOT NULL,
  `goal_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `goal_id`),
  INDEX `fk_user_has_goal_goal1_idx` (`goal_id` ASC),
  INDEX `fk_user_has_goal_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_goal_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_goal_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag` ;

CREATE TABLE IF NOT EXISTS `tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag_has_goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag_has_goal` ;

CREATE TABLE IF NOT EXISTS `tag_has_goal` (
  `tag_id` INT NOT NULL,
  `goal_id` INT NOT NULL,
  PRIMARY KEY (`tag_id`, `goal_id`),
  INDEX `fk_tags_has_goal_goal1_idx` (`goal_id` ASC),
  INDEX `fk_tags_has_goal_tags1_idx` (`tag_id` ASC),
  CONSTRAINT `fk_tags_has_goal_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_goal_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `squad_has_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad_has_tag` ;

CREATE TABLE IF NOT EXISTS `squad_has_tag` (
  `squad_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`squad_id`, `tag_id`),
  INDEX `fk_squad_has_tags_tags1_idx` (`tag_id` ASC),
  INDEX `fk_squad_has_tags_squad1_idx` (`squad_id` ASC),
  CONSTRAINT `fk_squad_has_tags_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_tags_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_tag` ;

CREATE TABLE IF NOT EXISTS `user_has_tag` (
  `user_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `tag_id`),
  INDEX `fk_user_has_tags_tags1_idx` (`tag_id` ASC),
  INDEX `fk_user_has_tags_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_tags_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_tags_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task` ;

CREATE TABLE IF NOT EXISTS `task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `created_date` DATETIME NULL,
  `updated_date` DATETIME NULL,
  `completed_date` DATETIME NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `completed` TINYINT NULL,
  `goal_id` INT NOT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_task_goal1_idx` (`goal_id` ASC),
  CONSTRAINT `fk_task_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_has_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task_has_task` ;

CREATE TABLE IF NOT EXISTS `task_has_task` (
  `task_id` INT NOT NULL,
  `precursor_task_id` INT NOT NULL,
  PRIMARY KEY (`task_id`, `precursor_task_id`),
  INDEX `fk_task_has_task_task2_idx` (`precursor_task_id` ASC),
  INDEX `fk_task_has_task_task1_idx` (`task_id` ASC),
  CONSTRAINT `fk_task_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_has_task_task2`
    FOREIGN KEY (`precursor_task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_task` ;

CREATE TABLE IF NOT EXISTS `user_has_task` (
  `user_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `task_id`),
  INDEX `fk_user_has_task_task1_idx` (`task_id` ASC),
  INDEX `fk_user_has_task_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_task_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `squad_has_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad_has_task` ;

CREATE TABLE IF NOT EXISTS `squad_has_task` (
  `squad_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  `points` INT NULL,
  PRIMARY KEY (`squad_id`, `task_id`),
  INDEX `fk_squad_has_task_task1_idx` (`task_id` ASC),
  INDEX `fk_squad_has_task_squad1_idx` (`squad_id` ASC),
  CONSTRAINT `fk_squad_has_task_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `badge` ;

CREATE TABLE IF NOT EXISTS `badge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(499) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `badge_has_squad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `badge_has_squad` ;

CREATE TABLE IF NOT EXISTS `badge_has_squad` (
  `badge_id` INT NOT NULL,
  `squad_id` INT NOT NULL,
  `achieved_date` DATETIME NULL,
  PRIMARY KEY (`badge_id`, `squad_id`),
  INDEX `fk_badge_has_squad_squad1_idx` (`squad_id` ASC),
  INDEX `fk_badge_has_squad_badge1_idx` (`badge_id` ASC),
  CONSTRAINT `fk_badge_has_squad_badge1`
    FOREIGN KEY (`badge_id`)
    REFERENCES `badge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_badge_has_squad_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `badge_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `badge_has_user` ;

CREATE TABLE IF NOT EXISTS `badge_has_user` (
  `badge_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `achieved_date` DATETIME NULL,
  PRIMARY KEY (`badge_id`, `user_id`),
  INDEX `fk_badge_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_badge_has_user_badge1_idx` (`badge_id` ASC),
  CONSTRAINT `fk_badge_has_user_badge1`
    FOREIGN KEY (`badge_id`)
    REFERENCES `badge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_badge_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `badge_requirement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `badge_requirement` ;

CREATE TABLE IF NOT EXISTS `badge_requirement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `badge_id` INT NOT NULL,
  `rule` VARCHAR(45) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_condition_badge1_idx` (`badge_id` ASC),
  CONSTRAINT `fk_condition_badge1`
    FOREIGN KEY (`badge_id`)
    REFERENCES `badge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image_has_goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image_has_goal` ;

CREATE TABLE IF NOT EXISTS `image_has_goal` (
  `image_id` INT NOT NULL,
  `goal_id` INT NOT NULL,
  PRIMARY KEY (`image_id`, `goal_id`),
  INDEX `fk_image_has_goal_goal1_idx` (`goal_id` ASC),
  INDEX `fk_image_has_goal_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_image_has_goal_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_has_goal_goal1`
    FOREIGN KEY (`goal_id`)
    REFERENCES `goal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image_has_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image_has_review` ;

CREATE TABLE IF NOT EXISTS `image_has_review` (
  `image_id` INT NOT NULL,
  `review_goal_id` INT NOT NULL,
  `review_user_id` INT NOT NULL,
  PRIMARY KEY (`image_id`, `review_goal_id`, `review_user_id`),
  INDEX `fk_image_has_review_review1_idx` (`review_goal_id` ASC, `review_user_id` ASC),
  INDEX `fk_image_has_review_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_image_has_review_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_has_review_review1`
    FOREIGN KEY (`review_goal_id` , `review_user_id`)
    REFERENCES `review` (`goal_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `squad_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad_message` ;

CREATE TABLE IF NOT EXISTS `squad_message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message_date` DATETIME NULL,
  `content` TEXT NULL,
  `sender_id` INT NOT NULL,
  `squad_id` INT NOT NULL,
  `reply_to_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_squad_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_squad_message_squad1_idx` (`squad_id` ASC),
  INDEX `fk_squad_message_squad_message1_idx` (`reply_to_id` ASC),
  CONSTRAINT `fk_squad_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_message_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_message_squad_message1`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `squad_message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `image` (`id`, `url`, `active`) VALUES (1, 'https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (2, 'https://static.wikia.nocookie.net/godzilla/images/3/33/Godzilla_2021.jpg/revision/latest?cb=20210314011302', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (3, 'https://static.wikia.nocookie.net/snl/images/6/66/Wild_and_crazy_guys.jpg/revision/latest?cb=20140804162910', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (4, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (5, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (6, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (7, 'https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (8, 'https://images.unsplash.com/photo-1544435253-f0ead49638fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (9, 'https://images.unsplash.com/photo-1628890923662-2cb23c2e0cfe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (10, 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (11, 'https://images.unsplash.com/photo-1639747279286-c07eecb47a0b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (12, 'https://images.unsplash.com/photo-1521856729154-7118f7181af9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (13, 'https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (14, 'https://images.unsplash.com/photo-1624561172888-ac93c696e10c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=689&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (15, 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (16, 'https://images.unsplash.com/photo-1605993439219-9d09d2020fa5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (17, 'https://images.unsplash.com/photo-1596510914965-9ae08acae566?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=749&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (18, 'https://images.unsplash.com/photo-1614289371518-722f2615943d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (19, 'https://images.unsplash.com/photo-1564222576620-3fc4b6f6bb95?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (20, 'https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=682&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (21, 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (22, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (23, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (24, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (25, 'https://images.unsplash.com/photo-1506869640319-fe1a24fd76dc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (26, 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (27, 'https://images.unsplash.com/photo-1478479405421-ce83c92fb3ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (28, 'https://images.unsplash.com/photo-1499540633125-484965b60031?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (29, 'https://images.unsplash.com/photo-1577372570570-fe08f7adc27b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (30, 'https://images.unsplash.com/photo-1563823263008-ec7877629ba0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (31, 'https://images.unsplash.com/photo-1548796819-d58b920aeffe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (32, 'https://images.unsplash.com/photo-1628336707631-68131ca720c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (33, 'https://images.unsplash.com/photo-1562577308-c8b2614b9b9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (34, 'https://images.unsplash.com/photo-1526663089957-f2aa2776f572?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (35, 'https://images.unsplash.com/photo-1502230831726-fe5549140034?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (36, 'https://images.unsplash.com/photo-1524464234682-5fa90fea2e71?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (37, 'https://images.unsplash.com/photo-1598133387813-be630df603fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (38, 'https://images.unsplash.com/photo-1531875506263-dfcc69e73475?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (39, 'https://images.unsplash.com/photo-1552010099-5dc86fcfaa38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (40, 'https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (41, 'https://images.unsplash.com/photo-1460176449511-ff5fc8e64c35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (42, 'https://images.unsplash.com/photo-1496024840928-4c417adf211d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (43, 'https://images.unsplash.com/photo-1604819360294-88464109e919?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (44, 'https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (1, 'originaltom', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'tom@myspace.com', 'Tom', 'MySpace', 'admin', 'Hi, I\'m Tom, and I\'m friends with everyone!', 1, 1, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (2, 'godzilla', '$2a$10$aGECJdshmEulChRtSjFetucbW9QWLr2kCGRZmLsHwHH4ZrVnnnaMC', 'godzilla@monster.rawr', 'Go', 'Shira', 'member', 'Hi, name\'s Godzilla. Love smashing cities and chasing damsels up skyscrapers. Oh, is that my cousin, King Kong? Oops.', 1, 2, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (3, 'member', '$2a$10$e2Unk84kCZ0.rZlRjANvTOivefToO1OeSSwkbZq3QYMFDxkY0/Rsq', 'member@member.com', 'member', 'member', 'member', 'I\'m just a basic member.', 1, 4, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (4, 'admin', '$2a$10$onMulIN7BqbrfUpsjojPzeBLC4UhGOZRce3/o6qFTuXgbMECOm.U6', 'admin@admin.com', 'admin', 'admin', 'admin', 'I\'m an admin. Jealous?', 1, 5, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (5, 'michaelshah', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'michaelshah@sgdb.com', 'Michael', 'Shah', 'member', 'My name is Michael!', 1, 6, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (6, 'marwaalvarez', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'marwaalvarez@sgdb.com', 'Marwa', 'Alvarez', 'member', 'Hi! I\'m Marwa!', 1, 7, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (7, 'aayanmassey', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'aayanmassey@sgbdb.com', 'Aayan', 'Massey', 'member', 'Hello! My name is Aayan', 1, 8, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (8, 'remizhang', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'remizhang@sgdb.com', 'Remi', 'Zhang', 'member', 'I am Remi!', 1, 9, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (9, 'ellabarber', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'ellabarber@sgdb.com', 'Ella', 'Barber', 'member', 'My name is Ella!', 1, 10, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (10, 'benjamindonaldson', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'benjamindonaldson@sgdb.com', 'Benjamin', 'Donaldson', 'member', 'Hello, I am Benjamin', 1, 11, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (11, 'juliettewicks', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'juliettewicks@sgdb.com', 'Juliette', 'Wicks', 'member', 'You can call me Julie!', 1, 12, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (12, 'owenmaddox', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'owenmaddox@sgdb.com', 'Owen', 'Maddox', 'member', 'Hi, I\'m Owen!', 1, 13, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (13, 'anishhutchinson', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'anishhutchinson@sgdb.com', 'Anish', 'Hutchinson', 'member', 'My name is Anish', 1, 14, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (14, 'fabiobolton', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'fabiobolton@sgdb.com', 'Fabio', 'Bolton', 'member', 'I am Fabio!', 1, 15, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (15, 'cindyharrison', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'cindyharrison@sgdb.com', 'Cindy', 'Harrison', 'member', 'My name is Cindy!', 1, 16, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (16, 'junaldmac', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'junaldmac@sgdb.com', 'Junald', 'Mac', 'member', 'Hello, call me Junald!', 1, 17, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (17, 'izaanhayden', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'izaanhayden@sgdb.com', 'Izaan', 'Hayden', 'member', 'I am Izaan!', 1, 18, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (18, 'shannacochran', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'shannacochran@sgdb.com', 'Shanna', 'Cochran', 'member', 'My name is Shanna!', 1, 19, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (19, 'antoninavelasquez', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'antoninavelasquez@sgdb.com', 'Antonina', 'Velasquez', 'member', 'Hi! I am Antonina!', 1, 20, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (20, 'sunilhicks', '$2a$10$/Xbq0O0qj3xvlCPa/kKnv.wbsX11CnIwPw4qLBkzhHdjoKN8k8SOi', 'sunilhicks@sgdb.com', 'Sunil', 'Hicks', 'member', 'My name is Sunil!', 1, 21, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (1, 'The OGs', 'We\'re just two wild and crazy guys!', 1, 1, 3, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (2, 'The Buddies', 'Non-stop buddy action!', 1, 5, 25, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (3, 'Too Kool for Skool', 'We fail all our classes, because it is the cool thing to do.', 1, 10, 26, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (4, 'Adventure Koalas', 'Koalas really define who we are as a squad.', 1, 15, 27, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (5, 'The Wolf Pack', 'The lone wolf dies alone', 1, 6, 28, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (6, 'Team Blue', 'We don\'t like team red', 1, 9, 29, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (7, 'Team Red', 'We don\'t like team blue', 1, 7, 31, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (8, '232 and Co.', 'There\'s no better digits than 232', 1, 8, 32, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (9, 'The Black Cats', 'Don\'t let us cross your path! It might be bad luck.', 1, 11, 33, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (10, 'The Wrecking Crew', 'We specialize in destruction. The good kind!', 1, 12, 34, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (11, 'The Breakfast Club', 'Eating breakfast like it\'s going out of style.', 1, 13, 35, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (12, 'The Avengers', 'We aren\'t the real avengers, but we can at least try!', 1, 14, 36, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (13, 'Cobras', 'Like the snake, but less slithery', 1, 15, 37, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (14, 'Kaiju Fanclub', 'We are so honored to share a website with the legendary Godzilla.', 1, 16, 38, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (15, 'Saxaphones and Soup', 'Nothing goes better together', 1, 17, 39, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (16, 'Regulators', 'We regulate everything we can.', 1, 18, 40, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (17, 'Black Eyed Threes', 'Three is the magic number', 1, 19, 41, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (18, 'Stoop Kids', 'We are trying to leave our stoops, we swear.', 1, 20, 42, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (19, 'Double Rainbows', 'There\'s a double rainbow in the sky somewhere.', 1, 13, 43, NULL);
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `created_date`) VALUES (20, 'The Colony', 'We do everything together, if we can help it.', 1, 11, 44, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (1, 1);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 1);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (5, 2);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 2);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (7, 2);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (8, 2);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (9, 2);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (10, 3);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (11, 3);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 3);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (13, 3);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (14, 3);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (16, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (17, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (18, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (20, 4);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 5);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 5);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 5);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (9, 6);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (11, 6);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (14, 6);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 6);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (7, 7);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (17, 7);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (8, 8);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 8);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (20, 8);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (11, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (3, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (18, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (10, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 9);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 10);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (13, 10);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 10);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 10);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (8, 10);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (13, 11);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (14, 11);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (4, 11);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (3, 11);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (14, 12);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 12);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (7, 12);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 13);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (5, 13);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (8, 13);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (20, 13);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 13);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (16, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (17, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (7, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (4, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (10, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (17, 15);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 15);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (18, 15);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 15);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (18, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (20, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (3, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (7, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (10, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (11, 16);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 17);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 17);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (1, 17);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (20, 18);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (4, 18);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (14, 18);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (17, 18);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (19, 18);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (13, 19);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 19);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (11, 20);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (12, 20);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 14);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (6, 20);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (15, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (1, 'Pizza party', 'Some wholesome, after-school fun!', '2022-09-20 19:54:01', '2022-09-20 19:54:01', NULL, '2022-09-23 19:30:00', '2022-09-23 21:00:00', 0, 1, 1, NULL, 1, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (2, 'Join Squad Goals', 'The first step', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (3, 'BBQ!', 'This is going to be the most fire BBQ you have ever seen!', '2022-09-25 19:54:01', NULL, NULL, '2022-09-25 19:54:01', '2022-09-30 23:00:00', 0, 1, 1, NULL, 5, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (4, 'Shoot a short film', 'We are making a short film (~15 mins) about a samurai who was George Washington\'s bodyguard during the Revolutionary War.', '2022-09-26 12:00:00', NULL, NULL, '2022-09-26 12:00:00', '2022-11-26 12:00:00', 0, 1, 1, NULL, 10, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (5, 'Play a local show!', 'Our (newly formed) band will be testing our chops at a nearby venue', '2022-09-20 12:00:00', NULL, NULL, '2022-09-20 12:00:00', '2022-10-10 19:00:00', 0, 1, 1, NULL, 15, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (6, 'Go to Vegas!', 'It is time that we solidified the alliance of this pack by making a pilgramage to sin city', '2022-09-29 11:00:00', NULL, NULL, '2022-09-29 11:00:00', '2022-10-6 12:00:00', 0, 1, 1, NULL, 6, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (7, 'Paintball!', 'We need to see who deserves to be in charge of Red Team', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 11:30:00', '2022-10-2 13:00:00', 0, 1, 1, NULL, 9, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (8, 'Archery', 'We need to see who deserves to be in charge of Team Blue', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 11:30:00', '2022-10-2 15:00:00', 0, 1, 1, NULL, 7, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (9, 'Baseball Game Tailgate', 'Food, music, drinks, and baseball', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 12:30:00', '2022-10-2 15:30:00', 0, 1, 1, NULL, 8, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (10, 'Start a Dance Crew', 'We are about to boogie down on the floor', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 13:30:00', '2022-10-2 18:30:00', 0, 1, 1, NULL, 11, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (11, 'Throw a Rager', 'Let\'s get this party started!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 12:00:00', '2022-10-5 15:30:00', 0, 1, 1, NULL, 12, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (12, 'Breakfast Banquet', 'Let\'s get our flapjack on!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 13:00:00', '2022-10-7 14:30:00', 0, 1, 1, NULL, 13, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (13, 'Larping in the Park', 'Superhero larping, time to save the world!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-30 14:00:00', '2022-10-6 11:30:00', 0, 1, 1, NULL, 14, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (14, 'Hunting Trip', 'Venison\'s back on the menu, boys!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-29 14:00:00', '2022-10-8 12:00:00', 0, 1, 1, NULL, 15, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (15, 'Godzilla Movie Marathon', 'Let\'s see how many we can watch without going to bed!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-29 15:00:00', '2022-10-3 12:00:00', 0, 1, 1, NULL, 16, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (16, 'Taco Party', 'This will bethe tastiest party EVER!', '2022-09-29 11:00:00', NULL, NULL, '2022-09-29 16:00:00', '2022-10-5 17:00:00', 0, 1, 1, NULL, 17, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (17, 'New Album Listening Party', 'This is the place to be. Your ears will thank you.', '2022-09-29 11:00:00', NULL, NULL, '2022-09-29 17:00:00', '2022-10-4 12:00:00', 0, 1, 1, NULL, 18, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (18, 'Tea Party', 'Not your granny\'s kind of tea party.', '2022-09-29 11:00:00', NULL, NULL, '2022-10-01 12:00:00', '2022-10-8 18:00:00', 0, 1, 1, NULL, 19, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (19, 'Picnic', 'Classic sandwhich picnic time!', '2022-09-29 11:00:00', NULL, NULL, '2022-10-01 13:00:00', '2022-10-6 10:00:00', 0, 1, 1, NULL, 20, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (20, 'Forest Dance Party', 'All dance styles invited!', '2022-09-29 11:00:00', NULL, NULL, '2022-10-01 14:00:00', '2022-10-8 12:00:00', 0, 1, 1, NULL, 13, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (21, 'Graduation Party!!', 'WE FINALLY DID IT!!!', '2022-09-29 11:00:00', NULL, NULL, '2022-10-01 15:00:00', '2022-10-5 19:00:00', 0, 1, 1, NULL, 11, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `review` (`rating`, `comment`, `goal_id`, `user_id`, `review_date`, `active`) VALUES (5, 'Science rules!', 1, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_has_goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (1, 1);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (1, 2);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (2, 3);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (3, 4);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (4, 5);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (5, 6);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (6, 7);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (7, 8);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (8, 9);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (9, 10);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (10, 11);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (11, 12);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (12, 13);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (13, 14);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (14, 15);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (15, 16);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (16, 17);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (17, 18);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (18, 19);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (19, 20);
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (20, 21);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user_has_goal` (`user_id`, `goal_id`) VALUES (1, 1);
INSERT INTO `user_has_goal` (`user_id`, `goal_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (1, 'fitness', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (2, 'volunteer', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (3, 'party', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (4, 'competition', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (5, 'fun', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (6, 'music', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (7, 'creative', NULL, NULL);
INSERT INTO `tag` (`id`, `name`, `description`, `active`) VALUES (8, 'food', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag_has_goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (3, 1);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (5, 1);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (8, 1);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (3, 3);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (5, 3);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (6, 3);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (8, 3);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (7, 4);
INSERT INTO `tag_has_goal` (`tag_id`, `goal_id`) VALUES (6, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_has_tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_has_tag` (`squad_id`, `tag_id`) VALUES (1, 1);
INSERT INTO `squad_has_tag` (`squad_id`, `tag_id`) VALUES (1, 2);
INSERT INTO `squad_has_tag` (`squad_id`, `tag_id`) VALUES (1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user_has_tag` (`user_id`, `tag_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `task`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`, `active`) VALUES (1, 'Buy the pizza', 'Chicago style, please', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`, `active`) VALUES (2, 'Get the Mountain Dew', 'Code Red is best, just sayin\'', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`, `active`) VALUES (3, 'Sign up for Squad Goals', 'Just do it!', NULL, NULL, NULL, NULL, NULL, 1, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_task`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user_has_task` (`user_id`, `task_id`) VALUES (1, 1);
INSERT INTO `user_has_task` (`user_id`, `task_id`) VALUES (2, 2);
INSERT INTO `user_has_task` (`user_id`, `task_id`) VALUES (1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_has_task`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_has_task` (`squad_id`, `task_id`, `points`) VALUES (1, 1, NULL);
INSERT INTO `squad_has_task` (`squad_id`, `task_id`, `points`) VALUES (1, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge` (`id`, `name`, `description`, `active`) VALUES (1, 'Super Squad', 'Any squad that reaches 100 pts receives the Super Squad badge!', NULL);
INSERT INTO `badge` (`id`, `name`, `description`, `active`) VALUES (2, 'Mother Teresa', 'Any squad that achieves 3 charitable goals within 1 year receives the Mother Teresa badge!', NULL);
INSERT INTO `badge` (`id`, `name`, `description`, `active`) VALUES (3, 'True Member', 'Any member who reaches 100 pts receive the True Member badge!', NULL);
INSERT INTO `badge` (`id`, `name`, `description`, `active`) VALUES (4, 'Old-Timer', 'Any squad that has been active for 1 year receives the Old-Timer badge!', NULL);
INSERT INTO `badge` (`id`, `name`, `description`, `active`) VALUES (5, 'Over Time', 'Any squad that completed five events in one month receives the Over Time badge!', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge_has_squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge_has_squad` (`badge_id`, `squad_id`, `achieved_date`) VALUES (1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge_has_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge_has_user` (`badge_id`, `user_id`, `achieved_date`) VALUES (3, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge_requirement`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge_requirement` (`id`, `badge_id`, `rule`, `active`) VALUES (1, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_message`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_message` (`id`, `message_date`, `content`, `sender_id`, `squad_id`, `reply_to_id`) VALUES (1, '1/2/12', 'u up?', 1, 1, NULL);
INSERT INTO `squad_message` (`id`, `message_date`, `content`, `sender_id`, `squad_id`, `reply_to_id`) VALUES (2, '1/3/13', 'yeet', 2, 1, 1);

COMMIT;

