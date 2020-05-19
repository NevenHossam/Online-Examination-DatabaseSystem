use examinationOnlineSystemDb
--GenerateExam 'C#', 4 , 6
--Exam_Answers 1,1,'A','A','A','A','A','A','A','A','A','A'
Exam_Answers 2,1,'A','B','A','B','A','B','A','B','A','B'

-----------  1   -----------------------------
alter proc SelectStudent_ByDepNo (@DepNo int)
as
declare @x int

select * from Student
where deptIdFK = @DepNo

exec SelectStudent_ByDepNo 10

-----------  2   ------------------------------
alter proc SelectStudentByID3 (@ID int)
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

exec SelectStudentByID3 1
------------  3   ---------------------------
create proc InstractorByID3 (@ID int)
as

select i.instFName + ' '+i.instLName as FullName, i.instId,c.courseName ,COUNT(sc.studentIdFK) as NoOfStudent from Instructor i inner join instructorTeachesCourse  ic
on i.instId=@ID and i.instId = ic.instIdFK 
inner join Course c
on ic.courseIdFK = c.courseId
inner join studentEnrollsInCourse sc 
on ic.courseIdFK = sc.courseIdFK
group by i.instId , c.courseName ,i.instFName + ' '+i.instLName 

exec InstractorByID3 1007

---------------  6   ---------------------------------

create proc course_Topics (@ID int)
as

select c.courseName , topicName from Topic t inner join Course c
on c.courseId = @ID and  t.courseIdFK = c.courseId

exec course_Topics 100
-----------------  ---------------------------------------
ALTER TABLE studentEnrollsInCourse
ADD grade int;

ALTER TABLE Course
ADD Coursegrade int;