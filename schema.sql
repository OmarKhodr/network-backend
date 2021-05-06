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
  `student_id` INT(10) NOT NULL,
  `major` VARCHAR(45) NOT NULL,
  `type` VARCHAR(200) NULL,
  `GPA` INT(3) NOT NULL,
  `dateOfGraduation` DATE NOT NULL,
  PRIMARY KEY (`student_id`),
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

CREATE TABLE `network`.`company` (
    `company_id` INT(10) NOT NULL,
    `company_name` VARCHAR(20) NOT NULL,
    `location` VARCHAR(200) NOT NULL,
    `number_of_employees` INT,
    `company_address` VARCHAR(20) NOT NULL,
    `field` VARCHAR(20) NOT NULL,
    `phone_number` INT(8) NOT NULL,
    `company_email` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`company_id`)
);

CREATE TABLE `network`.`jobposition` (
    `job_id` INT(10) NOT NULL,
    `company_id` INT(10) NOT NULL,
    `job_name` VARCHAR(200) NOT NULL,
    `location` VARCHAR(200) NOT NULL,
    `number_of_openings` INT NOT NULL,
    PRIMARY KEY (`job_id`),
    FOREIGN KEY (`company_id`)
     REFERENCES `network`.`company` (`company_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`salary` (
    `job_id` INT(10) NOT NULL,
    `amount` INT NOT NULL,
    `bonus` INT NOT NULL,
    `stocks` INT NOT NULL,
    `payment_rate` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`job_id`, `amount`),
    FOREIGN KEY (`job_id`)
     REFERENCES `network`.`jobposition` (`job_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`requirement` (
    `job_id` INT(10) NOT NULL,
    `requirement_name` VARCHAR(20) NOT NULL,
    `requirement_type` VARCHAR(20) NOT NULL,
    `description` VARCHAR(200) NOT NULL,
    `skill_name` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`job_id`, `requirement_name`, `requirement_type`),
    FOREIGN KEY (`job_id`)
     REFERENCES `network`.`jobposition` (`job_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`application` (
    `student_id` INT(10) NOT NULL,
    `job_id` INT(10) NOT NULL,
    `submission_date` DATE NOT NULL,
    `status` VARCHAR(20) NOT NULL,
    `skill_name` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`student_id`, `job_id`),
    FOREIGN KEY (`student_id`)
     REFERENCES `network`.`student` (`id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE,
    FOREIGN KEY (`job_id`)
     REFERENCES `network`.`jobposition` (`job_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`representative` (
    `company_id` INT(10) NOT NULL,
    `email` VARCHAR(20) NOT NULL,
    `phone_number` INT(8) NOT NULL,
    `rep_name` VARCHAR(20) NOT NULL,
    `positions` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`company_id`, `email`),
    FOREIGN KEY (`company_id`)
     REFERENCES `network`.`company` (`company_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`review` (
    `review_id` INT(10) NOT NULL,
    `company_id` INT(10) NOT NULL,
    `student_id` INT(10) NOT NULL,
    `original_poster` VARCHAR(20) NOT NULL,
    `activity` VARCHAR(20) NOT NULL,
    `overall_rating` FLOAT(2,1) NOT NULL,
    `recommended_rating` FLOAT(2,1) NOT NULL,
    `interview_rating` FLOAT(2,1) NOT NULL,
    `offer_reception` BOOLEAN NOT NULL,
    `subject` VARCHAR(20) NOT NULL,
    `body` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`review_id`),
    FOREIGN KEY (`company_id`)
     REFERENCES `network`.`company` (`company_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE,
    FOREIGN KEY (`student_id`)
     REFERENCES `network`.`student` (`id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);