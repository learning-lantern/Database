
-- -----------------------------------------------------
-- Database [LearningLantern]
-- -----------------------------------------------------
IF DB_ID(N'[LearningLantern]') IS NULL
    CREATE DATABASE [LearningLantern];

USE [LearningLantern];


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[User]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[User]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[User]
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
-- Table [LearningLantern].[dbo].[ConfirmedStudent]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[ConfirmedStudent]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[ConfirmedStudent]
    (
        [UserId] INT NOT NULL PRIMARY KEY,
        [ConfirmationCode] VARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedStudent_User]
            FOREIGN KEY([UserId])
            REFERENCES [LearningLantern].[dbo].[User] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[ConfirmedInstructor]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[ConfirmedInstructor]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[ConfirmedInstructor]
    (
        [UserId] INT NOT NULL PRIMARY KEY,
        [ConfirmationCode] VARCHAR(10) NOT NULL UNIQUE,
        [ConfirmationDate] DATETIME NOT NULL,
        CONSTRAINT [FK_ConfirmedInstructor_User]
            FOREIGN KEY([UserId])
            REFERENCES [LearningLantern].[dbo].[User] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Classroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Classroom]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Classroom]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[StudentClassroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[StudentClassroom]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[StudentClassroom]
    (
        [StudentId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        PRIMARY KEY([StudentId], [ClassroomId]),
        CONSTRAINT [FK_StudentClassRoom_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentClassRoom_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[InstructorClassroom]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[InstructorClassroom]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[InstructorClassroom]
    (
        [InstructorId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        PRIMARY KEY([InstructorId], [ClassroomId]),
        CONSTRAINT [FK_InstructorClassRoom_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_InstructorClassRoom_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Lecture]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Lecture]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Lecture]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [StartDate] DATETIME NOT NULL,
        [EndDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_Lecture_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Lecture_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[TextLesson]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[TextLesson]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[TextLesson]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [Printable] BIT NOT NULL DEFAULT 0,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_TextLesson_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TextLesson_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Video]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Video]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Video]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_Video_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Video_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Quiz]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Quiz]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Quiz]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1) ,
        [Score] DECIMAL(3,2) NOT NULL,
        [Time] DATETIME NOT NULL,
        [IsAttendance] BIT NOT NULL,
        [Answer] NVARCHAR(10) NOT NULL,
        [ClassroomId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        CONSTRAINT [FK_Quiz_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Quiz_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Exam]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Exam]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Exam]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Score] DECIMAL(3,2) NOT NULL,
        [Time] DATETIME NOT NULL,
        [StartDate] DATETIME NOT NULL,
        [Shuffle] BIT NOT NULL,
        [ShowScore] BIT NOT NULL,
        [InstructorId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Exam_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT [FK_Exam_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[ExamQuizes]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[ExamQuizes]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[ExamQuizes]
    (
        [ExamId] INT NOT NULL,
        [QuizId] INT NOT NULL,
        PRIMARY KEY([ExamId], [QuizId]),
        CONSTRAINT [FK_ExamQuizes_Exam]
            FOREIGN KEY([ExamId])
            REFERENCES [LearningLantern].[dbo].[Exam] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_ExamQuizes_Quiz]
            FOREIGN KEY([QuizId])
            REFERENCES [LearningLantern].[dbo].[Quiz] ([Id])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[StudentQuiz]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[StudentQuiz]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[StudentQuiz]
    (
        [QuizId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        [StudentAnswer] NVARCHAR(500) NOT NULL,
        [Score] DECIMAL(3,2) NOT NULL,
        PRIMARY KEY([QuizId], [StudentId]),
        CONSTRAINT [FK_StudentQuiz_Quiz]
            FOREIGN KEY([QuizId])
            REFERENCES [LearningLantern].[dbo].[Quiz] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentQuiz_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[StudentExam]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[StudentExam]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[StudentExam]
    (
        [StudentId] INT NOT NULL,
        [ExamId] INT NOT NULL,
        PRIMARY KEY([StudentId], [ExamId]),
        CONSTRAINT [FK_StudentExam_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentExam_Exam]
            FOREIGN KEY([ExamId])
            REFERENCES [LearningLantern].[dbo].[Exam] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Project]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Project]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Project]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [Score] DECIMAL(3,2) NOT NULL,
        [MaxNumber] INT NOT NULL,
        [DueDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Project_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[InstructorProject]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[InstructorProject]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[InstructorProject]
    (
        [ProjectId] INT NOT NULL,
        [InstructorId] INT NOT NULL,
        PRIMARY KEY([ProjectId], [InstructorId]),
        CONSTRAINT [FK_InstructorProject_Project]
            FOREIGN KEY([ProjectId])
            REFERENCES [LearningLantern].[dbo].[Project] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_InstructorProject_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Attendance]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Attendance]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Attendance]
    (
        [QuizId] INT NOT NULL,
        [LectureId] INT NOT NULL,
        PRIMARY KEY([QuizId], [LectureId]),
        CONSTRAINT [FK_Attendance_Quiz]
            FOREIGN KEY([QuizId])
            REFERENCES [LearningLantern].[dbo].[Quiz]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Attendance_Lecture]
            FOREIGN KEY([LectureId])
            REFERENCES [LearningLantern].[dbo].[Lecture]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Team]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Team]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Team]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Score] DECIMAL(3,2) NULL,
        [ProjectId] INT NOT NULL,
        CONSTRAINT [FK_Team_Project]
            FOREIGN KEY([ProjectId])
            REFERENCES [LearningLantern].[dbo].[Project]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[StudentTeam]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[StudentTeam]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[StudentTeam]
    (
        [TeamId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        PRIMARY KEY([TeamId], [StudentId]),
        CONSTRAINT [FK_StudentTeam_Team]
            FOREIGN KEY([TeamId])
            REFERENCES [LearningLantern].[dbo].[Team]([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentTeam_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent]([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[TimeStamp]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[TimeStamp]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[TimeStamp] 
    (
        [VideoId] INT NOT NULL,
        [Time] INT NOT NULL,
        [QuizId] INT NOT NULL,
        PRIMARY KEY([VideoId], [Time]),
        CONSTRAINT [FK_TimeStamp_Video]
            FOREIGN KEY([VideoId])
            REFERENCES [LearningLantern].[dbo].[Video] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TimeStamp_Quiz]
            FOREIGN KEY([QuizId])
            REFERENCES [LearningLantern].[dbo].[Quiz] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[BackUpInstructor]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[BackUpInstructor]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[BackUpInstructor]
    (
        [InstructorId] INT NOT NULL PRIMARY KEY,
        [InstructorFirstName] NVARCHAR(50) NOT NULL,
        [InstructorLastName] NVARCHAR(50) NOT NULL,
        CONSTRAINT [FK_BackUpInstructor_ConfirmedInstructor]
            FOREIGN KEY([InstructorId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedInstructor] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[StudentLesson]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[StudentLesson]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[StudentLesson]
    (
        [StudentId] INT NOT NULL,
        [TextLessonId] INT NOT NULL,
        PRIMARY KEY([StudentId], [TextLessonId]),
        CONSTRAINT [FK_StudentLesson_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_StudentLesson_TextLesson]
            FOREIGN KEY([TextLessonId])
            REFERENCES [LearningLantern].[dbo].[TextLesson] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Event]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Event]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[Event]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [StartDate] DATETIME NOT NULL,
        [EndDate] DATETIME NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Event_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES  [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Todo]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Todo]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[Todo]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[Task]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Task]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[Task]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Name] NVARCHAR(50) NOT NULL,
        [Discription] NVARCHAR(250) NULL,
        [DueDate] DATETIME NULL,
        [TodoId] INT NOT NULL,
        CONSTRAINT [FK_Task_Todo]
            FOREIGN KEY([TodoId])
            REFERENCES [LearningLantern].[dbo].[Todo] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- -------------------------------------------------------
-- Table [LearningLantern].[dbo].[Message]
-- -------------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Message]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[Message]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Type] VARCHAR(10) NOT NULL,
        [Body] VARCHAR(250) NOT NULL,
        [Replay] INT NULL DEFAULT NULL,
        [Date] DATETIME NOT NULL,
        [UserId] INT NOT NULL,
        [ClassroomId] INT NOT NULL,
        CONSTRAINT [FK_Message_User]
            FOREIGN KEY([UserId])
            REFERENCES [LearningLantern].[dbo].[User] ([Id])
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
        CONSTRAINT [FK_Message_ClassRoom]
            FOREIGN KEY([ClassroomId])
            REFERENCES [LearningLantern].[dbo].[Classroom] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );


