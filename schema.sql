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
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
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
    `company_id` INT(10) NOT NULL AUTO_INCREMENT,
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
    `job_id` INT(10) NOT NULL AUTO_INCREMENT,
    `company_id` INT(10) NOT NULL,
    `job_name` VARCHAR(200) NOT NULL,
    INDEX `job_name_idx` (`job_name` ASC) VISIBLE,
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
  `company_id` INT(10) NOT NULL,
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  INDEX `student_id2_idx` (`student_id` ASC) VISIBLE,
  `submission_date` DATE NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`student_id`)
    REFERENCES `network`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`company_id`)
    REFERENCES `network`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


CREATE TABLE `network`.`representative` (
    `company_id` INT(10) NOT NULL,
    `email` VARCHAR(20) NOT NULL,
    `phone_number` INT(8) NOT NULL,
    PRIMARY KEY (`company_id`, `email`),
    FOREIGN KEY (`company_id`)
     REFERENCES `network`.`company` (`company_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);

CREATE TABLE `network`.`review` (
    `review_id` INT(10) NOT NULL AUTO_INCREMENT,
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

INSERT INTO `network`.`company` (`company_id`, `company_name`, `location`, `number_of_employees`, `company_address`, `field`, `phone_number`, `company_email`) VALUES ('1', 'Murex', 'Beirut', '3000', 'Beirut', 'Fintech', '12356789', 'murex@murex.com');
INSERT INTO `network`.`company` (`company_id`, `company_name`, `location`, `number_of_employees`, `company_address`, `field`, `phone_number`, `company_email`) VALUES ('2', 'CME', 'Beirut', '100', 'Beiirut', 'Software Development', '1469876543', 'cme@cme.com');
INSERT INTO `network`.`company` (`company_id`, `company_name`, `location`, `number_of_employees`, `company_address`, `field`, `phone_number`, `company_email`) VALUES ('3', 'Google', 'Europe', '10000', 'UK, London', 'Software', '183131', 'google@google.com');
INSERT INTO `network`.`company` (`company_id`, `company_name`, `location`, `number_of_employees`, `company_address`, `field`, `phone_number`, `company_email`) VALUES ('4', 'Auxi', 'US', '1000', 'Boston', 'ML', '1931211', 'auxi@auxi.com');

INSERT INTO `network`.`jobposition` (`job_id`, `company_id`, `job_name`, `location`, `number_of_openings`) VALUES ('1', '1', 'Software Development internship', 'Beirut office', '5');
INSERT INTO `network`.`jobposition` (`job_id`, `company_id`, `job_name`, `location`, `number_of_openings`) VALUES ('2', '2', 'Junior Software Engineer', 'Beirut Office', '2');
INSERT INTO `network`.`jobposition` (`job_id`, `company_id`, `job_name`, `location`, `number_of_openings`) VALUES ('3', '3', 'Software Internship', 'London Office', '2');
INSERT INTO `network`.`jobposition` (`job_id`, `company_id`, `job_name`, `location`, `number_of_openings`) VALUES ('4', '4', 'Ai Internship', 'Remote', '4');

INSERT INTO `network`.`student` (`id`, `SSN`, `email`, `name`, `address`, `phone`) VALUES ('1', '111111111', 'hussein@mail.aub.edu', 'Hussein Jaber', 'Beirut', '1435536');
INSERT INTO `network`.`student` (`id`, `SSN`, `email`, `name`, `address`, `phone`) VALUES ('2', '222222222', 'simon@mail.aub.edu', 'Simon Zouki', 'Zalka', '52053023');
INSERT INTO `network`.`student` (`id`, `SSN`, `email`, `name`, `address`, `phone`) VALUES ('3', '333333333', 'omar@mail.aub.edu', 'Omar Khodr', 'Saudi', '1281913');
INSERT INTO `network`.`student` (`id`, `SSN`, `email`, `name`, `address`, `phone`) VALUES ('4', '444444444', 'karim@mail.aub.edu', 'Karim Zarzour', 'Beirut', '31831713');
INSERT INTO `network`.`student` (`id`, `SSN`, `email`, `name`, `address`, `phone`) VALUES ('5', '555555555', 'mahdi@mail.aub.edu', 'Mahdi Jaber', 'Beirut', '183123713');

INSERT INTO `network`.`alumni` (`student_id`, `yearsOfExperience`, `openToJob`, `currentJob`) VALUES ('5', '3', '0', 'Backend Engineer');

INSERT INTO `network`.`degree` (`student_id`, `major`, `type`, `GPA`, `dateOfGraduation`) VALUES ('1', 'CSE', 'BE', '82', '2022-05-27');
INSERT INTO `network`.`degree` (`student_id`, `major`, `type`, `GPA`, `dateOfGraduation`) VALUES ('2', 'CCE', 'BE', '88', '2022-05-27');
INSERT INTO `network`.`degree` (`student_id`, `major`, `type`, `GPA`, `dateOfGraduation`) VALUES ('3', 'ECE', 'BE', '89', '2022-05-28');
INSERT INTO `network`.`degree` (`student_id`, `major`, `type`, `GPA`, `dateOfGraduation`) VALUES ('4', 'CSE', 'BE', '85', '2022-05-28');

INSERT INTO `network`.`application` (`student_id`, `company_id`, `id`, `submission_date`, `status`) VALUES ('1', '1', '1', '2021-01-03', 'Submitted');
INSERT INTO `network`.`application` (`student_id`, `company_id`, `id`, `submission_date`, `status`) VALUES ('2', '1', '2', '2021-01-03', 'Submitted');
INSERT INTO `network`.`application` (`student_id`, `company_id`, `id`, `submission_date`, `status`) VALUES ('3', '2', '3', '2021-03-02', 'Ongoing');
INSERT INTO `network`.`application` (`student_id`, `company_id`, `id`, `submission_date`, `status`) VALUES ('4', '3', '4', '2021-03-04', 'Accepted');

INSERT INTO `network`.`salary` (`job_id`, `amount`, `bonus`, `stocks`, `payment_rate`) VALUES ('2', '20000', '2000', '0', 'Year');
INSERT INTO `network`.`salary` (`job_id`, `amount`, `bonus`, `stocks`, `payment_rate`) VALUES ('1', '30000', '2500', '1', 'Month');
INSERT INTO `network`.`salary` (`job_id`, `amount`, `bonus`, `stocks`, `payment_rate`) VALUES ('3', '10000', '3000', '1', 'Year');
INSERT INTO `network`.`salary` (`job_id`, `amount`, `bonus`, `stocks`, `payment_rate`) VALUES ('4', '25000', '1000', '0', 'Month');

INSERT INTO `network`.`course` (`name`, `student_id`) VALUES ('Data Structures', '1');
INSERT INTO `network`.`course` (`name`, `student_id`) VALUES ('Machine Learning', '2');
INSERT INTO `network`.`course` (`name`, `student_id`) VALUES ('Internet Security', '3');
INSERT INTO `network`.`course` (`name`, `student_id`) VALUES ('Databases ', '4');

INSERT INTO `network`.`skill` (`student_id`, `name`) VALUES ('1', 'C++');
INSERT INTO `network`.`skill` (`student_id`, `name`) VALUES ('2', 'Python');
INSERT INTO `network`.`skill` (`student_id`, `name`) VALUES ('3', 'Java');
INSERT INTO `network`.`skill` (`student_id`, `name`) VALUES ('4', 'Javascript');

INSERT INTO `network`.`representative` (`company_id`, `email`, `phone_number`) VALUES ('1', 'asd@mail.com', '123812371');
INSERT INTO `network`.`representative` (`company_id`, `email`, `phone_number`) VALUES ('2', 'jdas@mail.com', '312313');
INSERT INTO `network`.`representative` (`company_id`, `email`, `phone_number`) VALUES ('3', 'lda@mail.com', '31923219');
INSERT INTO `network`.`representative` (`company_id`, `email`, `phone_number`) VALUES ('4', 'jaso@mail.com', '93123');

INSERT INTO `network`.`requirement` (`job_id`, `requirement_name`, `requirement_type`, `description`, `skill_name`) VALUES ('1', 'Programming', 'Engineering', 'Good in C++', 'C++');
INSERT INTO `network`.`requirement` (`job_id`, `requirement_name`, `requirement_type`, `description`, `skill_name`) VALUES ('2', 'Data Science', 'Machine Learning', 'Proficient in Python', 'Python');
INSERT INTO `network`.`requirement` (`job_id`, `requirement_name`, `requirement_type`, `description`, `skill_name`) VALUES ('3', 'Gui Development', 'Frontend', '3 years of experience in Javafx', 'Javafx');
INSERT INTO `network`.`requirement` (`job_id`, `requirement_name`, `requirement_type`, `description`, `skill_name`) VALUES ('4', 'Database management', 'Bakend', 'Excellent in MySQL', 'MySQL');

Select name, GPA from (Select id, name, GPA from network.degree INNER JOIN 
(Select student_id as id, name from network.student INNER JOIN 
(Select * from network.application where company_id = 
(Select company_id from network.company where company_name = 'Murex'))
 as MyCompany on MyCompany.student_id = network.student.id) as 
 MyStudents on MyStudents.id = network.degree.student_id) as 
 Result where Result.GPA >= 85

 SELECT company_name, job_name, amount FROM network.jobposition 
 inner join network.company on network.jobposition.company_id=network.company.company_id  
 inner join network.salary on network.jobposition.job_id=network.salary.job_id WHERE amount > 20000


SELECT company_name, job_name FROM network.jobposition inner join network.company on network.jobposition.company_id=network.company.company_id WHERE job_name like '%intern%' 


 SELECT s.id, s.name FROM network.student s JOIN network.degree d ON s.id=d.student_id WHERE dateOfGraduation <= '2026-01-01' AND major='CSE'