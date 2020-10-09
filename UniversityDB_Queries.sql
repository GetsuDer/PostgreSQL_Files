-- Расписание для преподавателя
/*
WITH Prof_ID AS ( 
	SELECT Professor_Id AS PID FROM Professors WHERE Professor_Name = 'Иванов Иван Иванович'
)
SELECT Subject_Name, Classroom, Week_Day, Duration
FROM Lessons NATURAL JOIN Subjects NATURAL JOIN Knowledge_Areas
WHERE Professor_Id IN (SELECT PID FROM Prof_ID);
*/

-- Расписание для студента
/*
SELECT Subject_Name, Classroom, Week_Day, Duration
FROM Lessons NATURAL JOIN Subjects NATURAL JOIN Factical_Learnings
WHERE Student_Id IN (SELECT Student_Id FROM Students WHERE Student_Name = 'Ярмольника Юнона Елисеевна');
*/

-- Кто должен прийти на урок?
/*
SELECT Student_Name, Group_Number
FROM Lessons NATURAL JOIN Factical_Learnings NATURAL JOIN Students NATURAL JOIN Student_Groups
WHERE Student_Id IN
	(SELECT Student_Id FROM Factical_Learnings WHERE Subject_Id IN 
	 	(SELECT Subject_Id FROM Subjects WHERE Subject_Name = 'Linear algebra lectures'));
		*/
		
-- Вольнослушатели	
/*
SELECT * FROM Students
WHERE Group_Id IS NULL;
*/

-- Предметы, изучаемые вольнослушателями
/*
SELECT Student_name, Subject_Name, Week_Day, Duration
FROM Lessons NATURAL JOIN Subjects NATURAL JOIN Factical_Learnings NATURAL JOIN students
WHERE Group_Id IS NULL;
*/

-- Лекции определенной группы по вторникам
/*
SELECT DISTINCT Subject_Name, Classroom, Duration, Start_Time
FROM Lessons NATURAL JOIN Factical_Learnings NATURAL JOIN Students NATURAL JOIN Subjects
WHERE Group_Id = (SELECT Group_Id FROM Student_Groups WHERE Group_Number = 101)
AND Week_Day = 'Tuesday';
*/

-- Уроки, пересекающиеся по времени
/*
WITH L1 AS (
		SELECT Lesson_id AS ID1, Duration, Week_Day, Start_Time FROM Lessons), 
	 L2 AS (
		SELECT Lesson_id AS ID2, Duration, Week_Day, Start_Time FROM Lessons)
SELECT *
FROM L1 CROSS JOIN L2
WHERE ID1 <> ID2 AND L1.Week_Day = L2.Week_Day AND NOT
	(L1.Start_Time + L1.Duration < L2.Start_Time OR L2.Start_Time + L2.Duration < L1.Start_Time)
ORDER BY ID1, ID2;
*/

