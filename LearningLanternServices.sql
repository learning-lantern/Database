
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
        [ConfirmationCode] NVARCHAR(10) NOT NULL UNIQUE,
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
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Quiz]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Quiz]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1) ,
        [Score] DECIMAL(3,2) NOT NULL,
        [Time] DATETIME NOT NULL,
        [IsAttendance] BIT NOT NULL,
        [Answer] NVARCHAR(10) NOT NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [fk_Quiz_ClassRoom1]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [learning-lantern-services].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [fk_Quiz_Confirmed_Instructor1]
            FOREIGN KEY ([InstructorId])
            REFERENCES [learning-lantern-services].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Exam`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Exam]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Exam]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Score] DECIMAL(3,2) NOT NULL,
        [Time] DATETIME NOT NULL,
        [StartDate] DATETIME NOT NULL,
        [Shuffle] BIT NOT NULL,
        [ShowScore] BIT NOT NULL,
        [InstructorId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [fk_Exam_Confirmed_Instructor1]
            FOREIGN KEY ([InstructorId])
            REFERENCES [learning-lantern-services].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT [fk_Exam_ClassRoom1]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [learning-lantern-services].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`ExamQuizes`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[ExamQuizes]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[ExamQuizes]
    (
        [ExamId] INT NOT NULL,
        [QuizId] INT NOT NULL,
        PRIMARY KEY ([ExamId], [QuizId]),
        CONSTRAINT [fk_Quizes_of_Exam_Exam1]
            FOREIGN KEY ([ExamId])
            REFERENCES [learning-lantern-services].[Exam] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [fk_Quizes_of_Exam_Quiz1]
            FOREIGN KEY ([QuizId])
            REFERENCES [learning-lantern-services].[Quiz] ([Id])
            ON DELETE CASCADE
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentQuiz`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentQuiz]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[StudentQuiz]
    (
        [QuizId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        [StudentAnswer] NVARCHAR(500) NOT NULL,
        [Score] DECIMAL(3,2) NOT NULL,
        PRIMARY KEY ([QuizId], [StudentId]),
        CONSTRAINT [fk_Student_Quizes_Quiz1]
            FOREIGN KEY ([QuizId])
            REFERENCES [learning-lantern-services].[Quiz] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [fk_Student_Quizes_Confirmed_Students1]
            FOREIGN KEY ([StudentId])
            REFERENCES [learning-lantern-services].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`StudentExam`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentExam]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[StudentExam]
    (
        [StudentId] INT NOT NULL,
        [ExamId] INT NOT NULL,
        PRIMARY KEY ([StudentId], [ExamId]),
        CONSTRAINT [fk_Student_Exam_Confirmed_Students1]
            FOREIGN KEY ([StudentId])
            REFERENCES [learning-lantern-services].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [fk_Student_Exam_Exam1]
            FOREIGN KEY ([ExamId])
            REFERENCES [learning-lantern-services].[Exam] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`Project`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Project]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[Project]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [Score] DECIMAL(3,2) NOT NULL,
        [MaxNumber] INT NOT NULL,
        [DueDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [fk_Project_ClassRoom1]
            FOREIGN KEY ([ClassroomId])
            REFERENCES [learning-lantern-services].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `learning-lantern-services`.`InstructorProject`
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[InstructorProject]', N'U') IS NULL
    CREATE TABLE [LearningLanternServices].[dbo].[InstructorProject]
    (
        [ProjectId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        PRIMARY KEY ([ProjectId], [InstructorId]),
        CONSTRAINT [fk_Instructor_Project_Project1]
            FOREIGN KEY ([ProjectId])
            REFERENCES [learning-lantern-services].[Project] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [fk_Instructor_Project_Confirmed_Instructor1]
            FOREIGN KEY ([InstructorId])
            REFERENCES [learning-lantern-services].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Attendance]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Attendance]', N'U') IS NULL
CREATE TABLE [LearningLanternServices].[dbo].[Attendance](
  [QuizId] INT NOT NULL PRIMARY KEY,
  [LectureId] INT NOT NULL PRIMARY KEY,
  CONSTRAINT [fk_Attendance_Quiz1]
    FOREIGN KEY ([QuizId])
    REFERENCES [LearningLanternServices].[dbo].[Quiz]([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT [fk_Attendance_Lecture1]
    FOREIGN KEY ([LectureId])
    REFERENCES [LearningLanternServices].[dbo].[Lecture]([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Team]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Team]', N'U') IS NULL
CREATE TABLE [LearningLanternServices].[dbo].[Team](
  [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
  [Score] DECIMAL(3,2) NULL,
  [ProjectId] INT NOT NULL,
  CONSTRAINT [fk_team_Project1]
    FOREIGN KEY ([ProjectId])
    REFERENCES [LearningLanternServices].[dbo].[Project]([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



-- -----------------------------------------------------
-- Table `[LearningLanternServices].[dbo].[StudentTeam]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentTeam]', N'U') IS NULL
CREATE TABLE [LearningLanternServices].[dbo].[StudentTeam] (
  [TeamId] INT NOT NULL PRIMARY KEY,
  [StudentId] INT NOT NULL PRIMARY KEY,
  CONSTRAINT [fk_Student_Team_team1]
    FOREIGN KEY ([TeamId])
    REFERENCES [LearningLanternServices].[dbo].[Team]([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT [fk_Student_Team_Confirmed_Student1]
    FOREIGN KEY ([StudentId])
    REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent]([UserId])
    ON DELETE CASCADE
    ON UPDATE CASCADE
	
);



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[TimeStamp]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[TimeStamp]', N'U') IS NULL
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE  [LearningLanternServices].[dbo].[TimeStamp] (
  [VideoId] INT NOT NULL PRIMARY KEY,
  [Time] INT NOT NULL PRIMARY KEY,
  [QuizId] INT NOT NULL,
  CONSTRAINT [fk_Timme_stamp_Video1]
    FOREIGN KEY ([VideoId])
    REFERENCES [LearningLanternServices].[dbo].[Video] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT [fk_Time_stamp_Quiz1]
    FOREIGN KEY ([QuizId])
    REFERENCES [LearningLanternServices].[dbo].[Quiz] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table `[LearningLanternServices].[dbo].[BackUpInstructor]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[BackUpInstructor]', N'U') IS NULL
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE  [LearningLanternServices].[dbo].[BackUpInstructor] (
  [InstructorId] INT NOT NULL PRIMARY KEY,
  [InstructorFirstName] NVARCHAR(50) NOT NULL,
  [InstructorLastName] NVARCHAR(50) NOT NULL,
  CONSTRAINT [fk_BackUpInstructor_ConfirmedInstructor1]
    FOREIGN KEY ([InstructorId])
    REFERENCES [LearningLanternServices].[dbo].[ConfirmedInstructor] ([UserId])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    
);


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[StudentLesson]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[StudentLesson]', N'U') IS NULL
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE  [LearningLanternServices].[dbo].[StudentLesson](
  [StudentId] INT NOT NULL PRIMARY KEY,
  [TextLessonId] INT NOT NULL PRIMARY KEY,
  CONSTRAINT [fk_Student_Lesson_Confirmed_Student1]
    FOREIGN KEY ([StudentId])
    REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent] ([UserId])
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT [fk_Student_Lesson_Text_Lesson1]
    FOREIGN KEY ([TextLessonId])
    REFERENCES [LearningLanternServices].[dbo].[TextLesson] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Event]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Event]', N'U') IS NULL
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE  [LearningLanternServices].[dbo].[Event](
  [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL,
  [Discription] NVARCHAR(250) NULL,
  [StartDate] DATETIME NOT NULL,
  [EndDate] DATETIME NOT NULL,
  [ClassroomId] INT NOT NULL,
  CONSTRAINT [fk_Events_ClassRoom1]
    FOREIGN KEY ([ClassroomId])
    REFERENCES  [LearningLanternServices].[dbo].[Classroom] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Todo]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Todo]', N'U') IS NULL
CREATE TABLE  [LearningLanternServices].[dbo].[Todo](
  [Id] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [Name] NVARCHAR(50) NOT NULL,
  
);


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Task]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Task]', N'U') IS NULL
CREATE TABLE  [LearningLanternServices].[dbo].[Task](
  [Id] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [Name] NVARCHAR(50) NOT NULL,
  [Discription] NVARCHAR(250) NULL,
  [DueDate] DATETIME NULL,
  [TodoId] INT NOT NULL,
  CONSTRAINT [fk_Task_TODO1]
    FOREIGN KEY ([TodoId])
    REFERENCES [LearningLanternServices].[dbo].[Todo] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[Message]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[Message]', N'U') IS NULL
CREATE TABLE  [LearningLanternServices].[dbo].[Message](
  [Id] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [Type] NVARCHAR(10) NOT NULL,
  [Body] NVARCHAR(250) NOT NULL,
  [Replay] INT NULL DEFAULT NULL,
  [Date] DATETIME NOT NULL,
  [UserId] INT NOT NULL,
  [ClassroomId] INT NOT NULL,
  CONSTRAINT [fk_Messages_User1]
    FOREIGN KEY ([UserId])
    REFERENCES [LearningLanternServices].[dbo].[User] ([Id])
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT [fk_Messages_ClassRoom1]
    FOREIGN KEY ([ClassroomId])
    REFERENCES [LearningLanternServices].[dbo].[Classroom] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table [LearningLanternServices].[dbo].[TodoStudent]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternServices].[dbo].[TodoStudent]', N'U') IS NULL
CREATE TABLE  [LearningLanternServices].[dbo].[TodoStudent](
  [TodoId] INT NOT NULL PRIMARY KEY,
  [StudentId] INT NOT NULL PRIMARY KEY,
  CONSTRAINT [fk_TODO_has_Confirmed_Student_TODO1]
    FOREIGN KEY ([TodoId])
    REFERENCES [LearningLanternServices].[dbo].[Todo] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT [fk_TODO_has_Confirmed_Student_Confirmed_Student1]
    FOREIGN KEY ([StudentId])
    REFERENCES [LearningLanternServices].[dbo].[ConfirmedStudent] ([UserId])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;