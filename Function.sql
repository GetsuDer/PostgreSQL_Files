--DROP FUNCTION  IF EXISTS My_function()

CREATE FUNCTION My_function() 
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