-- То же без лишней информации
/*
WITH L1 AS (
		SELECT Lesson_id AS ID1, Duration, Week_Day, Start_Time FROM Lessons), 
	 L2 AS (
		SELECT Lesson_id AS ID2, Duration, Week_Day, Start_Time FROM Lessons)
SELECT ID1, ID2
FROM L1 CROSS JOIN L2
WHERE ID1 <> ID2 AND L1.Week_Day = L2.Week_Day AND NOT
(L1.Start_Time + L1.Duration < L2.Start_Time OR L2.Start_Time + L2.Duration < L1.Start_Time)
ORDER BY ID1, ID2;
*/
-- Студенты, посещающие уроки, пересекающиеся по времени
/*
WITH
	 Lesson_Student AS (
		SELECT Student_Id, Lesson_Id
		FROM Students NATURAL JOIN Factical_Learnings NATURAL JOIN Lessons
	 ),
	 L1 AS (
		SELECT Lesson_id AS ID1, Duration, Week_Day, Start_Time FROM Lessons), 
	 L2 AS (
		SELECT Lesson_id AS ID2, Duration, Week_Day, Start_Time FROM Lessons),
	 L3 AS (
		SELECT ID1, ID2
		FROM L1 CROSS JOIN L2
		WHERE ID1 <> ID2 AND L1.Week_Day = L2.Week_Day AND NOT
		(L1.Start_Time + L1.Duration < L2.Start_Time OR L2.Start_Time + L2.Duration < L1.Start_Time))
SELECT Student_Id, LS1.Lesson_Id, LS2.Lesson_Id
FROM Lesson_Student AS LS1 INNER JOIN Lesson_Student AS LS2 USING (Student_Id)
WHERE LS1.Lesson_Id < LS2.Lesson_Id AND (LS1.Lesson_Id, LS2.Lesson_Id) IN (TABLE L3)
ORDER BY Student_Id, LS1.Lesson_Id, LS2.Lesson_Id;
*/
/*
SELECT F1.Student_Id, LS1.Lesson_Id, LS2.Lesson_Id
FROM (Factical_Learnings AS F1 NATURAL JOIN Lessons AS LS1) JOIN (Factical_Learnings AS F2 NATURAL JOIN Lessons LS2) 
	ON (F1.Student_Id = F2.Student_Id AND LS1.Lesson_Id < LS2.Lesson_Id AND LS1.Week_Day = LS2.Week_Day AND NOT
		(LS1.Start_Time + LS1.Duration < LS2.Start_Time OR LS2.Start_Time + LS2.Duration < LS1.Start_Time)
	   	)
ORDER BY Student_Id, LS1.Lesson_Id, LS2.Lesson_Id;
*/
-- Отменить лекции по физике. Не работает, потому что
--нельзя удалять предмет прежде, чем уроки по предмету (Lessons) и связи профессоров с предметом,
-- а Lessons - прежде, чем связь студентов и уроков
/*
DELETE FROM Subjects WHERE Subject_Name = 'Physics lectures';
*/

-- Поэтому надо сначала удалить все дополнительные строки, ссылающиеся на этот предмет
/*
DELETE FROM Knowledge_Areas 
WHERE Subject_Id = (SELECT Subject_Id FROM Subjects WHERE Subject_Name = 'Physics lectures');

DELETE FROM Factical_Learnings
WHERE Subject_Id = (SELECT Subject_Id FROM Subjects WHERE Subject_Name = 'Physics lectures');

DELETE FROM Lessons
WHERE Subject_Id = (SELECT Subject_Id FROM Subjects WHERE Subject_Name = 'Physics lectures');

DELETE FROM Subjects WHERE Subject_Name = 'Physics lectures';
*/

-- А вот переименовать предмет можно без всяких проблем, потому что связывание производится
-- по идентификатору.
/*
UPDATE Subjects 
SET Subject_Name = 'Lectures on physics' 
WHERE Subject_Name = 'Physics lectures' ;
SELECT * FROM SUBJECTS WHERE Subject_Name = 'Lectures on physics';
*/

-- Можно исключить студента, при этом удалятся его связи с уроками, на которые он
-- был записан
/*
DELETE FROM Students WHERE Student_Id = 17;
SELECT * FROM Factical_Learnings WHERE Student_Id = 17;
*/

-- Перенести все уроки профессора в одну аудиторию
/*
SELECT * FROM Lessons
WHERE Subject_Id IN 
	(SELECT Subject_Id FROM Knowledge_Areas WHERE Professor_Id = 1);
*/
/*
UPDATE Lessons
SET Classroom = 'Special Classroom'
WHERE Subject_Id IN
 (SELECT Subject_Id FROM Knowledge_Areas
  WHERE Professor_Id IN 
 		(SELECT Professor_Id FROM Professors WHERE Professor_Name = 'Иванов Иван Иванович')
  );
  
 SELECT * FROM Lessons
 WHERE Classroom = 'Special Classroom';
*/