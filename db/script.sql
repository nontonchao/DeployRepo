-- MySQL Script generated by MySQL Workbench
	-- Wed Apr 20 16:41:48 2022
	-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
	-- Schema OASIP
-- -----------------------------------------------------

-- -----------------------------------------------------
	-- Schema OASIP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OASIP` DEFAULT CHARACTER SET utf8 ;
USE `OASIP` ;

-- -----------------------------------------------------
	-- Table `OASIP`.`event_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OASIP`.`event_category` (
	`eventCategory_id` INT NOT NULL,
	`eventCategoryName` VARCHAR(45) NOT NULL UNIQUE,
	`eventCategoryDescription` VARCHAR(500) NULL,
	`eventDuration` INT NOT NULL,
PRIMARY KEY (`eventCategory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
	-- Table `OASIP`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OASIP`.`event` (
	`event_id` INT NOT NULL AUTO_INCREMENT,
	`bookingName` VARCHAR(100) NOT NULL,
	`bookingEmail` VARCHAR(255) NOT NULL,
	`eventStartTime` TIMESTAMP NOT NULL,
	`eventDuration` INT NOT NULL,
	`eventNotes` VARCHAR(500) NULL,
	`eventCategory` INT NOT NULL,
	PRIMARY KEY (`event_id`),
	INDEX `fk_event_event_category_idx` (`eventCategory` ASC) VISIBLE,
	CONSTRAINT `fk_event_event_category`
    FOREIGN KEY (`eventCategory`)
    REFERENCES `OASIP`.`event_category` (`eventCategory_id`)
    ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE USER 'dev'@'%' IDENTIFIED WITH mysql_native_password BY '0000';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%';
flush PRIVILEGES;
use OASIP;
insert into event_category values (1,'Project Management Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคำปรึกษา','30');
insert into event_category values (2,'DevOps/Infra Clinic','Use this event category for DevOps/Infra clinic.','20');
insert into event_category values (3,'Database Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย database clinic ใน วิชา INT221 integrated project I','15');
insert into event_category values (4,'Client-side Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย client-side clinic ใน วิชา INT221 integrated project I','30');
insert into event_category values (5,'Server-side Clinic','','30');
insert into event values (1,'Somchai Jaidee (OR-7)','somchai.jai@mail.kmutt.ac.th','2022-05-23 6:30:00',30,'',2);
insert into event values (2,'Somsri Rakdee (SJ-3)','somsri.rak@mail.kmutt.ac.th','2022-04-27 6:30:00',30,'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน',1);
insert into event values (3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 9:30:00',15,'',3);
insert into event values (4,'สมส่วน สุขศรี','somsuan.s@kmutt.ac.th','2022-07-31 23:00:00',30,'',5);
insert into event values (5,'0001-0002-0003-0004-0005-0006-0007-0008-0009-0010-0011-0012-0013-0014-0015-0016-0017-0018-0019-0020-','this.is.my.very.long.test.email@kmutt.ac.th','2022-12-31 17:15:00',20,'0001-0002-0003-0004-0005-0006-0007-0008-0009-0010-0011-0012-0013-0014-0015-0016-0017-0018-0019-0020-0021-0022-0023-0024-0025-0026-0027-0028-0029-0030-0031-0032-0033-0034-0035-0036-0037-0038-0039-0040-0041-0042-0043-0044-0045-0046-0047-0048-0049-0050-0051-0052-0053-0054-0055-0056-0057-0058-0059-0060-0061-0062-0063-0064-0065-0066-0067-0068-0069-0070-0071-0072-0073-0074-0075-0076-0077-0078-0079-0080-0081-0082-0083-0084-0085-0086-0087-0088-0089-0090-0091-0092-0093-0094-0095-0096-0097-0098-0099-0100-',2);
insert into event values (6,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-24 7:00:00',15,'ขอปรึกษาเอกสารในวิชาที่ต้องส่ง',3);
insert into event values (7,'Somsri Rakdee (SJ-3)','somsri.rak@mail.kmutt.ac.th','2022-05-24 8:45:00',30,'',1);
insert into event values (8,'Somchai Jaidee (OR-7)','somchai.jai@mail.kmutt.ac.th','2022-05-23 6:30:00',20,'ขอปรึกษาเอกสารในวิชาที่ต้องส่ง',2);
insert into event values (9,'สมเกียรติ ไม่ขยันเรียน','somkiat.mai@kmutt.ac.th','2022-05-24 7:00:00',30,'',4);