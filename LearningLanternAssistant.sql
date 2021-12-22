
-- -----------------------------------------------------
-- Database [LearningLanternAssistant]
-- -----------------------------------------------------
IF DB_ID(N'[LearningLanternAssistant]') IS NULL
    CREATE DATABASE [LearningLanternAssistant];

USE [LearningLanternAssistant];

-- -----------------------------------------------------
-- Table [LearningLanternAssistant].[dbo].[TranslateRequest]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternAssistant].[dbo].[TranslateRequest]', N'U') IS NULL
    CREATE TABLE [LearningLanternAssistant].[dbo].[TranslateRequest]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Word] NVARCHAR(50) NOT NULL,
        [Count] INT NULL DEFAULT 1
    );


-- -----------------------------------------------------
-- Table [LearningLanternAssistant].[dbo].[Synonym]
-- -----------------------------------------------------
IF OBJECT_ID(N'[LearningLanternAssistant].[dbo].[Synonym]', N'U') IS NULL
    CREATE TABLE [LearningLanternAssistant].[dbo].[Synonym]
    (
        [Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
        [Count] INT NULL DEFAULT 1,
        [Meaning] NVARCHAR(250) NOT NULL,
        [RequestId] INT NOT NULL,
        CONSTRAINT [FK_Synonym_TranslateRequest]
            FOREIGN KEY ([RequestId])
            REFERENCES [LearningLanternAssistant].[dbo].[TranslateRequest] ([Id])
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );
