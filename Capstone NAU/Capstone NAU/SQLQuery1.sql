CREATE TABLE [Group] (
    GroupID varchar(100) NOT NULL,
    Description nvarchar(max) NOT NULL,
    CONSTRAINT PK_Group PRIMARY KEY (GroupID)
);
GO

CREATE TABLE [Category] (
    CategoryID varchar(100) NOT NULL,
    Description nvarchar(max) NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (CategoryID)
);
GO

CREATE TABLE Survey (
    SurveyID int NOT NULL IDENTITY,
    Description nvarchar(max) NOT NULL,
	creationDate DATE NOT NULL,
    CONSTRAINT PK_Survey PRIMARY KEY (SurveyID)
);
GO

CREATE TABLE Question (
    QuestionID int NOT NULL IDENTITY,
    GroupID varchar(100) NOT NULL,
	CategoryID varchar(100) NOT NULL,
	[Type] nvarchar(10) NOT NULL CHECK ([Type] IN('numeric', 'text')),
	Text nvarchar(max) NOT NULL,
    CONSTRAINT PK_Question PRIMARY KEY (QuestionID),
	CONSTRAINT FK_Question_Group_GroupID FOREIGN KEY (GroupID) REFERENCES [Group] (GroupID) ON DELETE CASCADE,
	CONSTRAINT FK_Question_Category_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID) ON DELETE CASCADE
);
GO

CREATE TABLE Participant (
    ParticipantID int NOT NULL IDENTITY,
    GroupID varchar(100) NOT NULL,
	SurveyID int NOT NULL,
	Username nvarchar(50) NOT NULL,
    CONSTRAINT PK_Participant PRIMARY KEY (ParticipantID),
	CONSTRAINT FK_Participant_Group_GroupID FOREIGN KEY (GroupID) REFERENCES [Group] (GroupID) ON DELETE CASCADE,
	CONSTRAINT FK_Participant_Survey_SurveyID FOREIGN KEY (SurveyID) REFERENCES Survey (SurveyID) ON DELETE CASCADE
);
GO

CREATE TABLE SurveyResponse (
    ResponseID int NOT NULL IDENTITY,
    QuestionID int NOT NULL,
	SurveyID int NOT NULL,
	ParticipantID int NOT NULL, 
	Score int NOT NULL,
	Comment nvarchar(max),
    CONSTRAINT PK_SurveyResponse PRIMARY KEY (ResponseID),
	CONSTRAINT FK_SurveyResponse_Question_QuestionID FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON DELETE CASCADE,
	CONSTRAINT FK_SurveyResponse_Survey_SurveyID FOREIGN KEY (SurveyID) REFERENCES Survey (SurveyID) ON DELETE CASCADE,
	CONSTRAINT FK_SurveyResponse_Participant_ParticipantID FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID)
);
GO

CREATE TABLE SurveyQuestion (
	SurveyID int NOT NULL,
	QuestionID int NOT NULL,
	CONSTRAINT FK_SurveyQuestion_Survey_SurveyID FOREIGN KEY (SurveyID) REFERENCES Survey (SurveyID) ON DELETE CASCADE,
	CONSTRAINT FK_SurveyQuestion_Question_QuestionID FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON DELETE CASCADE
);
GO
ALTER TABLE SurveyQuestion ADD CONSTRAINT PK_SurveyQuestion PRIMARY KEY (ID);

CREATE TABLE [Admin] (
	username varchar(50) NOT NULL,
	password varchar(50) NOT NULL,
	CONSTRAINT PK_Admin PRIMARY KEY (username)
);
GO


ALTER TABLE Category
ADD CategoryID varchar(100) NOT NULL;


ALTER TABLE Participant DROP CONSTRAINT FK_Participant_Group_GroupID;



ALTER TABLE [Group] ADD CONSTRAINT PK_Group PRIMARY KEY (GroupID);
ALTER TABLE Category ADD CONSTRAINT PK_Category PRIMARY KEY (CategoryID);
ALTER TABLE Question ALTER COLUMN GroupID varchar(100);
ALTER TABLE Question ADD CONSTRAINT FK_Question_Group_GroupID FOREIGN KEY (GroupID) REFERENCES [Group] (GroupID) ON DELETE CASCADE;
ALTER TABLE Question ALTER COLUMN CategoryID varchar(100);
ALTER TABLE Question ADD CONSTRAINT FK_Question_Category_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID) ON DELETE CASCADE;
ALTER TABLE Participant ALTER COLUMN GroupID varchar(100);
ALTER TABLE Participant ADD CONSTRAINT FK_Participant_Group_GroupID FOREIGN KEY (GroupID) REFERENCES [Group] (GroupID) ON DELETE CASCADE;
