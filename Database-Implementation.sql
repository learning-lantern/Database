-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LMS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LMS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LMS` DEFAULT CHARACTER SET utf8 ;
USE `LMS` ;

-- -----------------------------------------------------
-- Table `LMS`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Email` NVARCHAR(250) NOT NULL,
  `FirstName` NVARCHAR(50) NOT NULL,
  `LastName` NVARCHAR(50) NOT NULL,
  `Password` NVARCHAR(50) NOT NULL,
  `DateRegistered` DATETIME NOT NULL,
  `Telephone` NVARCHAR(25) NOT NULL,
  `Image` NVARCHAR(250) NULL,
  `IsAdmin` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `id_UNIQUE` (`Id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`ConfirmedStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`ConfirmedStudent` (
  `UserId` INT NOT NULL,
  `ConfirmationCode` NVARCHAR(10) NOT NULL,
  `ConfirmationDate` DATETIME NOT NULL,
  UNIQUE INDEX `confirmationCode_UNIQUE` (`ConfirmationCode` ASC) VISIBLE,
  INDEX `fk_Confirmed_Students_Users1_idx` (`UserId` ASC) VISIBLE,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `Users_id_UNIQUE` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_Confirmed_Students_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `LMS`.`User` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`ConfirmedInstructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`ConfirmedInstructor` (
  `UserId` INT NOT NULL,
  `ConfirmationCode` NVARCHAR(10) NOT NULL,
  `ConfirmationDate` DATETIME NOT NULL,
  UNIQUE INDEX `Confirmation_code_UNIQUE` (`ConfirmationCode` ASC) VISIBLE,
  INDEX `fk_Confirmed_Instructor_Users1_idx` (`UserId` ASC) VISIBLE,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `Users_id_UNIQUE` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_Confirmed_Instructor_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `LMS`.`User` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Classroom` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ID_UNIQUE` (`Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`StudentClassroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`StudentClassroom` (
  `StudentId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  INDEX `fk_Student_ClassRoom_Confirmed_Students1_idx` (`StudentId` ASC) VISIBLE,
  INDEX `fk_Student_ClassRoom_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  PRIMARY KEY (`StudentId`, `ClassroomId`),
  UNIQUE INDEX `Confirmed_Students_Users_id_UNIQUE` (`StudentId` ASC) VISIBLE,
  UNIQUE INDEX `ClassRoom_ID_UNIQUE` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_ClassRoom_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_ClassRoom_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`InstructorClassroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`InstructorClassroom` (
  `InstructorId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  INDEX `fk_Instructor_ClassRoom_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  INDEX `fk_Instructor_ClassRoom_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  PRIMARY KEY (`InstructorId`, `ClassroomId`),
  UNIQUE INDEX `Instructor_ID_UNIQUE` (`InstructorId` ASC) VISIBLE,
  UNIQUE INDEX `ClassRoom_ID_UNIQUE` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_ClassRoom_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Instructor_ClassRoom_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Lecture` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `StartDate` DATETIME NOT NULL,
  `EndDate` DATETIME NOT NULL,
  `ClassroomId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `id_UNIQUE` (`Id` ASC) VISIBLE,
  INDEX `fk_Lectures_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  INDEX `fk_Lectures_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Lectures_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lectures_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`TextLesson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`TextLesson` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `Printable` BIT NOT NULL DEFAULT FALSE,
  `ClassroomId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ID_UNIQUE` (`Id` ASC) VISIBLE,
  INDEX `fk_Text_Lesson_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  INDEX `fk_Text_Lesson_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Text_Lesson_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Text_Lesson_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Video` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `ClassroomId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Video_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  INDEX `fk_Video_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Video_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Quiz` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Score` DECIMAL(3,2) NOT NULL,
  `Time` DATETIME NOT NULL,
  `IsAttendance` BIT NOT NULL,
  `Answer` NVARCHAR(10) NOT NULL,
  `ClassroomId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Quiz_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  INDEX `fk_Quiz_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Quiz_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Quiz_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Exam` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Score` DECIMAL(3,2) NOT NULL,
  `Time` DATETIME NOT NULL,
  `StartDate` DATETIME NOT NULL,
  `Shuffle` BIT NOT NULL,
  `ShowScore` BIT NOT NULL,
  `InstructorId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Exam_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  INDEX `fk_Exam_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Exam_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`ExamQuizes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`ExamQuizes` (
  `ExamId` INT NOT NULL,
  `QuizId` INT NOT NULL,
  PRIMARY KEY (`ExamId`, `QuizId`),
  INDEX `fk_Quizes_of_Exam_Exam1_idx` (`ExamId` ASC) VISIBLE,
  INDEX `fk_Quizes_of_Exam_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  CONSTRAINT `fk_Quizes_of_Exam_Exam1`
    FOREIGN KEY (`ExamId`)
    REFERENCES `LMS`.`Exam` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Quizes_of_Exam_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `LMS`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`StudentQuiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`StudentQuiz` (
  `QuizId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  `StudentAnswer` NVARCHAR(500) NOT NULL,
  `Score` DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (`QuizId`, `StudentId`),
  INDEX `fk_Student_Quizes_Confirmed_Students1_idx` (`StudentId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Quizes_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `LMS`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Quizes_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`StudentExam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`StudentExam` (
  `StudentId` INT NOT NULL,
  `ExamId` INT NOT NULL,
  PRIMARY KEY (`StudentId`, `ExamId`),
  INDEX `fk_Student_Exam_Exam1_idx` (`ExamId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Exam_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Exam_Exam1`
    FOREIGN KEY (`ExamId`)
    REFERENCES `LMS`.`Exam` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Project` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `Score` DECIMAL(3,2) NOT NULL,
  `MaxNumber` INT NOT NULL,
  `DueDate` DATETIME NOT NULL,
  `ClassroomId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Project_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Project_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`InstructorProject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`InstructorProject` (
  `ProjectId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`ProjectId`, `InstructorId`),
  INDEX `fk_Instructor_Project_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_Project_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `LMS`.`Project` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Instructor_Project_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Attendance` (
  `QuizId` INT NOT NULL,
  `LectureId` INT NOT NULL,
  INDEX `fk_Attendance_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  PRIMARY KEY (`QuizId`, `LectureId`),
  INDEX `fk_Attendance_Lecture1_idx` (`LectureId` ASC) VISIBLE,
  CONSTRAINT `fk_Attendance_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `LMS`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Attendance_Lecture1`
    FOREIGN KEY (`LectureId`)
    REFERENCES `LMS`.`Lecture` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Team` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Score` DECIMAL(3,2) NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_team_Project1_idx` (`ProjectId` ASC) VISIBLE,
  CONSTRAINT `fk_team_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `LMS`.`Project` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`StudentTeam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`StudentTeam` (
  `TeamId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  PRIMARY KEY (`TeamId`, `StudentId`),
  INDEX `fk_Student_Team_Confirmed_Student1_idx` (`StudentId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Team_team1`
    FOREIGN KEY (`TeamId`)
    REFERENCES `LMS`.`Team` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Team_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`TimeStamp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`TimeStamp` (
  `VideoId` INT NOT NULL,
  `Time` INT NOT NULL,
  `QuizId` INT NOT NULL,
  PRIMARY KEY (`VideoId`, `Time`),
  INDEX `fk_Time_stamp_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  CONSTRAINT `fk_Timme_stamp_Video1`
    FOREIGN KEY (`VideoId`)
    REFERENCES `LMS`.`Video` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Time_stamp_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `LMS`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`BackUpInstructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`BackUpInstructor` (
  `InstructorId` INT NOT NULL,
  `InstructorFirstName` NVARCHAR(50) NOT NULL,
  `InstructorLastName` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`InstructorId`),
  INDEX `fk_BackUpInstructor_ConfirmedInstructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_BackUpInstructor_ConfirmedInstructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `LMS`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`StudentLesson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`StudentLesson` (
  `StudentId` INT NOT NULL,
  `TextLessonId` INT NOT NULL,
  PRIMARY KEY (`StudentId`, `TextLessonId`),
  INDEX `fk_Student_Lesson_Text_Lesson1_idx` (`TextLessonId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Lesson_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Lesson_Text_Lesson1`
    FOREIGN KEY (`TextLessonId`)
    REFERENCES `LMS`.`TextLesson` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Event` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `StartDate` DATETIME NOT NULL,
  `EndDate` DATETIME NOT NULL,
  `ClassroomId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Events_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Events_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Todo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Todo` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `id_UNIQUE` (`Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Task` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `DueDate` DATETIME NULL,
  `TodoId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Task_TODO1_idx` (`TodoId` ASC) VISIBLE,
  CONSTRAINT `fk_Task_TODO1`
    FOREIGN KEY (`TodoId`)
    REFERENCES `LMS`.`Todo` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`Message` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Type` NVARCHAR(10) NOT NULL,
  `Body` NVARCHAR(250) NOT NULL,
  `Replay` INT NULL DEFAULT NULL,
  `Date` DATETIME NOT NULL,
  `UserId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ID_UNIQUE` (`Id` ASC) VISIBLE,
  INDEX `fk_Messages_User1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_Messages_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Messages_User1`
    FOREIGN KEY (`UserId`)
    REFERENCES `LMS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Messages_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `LMS`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LMS`.`TodoStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LMS`.`TodoStudent` (
  `TodoId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  PRIMARY KEY (`TodoId`, `StudentId`),
  INDEX `fk_TODO_has_Confirmed_Student_Confirmed_Student1_idx` (`StudentId` ASC) VISIBLE,
  INDEX `fk_TODO_has_Confirmed_Student_TODO1_idx` (`TodoId` ASC) VISIBLE,
  CONSTRAINT `fk_TODO_has_Confirmed_Student_TODO1`
    FOREIGN KEY (`TodoId`)
    REFERENCES `LMS`.`Todo` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TODO_has_Confirmed_Student_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `LMS`.`ConfirmedStudent` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
