--DROP FUNCTION  IF EXISTS My_function2()

CREATE FUNCTION My_function2() 
RETURNS trigger AS '
BEGIN
	IF (
	WITH Stud AS (
		SELECT DISTINCT Student_Id
		FROM Factical_Learnings WHERE Subject_Id = NEW.Subject_Id
	)	
	SELECT count(*) 
		FROM Factical_Learnings NATURAL JOIN Lessons
		WHERE Lesson_Id != NEW.LEsson_Id AND Factical_learnings.Student_Id IN (TABLE Stud) AND Week_Day = NEW.Week_Day AND NOT
		(Start_Time + Duration < NEW.Start_Time OR NEW.Start_Time + NEW.Duration < Start_Time)) > 0 THEN
			BEGIN
				RAISE NOTICE ''Error in schedule for lesson %'', NEW.Lesson_Id;
				RETURN NULL;
			END;
		RAISE NOTICE ''Wrong lesson %'', NEW.Lesson_Id;
	END IF;
	RETURN NEW;
END'
LANGUAGE plpgsql;
