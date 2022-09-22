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
  `profile_image_id` INT NOT NULL,
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
  `create_date` DATETIME NULL,
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
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag_has_goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag_has_goal` ;

CREATE TABLE IF NOT EXISTS `tag_has_goal` (
  `tags_id` INT NOT NULL,
  `goal_id` INT NOT NULL,
  PRIMARY KEY (`tags_id`, `goal_id`),
  INDEX `fk_tags_has_goal_goal1_idx` (`goal_id` ASC),
  INDEX `fk_tags_has_goal_tags1_idx` (`tags_id` ASC),
  CONSTRAINT `fk_tags_has_goal_tags1`
    FOREIGN KEY (`tags_id`)
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
-- Table `squad_has_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `squad_has_tags` ;

CREATE TABLE IF NOT EXISTS `squad_has_tags` (
  `squad_id` INT NOT NULL,
  `tags_id` INT NOT NULL,
  PRIMARY KEY (`squad_id`, `tags_id`),
  INDEX `fk_squad_has_tags_tags1_idx` (`tags_id` ASC),
  INDEX `fk_squad_has_tags_squad1_idx` (`squad_id` ASC),
  CONSTRAINT `fk_squad_has_tags_squad1`
    FOREIGN KEY (`squad_id`)
    REFERENCES `squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_tags_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_tags` ;

CREATE TABLE IF NOT EXISTS `user_has_tags` (
  `user_id` INT NOT NULL,
  `tags_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `tags_id`),
  INDEX `fk_user_has_tags_tags1_idx` (`tags_id` ASC),
  INDEX `fk_user_has_tags_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_tags_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_tags_tags1`
    FOREIGN KEY (`tags_id`)
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
-- Table `requirement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `requirement` ;

CREATE TABLE IF NOT EXISTS `requirement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `badge_id` INT NOT NULL,
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
  `reply_to_id` INT NULL,
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
INSERT INTO `image` (`id`, `url`) VALUES (1, 'https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg');
INSERT INTO `image` (`id`, `url`) VALUES (2, 'https://static.wikia.nocookie.net/godzilla/images/3/33/Godzilla_2021.jpg/revision/latest?cb=20210314011302');
INSERT INTO `image` (`id`, `url`) VALUES (3, 'https://static.wikia.nocookie.net/snl/images/6/66/Wild_and_crazy_guys.jpg/revision/latest?cb=20140804162910');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (1, 'originaltom', 'myspace', 'tom@myspace.com', 'Tom', 'MySpace', 'admin', 'Hi, I\'m Tom, and I\'m friends with everyone!', 1, 1, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `bio`, `active`, `profile_image_id`, `create_date`) VALUES (2, 'godzilla', 'godzilla', 'godzilla@monster.rawr', 'Go', 'Shira', 'member', 'Hi, name\'s Godzilla. Love smashing cities and chasing damsels up skyscrapers. Oh, is that my cousin, King Kong? Oops.', 1, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad` (`id`, `name`, `bio`, `active`, `leader_id`, `profile_image_id`, `create_date`) VALUES (1, 'The OGs', 'We\'re just two wild and crazy guys!', 1, 1, 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (1, 1);
INSERT INTO `user_has_squad` (`user_id`, `squad_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (1, 'Pizza party', 'Some wholesome, after-school fun!', '2022-09-20 19:54:01', '2022-09-20 19:54:01', NULL, '2022-09-23 19:30:00', '2022-09-23 21:00:00', 0, 1, 1, NULL, 1, 1);
INSERT INTO `goal` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `public_visibility`, `public_attendance`, `recurring`, `creator_id`, `active`) VALUES (2, 'Join Squad Goals', 'The first step', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `review` (`rating`, `comment`, `goal_id`, `user_id`, `review_date`) VALUES (5, 'Science rules!', 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_has_goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_has_goal` (`squad_id`, `goal_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `tag` (`id`, `name`, `description`) VALUES (1, 'fitness', NULL);
INSERT INTO `tag` (`id`, `name`, `description`) VALUES (2, 'volunteer', NULL);
INSERT INTO `tag` (`id`, `name`, `description`) VALUES (3, 'party', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag_has_goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `tag_has_goal` (`tags_id`, `goal_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `task`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`) VALUES (1, 'Buy the pizza', 'Chicago style, please', NULL, NULL, NULL, NULL, NULL, 0, 1);
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`) VALUES (2, 'Get the Mountain Dew', 'Code Red is best, just sayin\'', NULL, NULL, NULL, NULL, NULL, 0, 1);
INSERT INTO `task` (`id`, `title`, `description`, `created_date`, `updated_date`, `completed_date`, `start_date`, `end_date`, `completed`, `goal_id`) VALUES (3, 'Sign up for Squad Goals', 'Just do it!', NULL, NULL, NULL, NULL, NULL, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge` (`id`, `name`, `description`) VALUES (1, 'Super Squad', 'Any squad that reaches 100 pts receives the Super Squad badge!');
INSERT INTO `badge` (`id`, `name`, `description`) VALUES (2, 'Mother Teresa', 'Any squad that achieves 3 charitable goals within 1 year receives the Mother Teresa badge!');

COMMIT;


-- -----------------------------------------------------
-- Data for table `badge_has_squad`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `badge_has_squad` (`badge_id`, `squad_id`, `achieved_date`) VALUES (1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `requirement`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `requirement` (`id`, `badge_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `squad_message`
-- -----------------------------------------------------
START TRANSACTION;
USE `squadgoalsdb`;
INSERT INTO `squad_message` (`id`, `message_date`, `content`, `sender_id`, `squad_id`, `reply_to_id`) VALUES (1, '1/2/12', 'u up?', 1, 1, 1);

COMMIT;

