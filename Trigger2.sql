-- Нельзя заставить студента посещать две пары сразу. 

CREATE TRIGGER My_trigger2 
BEFORE INSERT OR UPDATE ON Lessons
FOR EACH ROW
EXECUTE FUNCTION My_function2();