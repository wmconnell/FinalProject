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
INSERT INTO `image` (`id`, `url`, `active`) VALUES (6, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (7, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (8, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (9, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (10, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (11, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (12, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (13, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (14, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (15, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (16, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (17, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (18, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (19, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (20, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (21, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (22, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (23, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (24, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (25, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (26, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (27, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (28, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (29, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);
INSERT INTO `image` (`id`, `url`, `active`) VALUES (30, 'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg', 1);

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

