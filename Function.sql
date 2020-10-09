--DROP FUNCTION  IF EXISTS My_func()

CREATE FUNCTION My_func() 
RETURNS trigger AS '
BEGIN
	IF (SELECT count (*) 
		  FROM (Knowedge_Areas NATURAL JOIN Subjects)
		  WHERE Subject_Name = TH_ARGV[0]) > 0 THEN 
			BEGIN
				RAISE NOTICE ''WRONG'';
				RETURN NULL;
			END;
	END IF;
	IF (SELECT count (*) 
		  FROM (Factical_Leatnings NATURAL JOIN Subjects)
		  WHERE Subject_Name = TH_ARGV[0]) > 0 THEN
				BEGIN
					RAISE NOTICE ''WRONG'';
					RETURN NULL;
				END;
	END IF;
	IF (SELECT count (*) 
		  FROM (Lessons NATURAL JOIN Subjects)
		  WHERE Subject_Name = TH_ARGV[0]) > 0 THEN
			BEGIN
				RAISE NOTICE ''WRONG'';
				RETURN NULL;
			END;
	END IF;
	RETURN OLD;
END'
LANGUAGE plpgsql;