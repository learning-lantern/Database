
-- -----------------------------------------------------
-- Database LearningLanternServices
-- -----------------------------------------------------
IF DB_ID(N'[LearningLanternServices]') IS NULL
    CREATE DATABASE [LearningLanternServices];

USE [LearningLanternServices];


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[User]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[User]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[User]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Email] NVARCHAR(250) NOT NULL UNIQUE,
        [FirstName] NVARCHAR(50) NOT NULL,
        [LastName] NVARCHAR(50) NOT NULL,
        [Password] NVARCHAR(50) NOT NULL,
        [DateRegistered] DATETIME NOT NULL,
        [Telephone] NVARCHAR(25) NOT NULL,
        [Image] NVARCHAR(250) NULL,
        [IsAdmin] BIT NOT NULL DEFAULT 0
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[ConfirmedStudent]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[ConfirmedStudent]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[ConfirmedStudent]
    (
        [UserId] INT NOT NULL PRIMARY KEY,
        [ConfirmationCode] NVARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedStudents_Users]
        FOREIGN KEY([UserId])
        REFERENCES [LearningLanternServices].[dbo].[User]([Id])
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[ConfirmedInstructor]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[ConfirmedInstructor]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[ConfirmedInstructor]
    (
        [UserId] INT NOT NULL PRIMARY KEY,
        [ConfirmationCode] NVARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedInstructors_Users]
        FOREIGN KEY ([UserId])
        REFERENCES [LearningLanternServices].[dbo].[User]([Id])
        ON DELETE CASCADE
        ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Classroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Classroom]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Classroom]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentClassroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`StudentClassroom` (
  `StudentId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  INDEX `fk_Student_ClassRoom_Confirmed_Students1_idx` (`StudentId` ASC) VISIBLE,
  INDEX `fk_Student_ClassRoom_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  PRIMARY KEY (`StudentId`, `ClassroomId`),
  UNIQUE INDEX `Confirmed_Students_Users_id_UNIQUE` (`StudentId` ASC) VISIBLE,
  UNIQUE INDEX `ClassRoom_ID_UNIQUE` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_ClassRoom_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_ClassRoom_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`InstructorClassroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`InstructorClassroom` (
  `InstructorId` INT NOT NULL,
  `ClassroomId` INT NOT NULL,
  INDEX `fk_Instructor_ClassRoom_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  INDEX `fk_Instructor_ClassRoom_ClassRoom1_idx` (`ClassroomId` ASC) VISIBLE,
  PRIMARY KEY (`InstructorId`, `ClassroomId`),
  UNIQUE INDEX `Instructor_ID_UNIQUE` (`InstructorId` ASC) VISIBLE,
  UNIQUE INDEX `ClassRoom_ID_UNIQUE` (`ClassroomId` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_ClassRoom_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Instructor_ClassRoom_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Lecture` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lectures_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`TextLesson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`TextLesson` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Text_Lesson_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Video` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Quiz` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Quiz_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Exam` (
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
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`ExamQuizes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`ExamQuizes` (
  `ExamId` INT NOT NULL,
  `QuizId` INT NOT NULL,
  PRIMARY KEY (`ExamId`, `QuizId`),
  INDEX `fk_Quizes_of_Exam_Exam1_idx` (`ExamId` ASC) VISIBLE,
  INDEX `fk_Quizes_of_Exam_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  CONSTRAINT `fk_Quizes_of_Exam_Exam1`
    FOREIGN KEY (`ExamId`)
    REFERENCES `learning-lantern-services`.`Exam` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Quizes_of_Exam_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `learning-lantern-services`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentQuiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`StudentQuiz` (
  `QuizId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  `StudentAnswer` NVARCHAR(500) NOT NULL,
  `Score` DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (`QuizId`, `StudentId`),
  INDEX `fk_Student_Quizes_Confirmed_Students1_idx` (`StudentId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Quizes_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `learning-lantern-services`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Quizes_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentExam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`StudentExam` (
  `StudentId` INT NOT NULL,
  `ExamId` INT NOT NULL,
  PRIMARY KEY (`StudentId`, `ExamId`),
  INDEX `fk_Student_Exam_Exam1_idx` (`ExamId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Exam_Confirmed_Students1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Exam_Exam1`
    FOREIGN KEY (`ExamId`)
    REFERENCES `learning-lantern-services`.`Exam` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Project` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`InstructorProject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`InstructorProject` (
  `ProjectId` INT NOT NULL,
  `InstructorId` INT NOT NULL,
  PRIMARY KEY (`ProjectId`, `InstructorId`),
  INDEX `fk_Instructor_Project_Confirmed_Instructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_Project_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `learning-lantern-services`.`Project` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Instructor_Project_Confirmed_Instructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Attendance` (
  `QuizId` INT NOT NULL,
  `LectureId` INT NOT NULL,
  INDEX `fk_Attendance_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  PRIMARY KEY (`QuizId`, `LectureId`),
  INDEX `fk_Attendance_Lecture1_idx` (`LectureId` ASC) VISIBLE,
  CONSTRAINT `fk_Attendance_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `learning-lantern-services`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Attendance_Lecture1`
    FOREIGN KEY (`LectureId`)
    REFERENCES `learning-lantern-services`.`Lecture` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Team` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Score` DECIMAL(3,2) NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_team_Project1_idx` (`ProjectId` ASC) VISIBLE,
  CONSTRAINT `fk_team_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `learning-lantern-services`.`Project` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentTeam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`StudentTeam` (
  `TeamId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  PRIMARY KEY (`TeamId`, `StudentId`),
  INDEX `fk_Student_Team_Confirmed_Student1_idx` (`StudentId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Team_team1`
    FOREIGN KEY (`TeamId`)
    REFERENCES `learning-lantern-services`.`Team` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Team_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`TimeStamp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`TimeStamp` (
  `VideoId` INT NOT NULL,
  `Time` INT NOT NULL,
  `QuizId` INT NOT NULL,
  PRIMARY KEY (`VideoId`, `Time`),
  INDEX `fk_Time_stamp_Quiz1_idx` (`QuizId` ASC) VISIBLE,
  CONSTRAINT `fk_Timme_stamp_Video1`
    FOREIGN KEY (`VideoId`)
    REFERENCES `learning-lantern-services`.`Video` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Time_stamp_Quiz1`
    FOREIGN KEY (`QuizId`)
    REFERENCES `learning-lantern-services`.`Quiz` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`BackUpInstructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`BackUpInstructor` (
  `InstructorId` INT NOT NULL,
  `InstructorFirstName` NVARCHAR(50) NOT NULL,
  `InstructorLastName` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`InstructorId`),
  INDEX `fk_BackUpInstructor_ConfirmedInstructor1_idx` (`InstructorId` ASC) VISIBLE,
  CONSTRAINT `fk_BackUpInstructor_ConfirmedInstructor1`
    FOREIGN KEY (`InstructorId`)
    REFERENCES `learning-lantern-services`.`ConfirmedInstructor` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentLesson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`StudentLesson` (
  `StudentId` INT NOT NULL,
  `TextLessonId` INT NOT NULL,
  PRIMARY KEY (`StudentId`, `TextLessonId`),
  INDEX `fk_Student_Lesson_Text_Lesson1_idx` (`TextLessonId` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Lesson_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Lesson_Text_Lesson1`
    FOREIGN KEY (`TextLessonId`)
    REFERENCES `learning-lantern-services`.`TextLesson` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Event` (
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
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Todo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Todo` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `id_UNIQUE` (`Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Task` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Discription` NVARCHAR(250) NULL,
  `DueDate` DATETIME NULL,
  `TodoId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Task_TODO1_idx` (`TodoId` ASC) VISIBLE,
  CONSTRAINT `fk_Task_TODO1`
    FOREIGN KEY (`TodoId`)
    REFERENCES `learning-lantern-services`.`Todo` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`Message` (
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
    REFERENCES `learning-lantern-services`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Messages_ClassRoom1`
    FOREIGN KEY (`ClassroomId`)
    REFERENCES `learning-lantern-services`.`Classroom` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`TodoStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learning-lantern-services`.`TodoStudent` (
  `TodoId` INT NOT NULL,
  `StudentId` INT NOT NULL,
  PRIMARY KEY (`TodoId`, `StudentId`),
  INDEX `fk_TODO_has_Confirmed_Student_Confirmed_Student1_idx` (`StudentId` ASC) VISIBLE,
  INDEX `fk_TODO_has_Confirmed_Student_TODO1_idx` (`TodoId` ASC) VISIBLE,
  CONSTRAINT `fk_TODO_has_Confirmed_Student_TODO1`
    FOREIGN KEY (`TodoId`)
    REFERENCES `learning-lantern-services`.`Todo` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TODO_has_Confirmed_Student_Confirmed_Student1`
    FOREIGN KEY (`StudentId`)
    REFERENCES `learning-lantern-services`.`ConfirmedStudent` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
