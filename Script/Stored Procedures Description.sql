-- Stored Procedures Descriptions

--1. Exam_Answers UDSP
EXEC sp_addextendedproperty 'MS_Description', 'Stored procedure to get answers of an exam',
 'schema', dbo, 'PROCEDURE', 'Exam_Answers'
 --2. Exam_Correction UDSP
EXEC sp_addextendedproperty 'MS_Description', 'Stored procedure to correct a specific exam for grading.',
 'schema', dbo, 'PROCEDURE', 'Exam_Answers'
 --3. Generate Exam UDSP
EXEC sp_addextendedproperty 'MS_Description', 'Stored procedure to generate an exam.',
 'schema', dbo, 'PROCEDURE', 'Exam_Answers'
 --4. Exam_Question_info UDSP
EXEC sp_addextendedproperty 'MS_Description', 'Stored procedure to get Choices Content of a Question.',
 'schema', dbo, 'PROCEDURE', 'Exam_Answers'
 --5. Exam_Question_info_with_Answers UDSP
EXEC sp_addextendedproperty 'MS_Description', 'Stored procedure to get Choices Content of a Question along with the answer.',
 'schema', dbo, 'PROCEDURE', 'Exam_Answers'


USE master;  
GO  
ALTER DATABASE ExaminationOnlineSystemDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE ExaminationOnlineSystemDb MODIFY NAME = ExaminationOnlineSystemDbTemp ;
GO  
ALTER DATABASE ExaminationOnlineSystemDbTemp SET MULTI_USER
GO