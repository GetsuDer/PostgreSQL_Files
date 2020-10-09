DELETE FROM Subjects WHERE Subject_Name = 'Physics lectures';

SELECT F1.Student_Id, LS1.Lesson_Id, LS2.Lesson_Id
FROM (Factical_Learnings AS F1 NATURAL JOIN Lessons AS LS1) JOIN (Factical_Learnings AS F2 NATURAL JOIN Lessons LS2) 
	ON (F1.Student_Id = F2.Student_Id AND LS1.Lesson_Id < LS2.Lesson_Id AND LS1.Week_Day = LS2.Week_Day AND NOT
		(LS1.Start_Time + LS1.Duration < LS2.Start_Time OR LS2.Start_Time + LS2.Duration < LS1.Start_Time)
	   	)
ORDER BY Student_Id, LS1.Lesson_Id, LS2.Lesson_Id;