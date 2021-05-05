CREATE SCHEMA `network`;

CREATE TABLE `network`.`student` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `SSN` INT(9) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `address` VARCHAR(200) NULL,
  `phone` VARCHAR(20) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `network`.`course` (
  `name` VARCHAR(200) NOT NULL,
  `student_id` INT(10) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `network`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `network`.`alumni` (
  `student_id` INT(10) NOT NULL,
  `yearsOfExperience` INT(2) NOT NULL DEFAULT 0,
  `openToJob` INT(1) NULL,
  `currentJob` VARCHAR(200) NULL,
  PRIMARY KEY (`student_id`),
    FOREIGN KEY (`student_id`)
    REFERENCES `network`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `network`.`degree` (
  `major` VARCHAR(200) NOT NULL,
  `student_id` INT(10) NOT NULL,
  `type` VARCHAR(200) NOT NULL,
  `GPA` INT(3) NULL,
  `dateOfGraduation` DATE NULL,
  PRIMARY KEY (`major`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
    FOREIGN KEY (`student_id`)
    REFERENCES `network`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `network`.`skill` (
  `student_id` INT(10) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`student_id`, `name`),
    FOREIGN KEY (`student_id`)
    REFERENCES `network`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

