
-- -----------------------------------------------------
-- Database [LearningLanternServices]
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
        [Email] VARCHAR(250) NOT NULL UNIQUE,
        [FirstName] NVARCHAR(50) NOT NULL,
        [LastName] NVARCHAR(50) NOT NULL,
        [Password] VARCHAR(50) NOT NULL,
        [DateRegistered] DATETIME NOT NULL,
        [Telephone] VARCHAR(25) NOT NULL UNIQUE,
        [Image] VARCHAR(250) NULL,
        [IsAdmin] BIT NOT NULL DEFAULT 0
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[ConfirmedStudent]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[ConfirmedStudent]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[ConfirmedStudent]
    (
        [UserId] INT NOT NULL PRIMARY KEY,
        [ConfirmationCode] VARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedStudent_User]
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
        [ConfirmationCode] VARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedInstructor_User]
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
-- Table [LearningLanternServices].[dbo].[StudentClassroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentClassroom]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[StudentClassroom]
    (
        [StudentId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        PRIMARY KEY ([StudentId], [ClassroomId]),
        CONSTRAINT [FK_StudentClassRoom_ConfirmedStudent]
            FOREIGN KEY ([StudentId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentClassRoom_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[InstructorClassroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[InstructorClassroom]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[InstructorClassroom]
    (
        [InstructorId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        PRIMARY KEY ([InstructorId], [ClassroomId]),
        CONSTRAINT [FK_InstructorClassRoom_ConfirmedInstructor]
            FOREIGN KEY ([InstructorId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_InstructorClassRoom_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Lecture]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Lecture]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Lecture]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [StartDate] DATETIME NOT NULL,
        [EndDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_Lecture_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Lecture_ConfirmedInstructor]
            FOREIGN KEY ([InstructorId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[TextLesson]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[TextLesson]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[TextLesson]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [Printable] BIT NOT NULL DEFAULT FALSE,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_TextLesson_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TextLesson_ConfirmedInstructor]
            FOREIGN KEY ([InstructorId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Video]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Video]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Video]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_Video_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Video_ConfirmedInstructor]
            FOREIGN KEY ([InstructorId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


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
-- Table [LearningLanternServices].[dbo].[Attendance]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Attendance]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Attendance]
    (
        [QuizId] INT NOT NULL,
        [LectureId] INT NOT NULL,
        PRIMARY KEY([QuizId], [LectureId]),
        CONSTRAINT [FK_Attendance_Quiz]
            FOREIGN KEY ([QuizId])
            REFERENCES [LearningLanternServices].[dbo].[Quiz]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Attendance_Lecture]
            FOREIGN KEY ([LectureId])
            REFERENCES [LearningLanternServices].[dbo].[Lecture]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Team]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Team]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Team]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Score] DECIMAL(3,2) NULL,
        [ProjectId] INT NOT NULL,
        CONSTRAINT [FK_Team_Project]
            FOREIGN KEY ([ProjectId])
            REFERENCES [LearningLanternServices].[dbo].[Project]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[StudentTeam]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentTeam]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[StudentTeam]
    (
        [TeamId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        PRIMARY KEY([TeamId], [StudentId]),
        CONSTRAINT [FK_StudentTeam_Team]
            FOREIGN KEY ([TeamId])
            REFERENCES [LearningLanternServices].[dbo].[Team]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentTeam_ConfirmedStudent]
            FOREIGN KEY ([StudentId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent]([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[TimeStamp]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[TimeStamp]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[TimeStamp] 
    (
        [VideoId] INT NOT NULL,
        [Time] INT NOT NULL,
        [QuizId] INT NOT NULL,
        PRIMARY KEY([VideoId], [Time]),
        CONSTRAINT [FK_TimeStamp_Video]
            FOREIGN KEY ([VideoId])
            REFERENCES [LearningLanternServices].[dbo].[Video] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TimeStamp_Quiz]
            FOREIGN KEY ([QuizId])
            REFERENCES [LearningLanternServices].[dbo].[Quiz] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[BackUpInstructor]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[BackUpInstructor]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[BackUpInstructor]
    (
        [InstructorId] INT NOT NULL PRIMARY KEY,
        [InstructorFirstName] NVARCHAR(50) NOT NULL,
        [InstructorLastName] NVARCHAR(50) NOT NULL,
        CONSTRAINT [FK_BackUpInstructor_ConfirmedInstructor]
            FOREIGN KEY ([InstructorId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[StudentLesson]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentLesson]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[StudentLesson]
    (
        [StudentId] INT NOT NULL,
        [TextLessonId] INT NOT NULL,
        PRIMARY KEY([StudentId], [TextLessonId]),
        CONSTRAINT [FK_StudentLesson_ConfirmedStudent]
            FOREIGN KEY ([StudentId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentLesson_TextLesson]
            FOREIGN KEY ([TextLessonId])
            REFERENCES [LearningLanternServices].[dbo].[TextLesson] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Event]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Event]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[Event]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [StartDate] DATETIME NOT NULL,
        [EndDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Event_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES  [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Todo]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Todo]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[Todo]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Task]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Task]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[Task]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [DueDate] DATETIME NULL,
        [TodoId] INT NOT NULL,
        CONSTRAINT [FK_Task_Todo]
            FOREIGN KEY ([TodoId])
            REFERENCES [LearningLanternServices].[dbo].[Todo] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Message]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Message]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[Message]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Type] VARCHAR(10) NOT NULL,
        [Body] VARCHAR(250) NOT NULL,
        [Replay] INT NULL DEFAULT NULL,
        [Date] DATETIME NOT NULL,
        [UserId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Message_User]
            FOREIGN KEY ([UserId])
            REFERENCES [LearningLanternServices].[dbo].[User] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Message_ClassRoom]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[TodoStudent]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[TodoStudent]', N'U') IS NULL
    CREATE TABLE  [LearningLanternServices].[dbo].[TodoStudent]
    (
        [TodoId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        PRIMARY KEY([TodoId], [StudentId]),
        CONSTRAINT [FK_TodoStudent_Todo]
            FOREIGN KEY ([TodoId])
            REFERENCES [LearningLanternServices].[dbo].[Todo] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TodoStudent_ConfirmedStudent]
            FOREIGN KEY ([StudentId])
            REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
