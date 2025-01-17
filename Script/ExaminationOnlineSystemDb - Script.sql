USE [ExaminationOnlineSystemDb]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[questionId] [int] IDENTITY(1,1) NOT NULL,
	[question] [nvarchar](255) NULL,
	[questionModelAnswer] [nvarchar](20) NOT NULL,
	[questionGrade] [int] NOT NULL,
	[questionType] [nvarchar](30) NOT NULL,
	[courseIdFK] [int] NOT NULL,
 CONSTRAINT [PK__Question__6238D4B2C33A2716] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[questionChoices]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questionChoices](
	[questionId] [int] NOT NULL,
	[questionChoice] [nvarchar](30) NOT NULL,
	[choiceContent] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_questionChoices] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC,
	[questionChoice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[examQuestions]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[examQuestions](
	[examIdFK] [int] NOT NULL,
	[questionIdFK] [int] NOT NULL,
 CONSTRAINT [pk_exam_qs] PRIMARY KEY CLUSTERED 
(
	[examIdFK] ASC,
	[questionIdFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Exam_question]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Exam_question]
AS
SELECT        dbo.examQuestions.examIdFK, dbo.examQuestions.questionIdFK AS questionIdFFK, dbo.Question.question, dbo.Question.questionType, dbo.questionChoices.questionChoice, dbo.questionChoices.choiceContent
FROM            dbo.examQuestions INNER JOIN
                         dbo.Question ON dbo.examQuestions.questionIdFK = dbo.Question.questionId INNER JOIN
                         dbo.questionChoices ON dbo.Question.questionId = dbo.questionChoices.questionId

GO
/****** Object:  Table [dbo].[ansewrsOfTheQuestion]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ansewrsOfTheQuestion](
	[questionIdFK] [int] NOT NULL,
	[studentIdFK] [int] NOT NULL,
	[examIdFK] [int] NOT NULL,
	[questionAnswer] [nvarchar](50) NOT NULL,
	[gradeOfTheAnswer] [int] NOT NULL,
 CONSTRAINT [pk_qs_answer] PRIMARY KEY CLUSTERED 
(
	[questionIdFK] ASC,
	[studentIdFK] ASC,
	[examIdFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exam]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[examId] [int] IDENTITY(1,1) NOT NULL,
	[examTime] [time](7) NULL,
	[totalExamGrade] [int] NULL,
	[courseIdFK] [int] NOT NULL,
 CONSTRAINT [PK__Exam__A56D125F57A03E7E] PRIMARY KEY CLUSTERED 
(
	[examId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Exam_question_And_ANSWERS]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Exam_question_And_ANSWERS]
AS
SELECT        dbo.ansewrsOfTheQuestion.studentIdFK AS studentId, dbo.Exam.examId, dbo.ansewrsOfTheQuestion.questionIdFK AS questionId, dbo.Question.question, dbo.questionChoices.questionChoice, 
                         dbo.questionChoices.choiceContent, dbo.ansewrsOfTheQuestion.questionAnswer
FROM            dbo.ansewrsOfTheQuestion INNER JOIN
                         dbo.Exam ON dbo.Exam.examId = dbo.ansewrsOfTheQuestion.examIdFK INNER JOIN
                         dbo.Question ON dbo.ansewrsOfTheQuestion.questionIdFK = dbo.Question.questionId INNER JOIN
                         dbo.questionChoices ON dbo.Question.questionId = dbo.questionChoices.questionId

GO
/****** Object:  Table [dbo].[Course]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[courseId] [int] IDENTITY(100,10) NOT NULL,
	[courseName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[courseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[deptId] [int] IDENTITY(10,10) NOT NULL,
	[deptName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[deptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[instId] [int] IDENTITY(1000,1) NOT NULL,
	[instFName] [nvarchar](30) NOT NULL,
	[instLName] [nvarchar](30) NOT NULL,
	[instAddress] [nvarchar](30) NULL,
	[instSalary] [float] NULL,
	[supervisorId] [int] NULL,
	[deptIdFK] [int] NOT NULL,
	[workingHours] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[instId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[instructorTeachesCourse]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instructorTeachesCourse](
	[courseIdFK] [int] NOT NULL,
	[instIdFK] [int] NOT NULL,
 CONSTRAINT [pk_course_instructor] PRIMARY KEY CLUSTERED 
(
	[courseIdFK] ASC,
	[instIdFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[studentId] [int] IDENTITY(1,1) NOT NULL,
	[studentFName] [nvarchar](30) NOT NULL,
	[studentLName] [nvarchar](30) NOT NULL,
	[studentAddress] [nvarchar](30) NULL,
	[deptIdFK] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[studentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[studentEnrollsInCourse]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentEnrollsInCourse](
	[studentIdFK] [int] NOT NULL,
	[courseIdFK] [int] NOT NULL,
	[grade] [float] NULL,
 CONSTRAINT [pk_student_course] PRIMARY KEY CLUSTERED 
(
	[studentIdFK] ASC,
	[courseIdFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topic]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[topicId] [int] IDENTITY(1,1) NOT NULL,
	[topicName] [nvarchar](30) NOT NULL,
	[courseIdFK] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[topicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (2, 1, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (2, 2, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (3, 1, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (3, 2, 1, N'B', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (6, 1, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (6, 2, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (10, 1, 1, N'A', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (10, 2, 1, N'B', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (12, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (12, 2, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (13, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (13, 2, 1, N'B', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (15, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (15, 2, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (16, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (16, 2, 1, N'B', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (19, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (19, 2, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (20, 1, 1, N'A', 1)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (20, 2, 1, N'B', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (21, 3, 3, N'a', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (23, 3, 3, N'b', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (24, 3, 3, N'a', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (25, 3, 3, N'b', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (26, 3, 3, N'a', 2)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (28, 3, 3, N't', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (29, 3, 3, N't', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (31, 3, 3, N'f', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (33, 3, 3, N'f', 0)
INSERT [dbo].[ansewrsOfTheQuestion] ([questionIdFK], [studentIdFK], [examIdFK], [questionAnswer], [gradeOfTheAnswer]) VALUES (37, 3, 3, N't', 0)
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([courseId], [courseName]) VALUES (100, N'C#')
INSERT [dbo].[Course] ([courseId], [courseName]) VALUES (110, N'Database Fundmentals')
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([deptId], [deptName]) VALUES (40, N'3D Art')
INSERT [dbo].[Department] ([deptId], [deptName]) VALUES (20, N'Game')
INSERT [dbo].[Department] ([deptId], [deptName]) VALUES (30, N'Java')
INSERT [dbo].[Department] ([deptId], [deptName]) VALUES (10, N'SD')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([examId], [examTime], [totalExamGrade], [courseIdFK]) VALUES (1, CAST(N'00:45:00' AS Time), 14, 100)
INSERT [dbo].[Exam] ([examId], [examTime], [totalExamGrade], [courseIdFK]) VALUES (2, CAST(N'00:45:00' AS Time), 15, 100)
INSERT [dbo].[Exam] ([examId], [examTime], [totalExamGrade], [courseIdFK]) VALUES (3, CAST(N'00:45:00' AS Time), 17, 110)
SET IDENTITY_INSERT [dbo].[Exam] OFF
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 2)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 3)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 6)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 10)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 12)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 13)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 15)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 16)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 19)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (1, 20)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 1)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 3)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 6)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 7)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 10)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 12)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 13)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 15)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 16)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (2, 20)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 21)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 23)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 24)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 25)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 26)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 28)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 29)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 31)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 33)
INSERT [dbo].[examQuestions] ([examIdFK], [questionIdFK]) VALUES (3, 37)
SET IDENTITY_INSERT [dbo].[Instructor] ON 

INSERT [dbo].[Instructor] ([instId], [instFName], [instLName], [instAddress], [instSalary], [supervisorId], [deptIdFK], [workingHours]) VALUES (1000, N'Hani', N'Safwat', N'Nasr City', 30000, NULL, 10, 4)
INSERT [dbo].[Instructor] ([instId], [instFName], [instLName], [instAddress], [instSalary], [supervisorId], [deptIdFK], [workingHours]) VALUES (1001, N'Rami', N'Muhammad', N'Heliopolis', 20000, 1000, 20, 6)
SET IDENTITY_INSERT [dbo].[Instructor] OFF
INSERT [dbo].[instructorTeachesCourse] ([courseIdFK], [instIdFK]) VALUES (100, 1000)
INSERT [dbo].[instructorTeachesCourse] ([courseIdFK], [instIdFK]) VALUES (110, 1001)
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (1, N'Which of the following converts a type to a single Unicode character, where possible in C#?', N'C', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (2, N'Which of the following converts a type to a 16-bit integer in C#?', N'C', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (3, N'Which of the following operator returns the address of an variable in C#?', N'C', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (4, N'Which of the following access specifier in C# allows a class to expose its member variables and member functions to other functions and objects in the current assembly?', N'D', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (5, N'Which of the following preprocessor directive allows to create a compound conditional directive, along with #if in C#?', N'E', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (6, N'Boxing in .Net allows the user to convert
', N'C', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (7, N'What does the keyword virtual mean in the method definition?', N'D', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (8, N'The RangeValidator control supports the following data types', N'B', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (9, N'allow to encapsulate discrete units of functionality and provide a graphical representation of that functionality to the user', N'A', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (10, N'Feature of a local variable', N'C', 2, N'MCQ', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (11, N'A function can return more than one value.', N'B', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (12, N'In C#, a function needs to be defined using the static keyword, so that it can be called from the Main function.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (13, N'If a function returns no value, the return type must be declared as void.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (14, N'In a function, The return statement is not required if the return type is anything other than void.', N'B', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (15, N'A local variable declared in a function is not usable out side that function.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (16, N'A function can have more than one parameter. Values of the parameters are passed to the function when it is called.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (17, N'
The space required for structure variables is allocated on stack.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (18, N'In C#, A function can be overloaded. Overloading a function means you can give the same name to many function, but different in their arguments.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (19, N'All code inside finally block is guaranteed to execute irrespective of whether an exception occurs in the protected block or not.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (20, N'In a HashTable Key cannot be null, but Value can be.', N'A', 1, N'TF', 100)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (21, N'
Some advantages of the database approach include all, but:', N'D', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (22, N'Which of the following SQL statements are helpful in database redesign?', N'C', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (23, N'
Views constructed from SQL SELECT statements that conform to the SQL-92 standard may not contain:', N'C', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (24, N'
Entities of a given type are grouped into a(n):', N'B', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (25, N'One solution to the multivalued dependency constraint problem is to:', N'A', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (26, N'
A view is which of the following?', N'A', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (27, N'The SQL statement that queries or reads data from a table is ________ .', N'A', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (28, N'Which type of SQL Server cursor concurrency places an update lock on a row when the row is read?', N'D', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (29, N'Which of the following is not true about indexes?', N'D', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (30, N'A relation in this form is free of all modification anomalies.', N'D', 2, N'MCQ', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (31, N'Mirrored databases are almost always provided in high-availability systems.', N'A', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (32, N'The SQL MAKE TABLE command is used to construct tables, define columns, define column constraints and create relationships.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (33, N'The most important reason for data architecture is reliability.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (34, N'	
The most frequently used relational operation, which brings together data from two or more related tables into one resultant table, is called an equi-join.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (35, N'We use the SQL construct COUNT(*) to count the number of rows in a table.', N'A', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (36, N'	
Proper normalization eliminates duplicated data.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (37, N'	
Cardinality specifies the number of instances of one entity that can be associated with each instance of another entity.', N'A', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (38, N'Relationships cannot have attributes.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (39, N'Cascading updates refers to child rows being automatically deleted when a parent row is deleted.', N'B', 1, N'TF', 110)
INSERT [dbo].[Question] ([questionId], [question], [questionModelAnswer], [questionGrade], [questionType], [courseIdFK]) VALUES (40, N'	
A transaction is the complete set of closely related update commands that must all be done, or none of them done, for the database to remain valid.', N'A', 1, N'TF', 110)
SET IDENTITY_INSERT [dbo].[Question] OFF
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (1, N'A', N'ToSingle')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (1, N'B', N'ToByte')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (1, N'C', N'ToChar')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (1, N'D', N'ToDateTime')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (2, N'A', N'ToDecimal')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (2, N'B', N'ToDouble')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (2, N'C', N'ToInt16')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (2, N'D', N'ToInt32')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (3, N'A', N'sizeof')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (3, N'B', N'typeof')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (3, N'C', N'&')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (3, N'D', N'*')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (4, N'A', N'Public')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (4, N'B', N'Private')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (4, N'C', N'Protected')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (4, N'D', N'Internal')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (5, N'A', N'define')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (5, N'B', N'elif')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (5, N'C', N'if')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (5, N'D', N'else')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (6, N'A', N'a interger type to double')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (6, N'B', N'a reference type to a value type')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (6, N'C', N'a value type to a reference type')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (6, N'D', N'a double type to interger')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (7, N'A', N'The method is public')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (7, N'B', N'The method can be derived')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (7, N'C', N'The method is static')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (7, N'D', N'The method can be over-ridden')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (8, N'A', N'Integer only')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (8, N'B', N'Date, Integer and String')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (8, N'C', N'Only String')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (8, N'D', N'Date and Integer
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (9, N'A', N'Controls')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (9, N'B', N'Object')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (9, N'C', N'Class')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (9, N'D', N'Graphics')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (10, N'A', N'It can be used anywhere in the program')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (10, N'B', N'It must accept a class')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (10, N'C', N'It must be declared within a method')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (10, N'D', N'It represent a class object')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (11, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (11, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (12, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (12, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (13, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (13, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (14, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (14, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (15, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (15, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (16, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (16, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (17, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (17, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (18, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (18, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (19, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (19, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (20, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (20, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (21, N'A', N'minimal data redundancy.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (21, N'B', N'improved data consistency.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (21, N'C', N'improved data sharing.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (21, N'D', N'program-data dependency.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (22, N'A', N'Correlated subqueries only
.')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (22, N'B', N'EXISTS/NOT EXISTS expressions only
.')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (22, N'C', N'Both of the above are helpful
.')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (22, N'D', N'None of the above are helpful.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (23, N'A', N'
GROUP BY.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (23, N'B', N'WHERE.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (23, N'C', N'ORDER BY.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (23, N'D', N'
FROM.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (24, N'A', N'database.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (24, N'B', N'entity class.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (24, N'C', N'attribute.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (24, N'D', N'ERD.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (25, N'A', N'split the relation into two relations, each with a single theme.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (25, N'B', N'change the theme.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (25, N'C', N'create a new theme.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (25, N'D', N'add a composite key.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (26, N'A', N'A virtual table that can be accessed via SQL commands
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (26, N'B', N'A virtual table that cannot be accessed via SQL commands
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (26, N'C', N'A base table that can be accessed via SQL commands
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (26, N'D', N'A base table that cannot be accessed via SQL commands
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (27, N'A', N'SELECT')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (27, N'B', N'READ')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (27, N'C', N'QUERY
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (27, N'D', N'None of the above is correct.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (28, N'A', N'READ_ONLY
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (28, N'B', N'SCROLL_LOCK
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (28, N'C', N'OPTIMISTIC')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (28, N'D', N'READCOMMITTED')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (29, N'A', N'Indexes are created to enforce uniqueness on columns.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (29, N'B', N'Indexes are created to enable fast retrieval by column values.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (29, N'C', N'Columns that are frequently used with equal conditions in WHERE clauses are good candidates for indexes.')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (29, N'D', N'	
Indexes are created with the ALTER TABLE command.
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (30, N'A', N'
First normal form
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (30, N'B', N'Second normal form
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (30, N'C', N'Third normal form
')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (30, N'D', N'Domain/key normal form
')
GO
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (31, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (31, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (32, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (32, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (33, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (33, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (34, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (34, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (35, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (35, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (36, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (36, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (37, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (37, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (38, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (38, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (39, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (39, N'B', N'False')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (40, N'A', N'True')
INSERT [dbo].[questionChoices] ([questionId], [questionChoice], [choiceContent]) VALUES (40, N'B', N'False')
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([studentId], [studentFName], [studentLName], [studentAddress], [deptIdFK]) VALUES (1, N'Muhammad', N'Adel', N'Maadi', 10)
INSERT [dbo].[Student] ([studentId], [studentFName], [studentLName], [studentAddress], [deptIdFK]) VALUES (2, N'Neven', N'Hossam', N'Ain Shams', 10)
INSERT [dbo].[Student] ([studentId], [studentFName], [studentLName], [studentAddress], [deptIdFK]) VALUES (3, N'Aya', N'Muhammad', N'Nasr City', 20)
INSERT [dbo].[Student] ([studentId], [studentFName], [studentLName], [studentAddress], [deptIdFK]) VALUES (4, N'Abdelrahman', N'Nawar', N'October', 10)
INSERT [dbo].[Student] ([studentId], [studentFName], [studentLName], [studentAddress], [deptIdFK]) VALUES (5, N'Marina', N'George', N'Abasia', 20)
SET IDENTITY_INSERT [dbo].[Student] OFF
INSERT [dbo].[studentEnrollsInCourse] ([studentIdFK], [courseIdFK], [grade]) VALUES (1, 100, 42)
INSERT [dbo].[studentEnrollsInCourse] ([studentIdFK], [courseIdFK], [grade]) VALUES (2, 100, 21)
INSERT [dbo].[studentEnrollsInCourse] ([studentIdFK], [courseIdFK], [grade]) VALUES (3, 110, NULL)
INSERT [dbo].[studentEnrollsInCourse] ([studentIdFK], [courseIdFK], [grade]) VALUES (4, 110, NULL)
INSERT [dbo].[studentEnrollsInCourse] ([studentIdFK], [courseIdFK], [grade]) VALUES (5, 100, NULL)
SET IDENTITY_INSERT [dbo].[Topic] ON 

INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (1, N'C# Basics', 100)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (2, N'Creating Types in C#', 100)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (3, N'Advanced C#', 100)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (4, N'Framework Overview', 100)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (5, N'SQL Basics', 110)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (6, N'ERD', 110)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (7, N'Mapping', 110)
INSERT [dbo].[Topic] ([topicId], [topicName], [courseIdFK]) VALUES (8, N'Normalization', 110)
SET IDENTITY_INSERT [dbo].[Topic] OFF
/****** Object:  Index [IndexOf_CourseName]    Script Date: 1/23/2020 2:15:31 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IndexOf_CourseName] ON [dbo].[Course]
(
	[courseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Departme__923D729D6273483C]    Script Date: 1/23/2020 2:15:31 PM ******/
ALTER TABLE [dbo].[Department] ADD UNIQUE NONCLUSTERED 
(
	[deptName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Exam] ADD  CONSTRAINT [DF__Exam__examTime__398D8EEE]  DEFAULT ('0:45:0') FOR [examTime]
GO
ALTER TABLE [dbo].[Instructor] ADD  DEFAULT ('Cairo') FOR [instAddress]
GO
ALTER TABLE [dbo].[Instructor] ADD  DEFAULT ((2000)) FOR [instSalary]
GO
ALTER TABLE [dbo].[Student] ADD  DEFAULT ('Cairo') FOR [studentAddress]
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion]  WITH CHECK ADD  CONSTRAINT [FK__ansewrsOf__examI__3D5E1FD2] FOREIGN KEY([examIdFK])
REFERENCES [dbo].[Exam] ([examId])
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion] CHECK CONSTRAINT [FK__ansewrsOf__examI__3D5E1FD2]
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion]  WITH CHECK ADD  CONSTRAINT [FK__ansewrsOf__quest__3E52440B] FOREIGN KEY([questionIdFK])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion] CHECK CONSTRAINT [FK__ansewrsOf__quest__3E52440B]
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion]  WITH CHECK ADD FOREIGN KEY([studentIdFK])
REFERENCES [dbo].[Student] ([studentId])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [courseIdFK] FOREIGN KEY([courseIdFK])
REFERENCES [dbo].[Course] ([courseId])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [courseIdFK]
GO
ALTER TABLE [dbo].[examQuestions]  WITH CHECK ADD  CONSTRAINT [FK__examQuest__examI__412EB0B6] FOREIGN KEY([examIdFK])
REFERENCES [dbo].[Exam] ([examId])
GO
ALTER TABLE [dbo].[examQuestions] CHECK CONSTRAINT [FK__examQuest__examI__412EB0B6]
GO
ALTER TABLE [dbo].[examQuestions]  WITH CHECK ADD  CONSTRAINT [FK__examQuest__quest__4222D4EF] FOREIGN KEY([questionIdFK])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[examQuestions] CHECK CONSTRAINT [FK__examQuest__quest__4222D4EF]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD FOREIGN KEY([deptIdFK])
REFERENCES [dbo].[Department] ([deptId])
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD FOREIGN KEY([supervisorId])
REFERENCES [dbo].[Instructor] ([instId])
GO
ALTER TABLE [dbo].[instructorTeachesCourse]  WITH CHECK ADD FOREIGN KEY([courseIdFK])
REFERENCES [dbo].[Course] ([courseId])
GO
ALTER TABLE [dbo].[instructorTeachesCourse]  WITH CHECK ADD FOREIGN KEY([instIdFK])
REFERENCES [dbo].[Instructor] ([instId])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK__Question__course__46E78A0C] FOREIGN KEY([courseIdFK])
REFERENCES [dbo].[Course] ([courseId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK__Question__course__46E78A0C]
GO
ALTER TABLE [dbo].[questionChoices]  WITH CHECK ADD  CONSTRAINT [FK__questionC__quest__44FF419A] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[questionChoices] CHECK CONSTRAINT [FK__questionC__quest__44FF419A]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([deptIdFK])
REFERENCES [dbo].[Department] ([deptId])
GO
ALTER TABLE [dbo].[studentEnrollsInCourse]  WITH CHECK ADD FOREIGN KEY([courseIdFK])
REFERENCES [dbo].[Course] ([courseId])
GO
ALTER TABLE [dbo].[studentEnrollsInCourse]  WITH CHECK ADD FOREIGN KEY([studentIdFK])
REFERENCES [dbo].[Student] ([studentId])
GO
ALTER TABLE [dbo].[Topic]  WITH CHECK ADD FOREIGN KEY([courseIdFK])
REFERENCES [dbo].[Course] ([courseId])
GO
/****** Object:  StoredProcedure [dbo].[AddStudent]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddStudent] @stud_fname nvarchar (30), @stud_lname nvarchar (30)
,@studentadd nvarchar (30),@deptname nvarchar(30)
as
begin
declare @deptid int
set @deptid= (select deptId from department where deptName=@deptname)
if @deptid is null
begin
raiserror ('Sorry this department dosnt exist',16,1)
return
end
begin try
insert into student (studentFName,studentLName,studentAddress,deptIdFK) values 
(@stud_fname,@stud_lname,@studentadd,@deptid)
end try
begin catch
		RAISERROR('There is Something Wrong',16,1)
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[course_Topics]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[course_Topics] (@ID int)
as

select c.courseName , topicName from Topic t inner join Course c
on c.courseId = @ID and  t.courseIdFK = c.courseId

GO
/****** Object:  StoredProcedure [dbo].[crud_QuestionChoicesDelete]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[crud_QuestionChoicesDelete]
		@questionId [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		DELETE FROM dbo.questionChoices
		WHERE (questionId = @questionId OR @questionId IS NULL)
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[crud_QuestionDelete]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[crud_QuestionDelete]
		@questionId [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	BEGIN TRY
	
BEGIN TRANSACTION
		EXECUTE dbo.crud_QuestionChoicesDelete @questionId
		DELETE FROM dbo.Question
		WHERE (questionId = @questionId OR @questionId IS NULL)
	COMMIT
END TRY
BEGIN CATCH
	SELECT 'ERROR'
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[crud_QuestionInsert]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[crud_QuestionInsert]
	(
		@question [nvarchar](50),
		@questionModelAnswer [nvarchar](20),
		@questionGrade [int],
		@questionType [nvarchar](30),
		@courseIdFK [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	if @questionModelAnswer in (select @questionModelAnswer from questionChoices qc inner join question q on qc.questionId = q.questionId)
	begin
	INSERT INTO dbo.Question
	(
		question, questionModelAnswer, questionGrade, questionType, courseIdFK
	)
	VALUES
	(
		@question,
		@questionModelAnswer,
		@questionGrade,
		@questionType,
		@courseIdFK

	)
	SELECT questionId, question, questionModelAnswer, questionGrade, questionType, courseIdFK
	FROM dbo.Question
	WHERE (questionId = SCOPE_IDENTITY())
	COMMIT
	end
	ELSE
	SELECT 'Model Answer is not in the choices'


GO
/****** Object:  StoredProcedure [dbo].[crud_QuestionSelect]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[crud_QuestionSelect]
		@questionId [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT questionId, question, questionModelAnswer, questionGrade, questionType, courseIdFK
	FROM dbo.Question
	WHERE (questionId = @questionId OR @questionId IS NULL)

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[crud_QuestionUpdate]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[crud_QuestionUpdate]
	(
		@questionId [int],
		@question [nvarchar](50),
		@questionModelAnswer [nvarchar](20),
		@questionGrade [int],
		@questionType [nvarchar](30),
		@courseIdFK [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	if @questionModelAnswer in (select @questionModelAnswer from questionChoices qc inner join question q on qc.questionId = q.questionId)
	begin
		UPDATE dbo.Question
		SET  question = @question, questionModelAnswer = @questionModelAnswer, questionGrade = @questionGrade, questionType = @questionType, courseIdFK = @courseIdFK
		WHERE (questionId = @questionId OR @questionId IS NULL)
	COMMIT
	END
	ELSE
	SELECT 'Model Answer is not in the choices'


GO
/****** Object:  StoredProcedure [dbo].[deleteSpecificCourse]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insertNewCourse 'CST'

----------------------------

create procedure [dbo].[deleteSpecificCourse] (@courseId int)
as
	begin try
		declare @verifyId int
		select @verifyId = courseId
		from Course
		where courseId = @courseId

		if @verifyId IS NOT NULL 
		begin
			delete from Course
			where courseId = @courseId
		end

		else
			select 'This Course does not exist'
	end try
	begin catch
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[deleteSpecificDepartmentById]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------------

--4--DELETE
--(a)-- Delete Department by ID
CREATE PROCEDURE [dbo].[deleteSpecificDepartmentById](@departmentId int)
AS

BEGIN TRY
	DECLARE @verifyDeptId int
		SELECT @verifyDeptId = deptId
		FROM Department
		WHERE deptId = @departmentId

	IF @verifyDeptId IS NOT NULL
		DELETE FROM dbo.Department 
		WHERE deptId = @departmentId

	ELSE
		SELECT 'Error! This Department does not exist.'
END TRY

BEGIN CATCH
	EXEC procCatchError;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[deleteSpecificDepartmentByName]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--(a)-- Delete Department by Name

CREATE PROCEDURE [dbo].[deleteSpecificDepartmentByName](@departmentName nvarchar(30))
AS

BEGIN TRY
	DECLARE @verifyDeptName nvarchar(30)
		SELECT @verifyDeptName = deptName
		FROM Department
		WHERE deptName = @departmentName

	IF @verifyDeptName IS NOT NULL
		DELETE FROM dbo.Department 
		WHERE deptName = @departmentName

	ELSE
		SELECT 'Error! This Department does not exist.'
END TRY

BEGIN CATCH
	EXEC procCatchError;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[deleteSpecificInstructor]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--updateSpecificInstructor 1002, 'Mohamed', 'Nasser', 'Ismailia', 4000, 1001, 10, 15

----------------------------

create procedure [dbo].[deleteSpecificInstructor] (@instId int)
as
	begin try	
		declare @verifyId int
		select @verifyId = instId
		from Instructor
		where instId = @instId

		if @verifyId IS NOT NULL
		begin
			delete from Instructor
			where instId = @instId
		end

		else
			select 'This Instructor does not exist'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[deleteSpecificTopic]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--updateSpecificTopic 1, 'Arrays', 100

----------------------------

create procedure [dbo].[deleteSpecificTopic] (@topicId int)
as
	begin try	
		declare @verifyId int
		select @verifyId = topicId
		from Topic
		where topicId = @topicId

		if @verifyId IS NOT NULL
		begin
			delete from Topic
			where topicId = @topicId
		end

		else
			select 'This Topic does not exist'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[DeleteStudent]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteStudent] @studid int
as
begin 
declare @stu int
set @stu = (select studentId from Student where studentId=@studid)
if @stu is null
begin
raiserror ('sorry this student dosnt Exist to delet',16,1)
return 
end
begin try
delete from Student where studentId=@studid
end try
begin catch
raiserror ('sorry this student dosnt Exist to delet',16,1)
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Exam_Answers]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Exam_Answers] @student_id int , @exam_id int ,@answr1 nvarchar(20)
,@answr2 nvarchar(20)
,@answr3 nvarchar(20),@answr4 nvarchar(20),@answr5 nvarchar(20)
,@answr6 nvarchar(20),@answr7 nvarchar(20),@answr8 nvarchar(20),@answr9 nvarchar(20)
,@answr10 nvarchar(20)
as
begin
declare @temp_table table (question_id int,questionnum int)

insert into @temp_table
select examQuestions.questionIdFK,ROW_NUMBER() over (order by examQuestions.questionIdFK) from
examQuestions where examQuestions.examIdFK=@exam_id
----------------------------------------------------------
insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr1,
iif(@answr1=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=1
------------------------------------------------------
insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr2,
iif(@answr2=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=2
----------------------------------------------------------------
 insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr3,
iif(@answr3=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=3
-------------------------------------------------------------------
insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr4,
iif(@answr4=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
and questionnum=4
----------------------------------------------------------------------
insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr5,
iif(@answr5=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=5
----------------------------------------------------------
   insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr6,
iif(@answr6=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=6
-----------------------------------------------------
   insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr7,
iif(@answr7=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=7
----------------------------------------------------------
   insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr8,
iif(@answr8=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=8
--------------------------------------------------------------
   insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr9,
iif(@answr9=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=9
   insert into ansewrsOfTheQuestion
select q.questionId,@student_id,@exam_id,@answr10,
iif(@answr10=q.[questionModelAnswer],q.[questionGrade],0)
from @temp_table t inner join Question q
  on t.question_id=q.questionId
   and questionnum=10

end

GO
/****** Object:  StoredProcedure [dbo].[Exam_Correction]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Exam_Correction] @exam_id int,@stud_id int,@final_student_grade float output
 as
 begin
 declare @exam_grade float
  declare @student_grade float
 set @student_grade=(select sum (ansewrsOfTheQuestion.gradeOfTheAnswer) 
 from ansewrsOfTheQuestion 
 where studentIdFK=@stud_id and ansewrsOfTheQuestion.examIdFK=@exam_id)
 set @exam_grade =(Select totalExamGrade from Exam where examId=@exam_id)
 set @final_student_grade=(@student_grade/@exam_grade)*100
 update studentEnrollsInCourse set studentEnrollsInCourse.[grade] =@final_student_grade
 where studentIdFK=@stud_id 
 end

GO
/****** Object:  StoredProcedure [dbo].[Exam_Question_info]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Exam_Question_info] @ex_id int
as
begin
SELECT examIdFK,questionIdFFK,question,A,B,C,D,T,F
FROM  Exam_question 
PIVOT
 (
  max (choiceContent)
   FOR questionChoice IN (A,B,C,D,T,F)
 ) AS piv where examIdFK=@ex_id; 
 
 end

GO
/****** Object:  StoredProcedure [dbo].[Exam_Question_info_with_Answers]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Exam_Question_info_with_Answers] @ex_id int,@stud_id int
as
begin
SELECT StudentId,examId,questionId,question,A,B,C,D,T,F,questionAnswer
FROM Exam_question_And_ANSWERS 
PIVOT
 (
  max (choiceContent)
   FOR questionChoice IN (A,B,C,D,T,F)
 ) AS piv where examId=@ex_id and studentId=@stud_id; 
 
 end

GO
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GenerateExam] @cours_name varchar(20),@num_of_mcq int ,@num_of_tf int
as
begin
declare @crs_id int =(select courseId from Course where courseName=@cours_name) 
if(@crs_id is null)
begin
select 'this course is not found'
return;
end
if(@num_of_mcq<0 or @num_of_mcq>10 or @num_of_tf <0 or @num_of_tf>10)
begin
select 'invalid number of questions'
return;
end
if(@num_of_mcq +@num_of_tf <10 or @num_of_mcq +@num_of_tf >10 )
begin
select 'please check Number of questions not 10'
return;
end
insert into Exam (courseIdFK) values (@crs_id)
declare @Exam_id int = (select MAX(examId) from Exam)
insert into examQuestions
select @Exam_id ,questionId from 
(
select top(@num_of_mcq) questionId from Question
where questionType='mcq' and courseIdFK=@crs_id
order by NEWID()
union
select top(@num_of_tf) questionId from Question
where questionType='tf'and  courseIdFK=@crs_id
order by NEWID()
) as questions
update Exam set totalExamGrade=(
Select sum(questionGrade) from Question inner join examQuestions
on Question.questionId=examQuestions.questionIdFK and examQuestions.examIdFK=@Exam_id )
where Exam.examId=@Exam_id
end

GO
/****** Object:  StoredProcedure [dbo].[insertNewCourse]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC updateSpecificCourse 130, 'DS'

----------------------------

create procedure [dbo].[insertNewCourse] (@courseName nvarchar(30))
as
	begin try
		declare @verifyName nvarchar(30)
		select @verifyName = courseName
		from Course
		where courseName = @courseName

		if @verifyName IS NULL 
		begin
			insert into Course 
			values (@courseName)
		end

		else 
			select 'This Course is already insereted'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[insertNewDepartment]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertNewDepartment](@departmentName nvarchar(30))
AS
BEGIN

BEGIN TRY
DECLARE @verifyDeptName nvarchar(30)

	SELECT @verifyDeptName = deptName
	FROM dbo.Department
	WHERE deptName = @departmentName

	IF @verifyDeptName IS NULL
		INSERT INTO dbo.Department(deptName)
		Values(@departmentName)
	ELSE
		PRINT 'Error! This Department already exists'
END TRY

BEGIN CATCH
	EXEC procCatchError;
END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[insertSpecificInstructor]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--retrieveSpecificInstructorData 1000

----------------------------

create procedure [dbo].[insertSpecificInstructor] (@fName nvarchar(30), @lName nvarchar(30), @address nvarchar(30), @salary int, @supervisorId int, @deptId int, @workingHours int)
as
	begin try	
		If @supervisorId IS NOT NULL
		BEGIN
			declare @verifyInsId int
			select @verifyInsId = instId
			from Instructor
			where instId = @supervisorId
		END

		IF @deptId IS NOT NULL
		BEGIN
			declare @verifyDeptId int
			select @verifyDeptId = deptId
			from Department
			where deptId = @deptId
		END

		if @supervisorId IS NULL and @deptId IS NULL
		begin
			insert into Instructor (instFName, instLName, instAddress, instSalary, workingHours)
			values (@fName, @lName, @address, @salary, @workingHours)
		end
		ELSE IF @supervisorId IS NULL and @deptId IS NOT NULL
		begin
			if @verifyDeptId IS NOT NULL
			BEGIN
				insert into Instructor (instFName, instLName, instAddress, instSalary, deptIdFK, workingHours)
				values (@fName, @lName, @address, @salary, @deptId, @workingHours)
			END
		end
		ELSE IF @supervisorId IS NOT NULL and @deptId IS NULL
		begin
			IF @verifyInsId IS NOT NULL
			BEGIN
				insert into Instructor (instFName, instLName, instAddress, supervisorId, instSalary, workingHours)
				values (@fName, @lName, @address, @supervisorId, @salary, @workingHours)
			END
		end
		ELSE IF @supervisorId IS NOT NULL and @deptId IS NOT NULL
		begin
			IF @verifyInsId IS NOT NULL AND @verifyDeptId IS NOT NULL
			BEGIN
				insert into Instructor (instFName, instLName, instAddress, supervisorId, instSalary, deptIdFK, workingHours)
				values (@fName, @lName, @address, @supervisorId, @salary, @deptId, @workingHours)
			END
			ELSE
				SELECT 'Sth went wrong';
		end

		else
			select 'This supervisor does not exist'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[insertSpecificTopic]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--retrieveSpecificTopicData 1

----------------------------

create procedure [dbo].[insertSpecificTopic] (@topicName nvarchar(30), @courseId int)
as
	begin try	
		declare @verifyName nvarchar(30)
		select @verifyName = topicName
		from Topic
		where topicName = @topicName

		if @verifyName IS NULL
		begin
			insert into Topic
			values (@topicName, @courseId)
		end

		else
			select 'This Topic is already existed'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[InstractorByID3]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InstractorByID3] (@ID int)
as

select i.instFName + ' '+i.instLName as FullName, i.instId,c.courseName ,COUNT(sc.studentIdFK) as NoOfStudent from Instructor i inner join instructorTeachesCourse  ic
on i.instId=@ID and i.instId = ic.instIdFK 
inner join Course c
on ic.courseIdFK = c.courseId
inner join studentEnrollsInCourse sc 
on ic.courseIdFK = sc.courseIdFK
group by i.instId , c.courseName ,i.instFName + ' '+i.instLName 

GO
/****** Object:  StoredProcedure [dbo].[procCatchError]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[procCatchError]
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  

GO
/****** Object:  StoredProcedure [dbo].[retrieveAllCourseData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	--******************************************--

	--NEVENS--
	
--CRUD course

create procedure [dbo].[retrieveAllCourseData]
as
	select courseId as [Course Number], courseName as [Course Title]
	from Course

EXEC retrieveAllCourseData

GO
/****** Object:  StoredProcedure [dbo].[retrieveAllInstructorsData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[retrieveAllInstructorsData]
as	
	select instId as [Instructor Number], CONCAT(instFName, ' ', instLName) as [Full Name], 
	instAddress as [Address], instSalary as [Salary], supervisorId as [Supervisor Number]
	from Instructor
GO
/****** Object:  StoredProcedure [dbo].[retrieveAllTopicData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--deleteSpecificCourse 140

----------------------------

--topic 

create procedure [dbo].[retrieveAllTopicData]
as	
	select topicId as [Topic Number], topicName as [Topic], courseIdFK as [Course Number]
	from Topic

GO
/****** Object:  StoredProcedure [dbo].[retrieveDepartmentData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[retrieveDepartmentData]
AS
	SELECT deptId as [Department ID], deptName as [Department Name]
	FROM Department D
RETURN

GO
/****** Object:  StoredProcedure [dbo].[retrieveDepartmentDataById]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[retrieveDepartmentDataById](@departmentId int)
AS
BEGIN TRY
DECLARE @verifyDeptId int

	SELECT @verifyDeptId = D.deptId
	FROM dbo.Department D
	WHERE D.deptId = @departmentId

IF @verifyDeptId IS NOT NULL
	SELECT deptId as [Department ID], deptName as [Department Name]
	FROM Department D
	WHERE D.deptId = @departmentId

ELSE
	PRINT 'Error! This Department does not exist.'

END TRY

BEGIN CATCH
	 EXEC procCatchError;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[retrieveDepartmentDataByName]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[retrieveDepartmentDataByName](@departmentName nvarchar(30))
AS
BEGIN TRY
	DECLARE @verifyDeptName nvarchar(30)

		SELECT @verifyDeptName = deptName
		FROM dbo.Department 
		WHERE deptName = @departmentName

	IF @verifyDeptName IS NOT NULL

		SELECT D.deptId as [Department ID], deptName as [Department Name]
		FROM Department D
		WHERE D.deptName = @departmentName

	ELSE
		PRINT 'Error! This Department does not exist.'
END TRY

BEGIN CATCH
	EXEC procCatchError;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[retrieveSpecificCourseData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------

create procedure [dbo].[retrieveSpecificCourseData] (@courseId int)
as
	begin try
		declare @verifyId int
		select @verifyId = courseId
		from Course
		where courseId = @courseId

		if @verifyId IS NOT NULL 
		begin
			select courseId as [Course Number], courseName as [Course Title]
			from Course
			where courseId = @courseId
		end

		else
			select 'This Course does not exist'
	end try
	begin catch
		select 'Error'
	end catch 

GO
/****** Object:  StoredProcedure [dbo].[retrieveSpecificTopicData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[retrieveSpecificTopicData] (@topicId int)
as	
	begin try
		declare @verifyId int
		select @verifyId = topicId
		from Topic
		where topicId = @topicId

		if @verifyId IS NULL 
		begin
			select topicId as [Topic Number], topicName as [Topic], courseIdFK as [Course Number]
			from Topic
			where topicId = @topicId
		end

		select 'This Topic does not exit'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[RetriveAllStudentData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[RetriveAllStudentData]
AS
begin
	Begin try
		select * from Student
	end try
	begin catch
		RAISERROR('Sorry There is Something Wrong',16,1)
	end catch
end


GO
/****** Object:  StoredProcedure [dbo].[Select_Student_Grades]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Select_Student_Grades] @student_id int
as
begin
select studentIdFK,grade,Course.courseName
 from studentEnrollsInCourse inner join Course
 on studentEnrollsInCourse.courseIdFK=Course.courseId
and
studentIdFK=@student_id
end

GO
/****** Object:  StoredProcedure [dbo].[SelectStudent_ByDepNo]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectStudent_ByDepNo] (@DepNo int)
as
declare @x int

select * from Student
where deptIdFK = @DepNo
GO
/****** Object:  StoredProcedure [dbo].[SelectStudentByID3]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectStudentByID3] (@ID int)
as
declare @x int
declare @x2 int
select @x=sc.grade from Student s inner join studentEnrollsInCourse sc
on studentId = @ID and s.studentId = sc.studentIdFK

select @x2= examIdFK from ansewrsOfTheQuestion 
where studentIdFK =@ID

if @x is null 
begin
exec [dbo].[Exam_Correction] @x2 ,@ID,@x OUTPUT
end
update studentEnrollsInCourse 
set grade = @x
where studentIdFK = @ID
select s.studentFName + ' '+ s.studentLName as NameOfStudent, c.courseName , sc.grade   from Student s inner join studentEnrollsInCourse sc
on studentId = @ID and s.studentId = sc.studentIdFK
inner join Course c
on c.courseId = sc.courseIdFK
GO
/****** Object:  StoredProcedure [dbo].[student_infromation]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[student_infromation] @dept_id int
as
begin 
declare @deptt_id int=(select deptId from department where deptId=@dept_id)
if (@deptt_id is null)
begin 
select 'There is No Department whith this Name'
return;
end
select * from student where deptIdFK=@dept_id
end


GO
/****** Object:  StoredProcedure [dbo].[updateDepartmentData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateDepartmentData](@oldDeptId int, @newDeptName nvarchar(30))
AS
BEGIN

BEGIN TRY
	DECLARE @verifyDeptId int , @verifyDeptName nvarchar(30)
		SELECT @verifyDeptId = deptId, @verifyDeptName = deptName
		FROM dbo.Department
		WHERE deptId = @oldDeptId AND deptName = @newDeptName

	IF @verifyDeptId IS NOT NULL
	BEGIN
		IF @verifyDeptName IS NOT NULL
		
			UPDATE Department 
			SET deptName = @newDeptName
			WHERE deptId = @oldDeptId
	END
	
	ELSE 
		SELECT 'Error! This Department ID does not exist!'
END TRY

BEGIN CATCH
	EXEC procCatchError;
END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[updateSpecificCourse]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------

create procedure [dbo].[updateSpecificCourse] (@courseId int, @courseName nvarchar(30))
as
	begin try
		declare @verifyName nvarchar(30)
		select @verifyName = courseName
		from Course
		where courseName = @courseName

		if @verifyName IS NOT NULL 
		begin
			update Course
			set courseName = @courseName
			where courseId = @courseId
		end

		else
			select 'This Course does not exist'
	end try
	begin catch
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[updateSpecificInstructor]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insertSpecificInstructor 'neven', 'hossam', 'Cairo', 3000, 1001, 10, 100

----------------------------

create procedure [dbo].[updateSpecificInstructor] (@instId int, @fName nvarchar(30), @lName nvarchar(30), @address nvarchar(30), @salary int, @supervisorId int, @deptId int, @workingHours int)
as
	begin try	
		If @supervisorId IS NOT NULL
		BEGIN
			declare @verifyInsId int
			select @verifyInsId = instId
			from Instructor
			where instId = @supervisorId
		END

		IF @deptId IS NOT NULL
		BEGIN
			declare @verifyDeptId int
			select @verifyDeptId = deptId
			from Department
			where deptId = @deptId
		END

		if @supervisorId IS NULL and @deptId IS NULL
		begin
			update Instructor
			set instFName = @fName, instLName = @lName, instAddress = @address, instSalary = @salary, workingHours = @workingHours
			where instId = @instId  
		end
		ELSE IF @supervisorId IS NULL and @deptId IS NOT NULL
		begin
			if @verifyDeptId IS NOT NULL
			BEGIN
				update Instructor
				set instFName = @fName, instLName = @lName, instAddress = @address, instSalary = @salary, deptIdFK = @deptId, workingHours = @workingHours
				where instId = @instId 
			END
		end
		ELSE IF @supervisorId IS NOT NULL and @deptId IS NULL
		begin
			IF @verifyInsId IS NOT NULL
			BEGIN
				update Instructor
				set instFName = @fName, instLName = @lName, instAddress = @address, instSalary = @salary, supervisorId = @supervisorId, workingHours = @workingHours
				where instId = @instId 
			END
		end
		ELSE IF @supervisorId IS NOT NULL and @deptId IS NOT NULL
		begin
			IF @verifyInsId IS NOT NULL AND @verifyDeptId IS NOT NULL
			BEGIN
				update Instructor
				set instFName = @fName, instLName = @lName, instAddress = @address, instSalary = @salary, supervisorId = @supervisorId, deptIdFK = @deptId, workingHours = @workingHours
				where instId = @instId 
			END
			ELSE
				SELECT 'Sth went wrong';
		end

		else
			select 'This supervisor does not exist'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[updateSpecificTopic]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insertSpecificTopic 'Function', 100

----------------------------

create procedure [dbo].[updateSpecificTopic] (@topicId int, @topicName nvarchar(30), @courseId int)
as
	begin try	
		declare @verifyName nvarchar(30)
		select @verifyName = topicName
		from Topic
		where topicName = @topicName

		if @verifyName IS NOT NULL
		begin
			update Topic
			set topicName = @topicName, courseIdFK = @courseId
			where topicId = @topicId
		end

		else
			select 'This Topic does not exist'
	end try
	begin catch 
		select 'Error'
	end catch

GO
/****** Object:  StoredProcedure [dbo].[UpdateStudentData]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateStudentData] @studid int, @stud_fname nvarchar (30), @stud_lname nvarchar (30)
,@studentadd nvarchar (30),@deptname nvarchar(30)
as
begin
declare @deptid int
set @deptid= (select deptId from department where deptName=@deptname)
if @deptid is null
begin
raiserror ('Sorry this department dosnt exist',16,1)
return
end
begin try
update student set studentFName=@stud_fname,studentLName=@stud_lname
,studentAddress=@studentadd,deptIdFK=@deptid where studentId=@studid
end try
begin catch
raiserror ('Sorry some thing went wrong',16,1)
end catch
end
GO
/****** Object:  Trigger [dbo].[Cant_Delete]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Cant_Delete]
 on [dbo].[ansewrsOfTheQuestion]
for delete
as
begin
select 'Not allowed to delete or update student answer'
insert into ansewrsOfTheQuestion
select * from deleted
end
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion] ENABLE TRIGGER [Cant_Delete]
GO
/****** Object:  Trigger [dbo].[Cant_Update]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Cant_Update]
 on [dbo].[ansewrsOfTheQuestion]
instead of update
as
begin
select 'Not allowed!'
end
GO
ALTER TABLE [dbo].[ansewrsOfTheQuestion] ENABLE TRIGGER [Cant_Update]
GO
/****** Object:  Trigger [dbo].[Delete_student_grade]    Script Date: 1/23/2020 2:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Delete_student_grade]
on [dbo].[studentEnrollsInCourse]
for delete
as
begin
select 'not allowed delete student grade'
insert into studentEnrollsInCourse
select * from deleted
end
GO
ALTER TABLE [dbo].[studentEnrollsInCourse] ENABLE TRIGGER [Delete_student_grade]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key, references to the Qs ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion', @level2type=N'COLUMN',@level2name=N'questionIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key, references to the student Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion', @level2type=N'COLUMN',@level2name=N'studentIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key, references to the Exam Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion', @level2type=N'COLUMN',@level2name=N'examIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The student''s answer to the question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion', @level2type=N'COLUMN',@level2name=N'questionAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The answers standard grade ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion', @level2type=N'COLUMN',@level2name=N'gradeOfTheAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The answers of the questions that the student had answered in his exam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ansewrsOfTheQuestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the course' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'courseId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the course' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'courseName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The courses that we have in organization' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the department table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'deptId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the department' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'deptName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The departments of the organization' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the exam table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'examId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The duration time of the exam that the student will have' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'examTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The final grade of the exam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'totalExamGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Course Id as a Refernce (FK) to the Course table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'courseIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The exams generated for the students' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key of that table references to the exam table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examQuestions', @level2type=N'COLUMN',@level2name=N'examIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key of that table references to the exam table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examQuestions', @level2type=N'COLUMN',@level2name=N'questionIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The relationship between the exam and the question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examQuestions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the instructor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'instId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The first name of the instructor ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'instFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The last name of the instructor ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'instLName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The address of the instructor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'instAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The salary of the instructor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'instSalary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the supervisor refrences to the instructor Id as a self relation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'supervisorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The dept id is a foregin key references to the the dept Id which the instructor is working for' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'deptIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The working hours of the instructor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor', @level2type=N'COLUMN',@level2name=N'workingHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The table of the instructors in the organization' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Instructor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Course Id as a Reference (FK) from Course Table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'instructorTeachesCourse', @level2type=N'COLUMN',@level2name=N'courseIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The instructor Id as a Reference (FK) from the Instructor table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'instructorTeachesCourse', @level2type=N'COLUMN',@level2name=N'instIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The table of the instructors and their courses they teach (M:M Relationship)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'instructorTeachesCourse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary key of the question table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'questionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The question sentence' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The model answer of the question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'questionModelAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The standard grade of the question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'questionGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of the question that defines if the question is a (True or false question) or (Mcq one)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'questionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The course Id is a foregin key refernces to the Course which the question belongs to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'courseIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The questions of the courses which will be included in the exams' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key of that table which references to the question table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'questionChoices', @level2type=N'COLUMN',@level2name=N'questionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One of the composite primary key of that table which is a choice of the question as (A, B, C, D.. etc)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'questionChoices', @level2type=N'COLUMN',@level2name=N'questionChoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The choice sentence of each question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'questionChoices', @level2type=N'COLUMN',@level2name=N'choiceContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The choices of the question' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'questionChoices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student id primary key of the student table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'studentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student''s first name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'studentFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student''s last name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'studentLName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student''s address ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'studentAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A foregin key which references to the department table that the student belongs to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'deptIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key of student table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'studentEnrollsInCourse', @level2type=N'COLUMN',@level2name=N'studentIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'primary key of course table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'studentEnrollsInCourse', @level2type=N'COLUMN',@level2name=N'courseIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student grade in a specific course' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'studentEnrollsInCourse', @level2type=N'COLUMN',@level2name=N'grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Relation table from many to many relation between student and course' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'studentEnrollsInCourse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Topic id primary key of table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Topic', @level2type=N'COLUMN',@level2name=N'topicId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Topic name like oop in c++ course' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Topic', @level2type=N'COLUMN',@level2name=N'topicName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foregin key to course table because each course has many topics' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Topic', @level2type=N'COLUMN',@level2name=N'courseIdFK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Topic table which holds course''s topics data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Topic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Views Exam Questions along with the Choices of the Questions that the student can choose from' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "examQuestions"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Question"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "questionChoices"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 215
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Views the Exam along with the Student''s answer on it' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question_And_ANSWERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ansewrsOfTheQuestion"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Exam"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 136
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Question"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "questionChoices"
            Begin Extent = 
               Top = 138
               Left = 284
               Bottom = 251
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question_And_ANSWERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Exam_question_And_ANSWERS'
GO
