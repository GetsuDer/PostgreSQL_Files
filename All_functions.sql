
CREATE FUNCTION My_function1() 
RETURNS trigger AS '
BEGIN
	IF (SELECT count (*) 
		  FROM (Knowledge_Areas NATURAL JOIN Subjects)
		  WHERE Subject_Name = OLD.Subject_Name) > 0 THEN 
			BEGIN
				RAISE NOTICE ''Unsolved dependences in Knowledge_Areas for %'', OLD.Subject_Name;
				RETURN NULL;
			END;
	END IF;
	IF (SELECT count (*) 
		  FROM (Factical_Learnings NATURAL JOIN Subjects)
		  WHERE Subject_Name = OLD.Subject_Name) > 0 THEN
				BEGIN
					RAISE NOTICE ''Unsolved dependences in Factical_Learnings for %'', OLD.Subject_Name;
					RETURN NULL;
				END;
	END IF;
	IF (SELECT count (*) 
		  FROM (Lessons NATURAL JOIN Subjects)
		  WHERE Subject_Name = OLD.Subject_Name) > 0 THEN
			BEGIN
				RAISE NOTICE ''Unsolved dependences in Lessons for %'', OLD.Subject_Name;
				RETURN NULL;
			END;
	END IF;
	RETURN OLD;
END'
LANGUAGE plpgsql;


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


CREATE FUNCTION My_function3() 
RETURNS trigger AS '
BEGIN
	IF (NOT NEW.Birthday_Date > ''01/01/1900'') THEN
		RAISE NOTICE ''You cant set birthday_date %'', NEW.Birthday_Date;
		IF (NEW.Birthday_Date IS NOT NULL) THEN NEW.Birthday_Date = OLD.Birthday_Date;
		ELSE NEW.Birthday_Date = ''01/01/1901'';
		END IF;
	END IF;
	RETURN NEW;
END'
LANGUAGE plpgsql;