CREATE FUNCTION Changing_Application() 
RETURNS trigger AS '
BEGIN
	IF (TG_OP = ''INSERT'') THEN 
		BEGIN
			UPDATE Entrants SET Made_Applications = Made_Applications || ARRAY[NEW.Application_Id]
				WHERE Entrant_Id = NEW.Entrant_Id;
		END;
	END IF;
	
	IF (TG_OP = ''DELETE'') THEN
		BEGIN
			UPDATE Entrants SET Made_Applications = array_remove(Made_Applications, NEW.Application_Id)
				WHERE Entrant_Id = NEW.Entrant_Id;
		END;
	END IF;
	
	IF(TG_OP = ''UPDATE'') THEN
		BEGIN
			UPDATE Entrants SET Made_Applications = array_remove(Made_Applications, NEW.Application_Id)
			WHERE Entrant_Id = OLD.Entrant_Id;
			UPDATE Entrants SET Made_Applications = Made_Applications || ARRAY[NEW.Application_Id]
			WHERE Entrant_Id = NEW.Entrant_Id;
		END;
	END IF;
	
	RETURN NULL;
END'
LANGUAGE plpgsql;