CREATE TRIGGER My_trigger 
BEFORE DELETE ON Subjects
FOR EACH ROW
EXECUTE FUNCTION My_function();