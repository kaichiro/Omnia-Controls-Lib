/** variável que guarda o ID do Studant */
declare @StudentID int = (select top 1 s.ID from ContosoUniversity1.dbo.Student s where s.FirstName = 'Fulano');

/** declara CURSOR */
declare courses cursor for select CourseID from ContosoUniversity1.dbo.Course
/** variável que será iterada dinamicamente */
declare @grade int
/** variável contadora */
declare @count int = 0
/** variável para quantidade (count) */
declare @maxCount int = (select count(*) from ContosoUniversity1.dbo.Course)
/** abre o cursor */
open courses
/** loop */
while @count < @maxCount
begin
	fetch courses into @grade
	--print str(@grade)
	insert into ContosoUniversity1.dbo.Enrollment (CourseID, StudentID, Grade) values (@grade, @StudentID, cast(RAND()*100 as int));
	set @count = @count + 1
end
/** fecha o cursor */
close courses
/** destrói o cursor */
deallocate courses