-- --------------------------------------------------------
-- Table [LearningLantern].[dbo].[TodoStudent]
-- --------------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[TodoStudent]', N'U') IS NULL
    CREATE TABLE  [LearningLantern].[dbo].[TodoStudent]
    (
        [TodoId] INT NOT NULL,
        [StudentId] INT NOT NULL,
        PRIMARY KEY([TodoId], [StudentId]),
        CONSTRAINT [FK_TodoStudent_Todo]
            FOREIGN KEY([TodoId])
            REFERENCES [LearningLantern].[dbo].[Todo] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        CONSTRAINT [FK_TodoStudent_ConfirmedStudent]
            FOREIGN KEY([StudentId])
            REFERENCES [LearningLantern].[dbo].[ConfirmedStudent] ([UserId])
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table [LearningLantern].[dbo].[TranslateRequest]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[TranslateRequest]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[TranslateRequest]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Word] NVARCHAR(50) NOT NULL,
        [Count] INT NOT NULL DEFAULT 1
    );


-- ------------------------------------------------------
-- Table [LearningLantern].[dbo].[Synonym]
-- ------------------------------------------------------
IF OBJECT_ID(N'[LearningLantern].[dbo].[Synonym]', N'U') IS NULL
    CREATE TABLE [LearningLantern].[dbo].[Synonym]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Count] INT NOT NULL DEFAULT 1,
        [Meaning] NVARCHAR(250) NOT NULL,
        [RequestId] INT NOT NULL,
        CONSTRAINT [FK_Synonym_TranslateRequest]
            FOREIGN KEY ([RequestId])
            REFERENCES [LearningLantern].[dbo].[TranslateRequest] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );
    
    
