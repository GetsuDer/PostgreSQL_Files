-- Нельзя удалить предмет, по которому идут уроки, который изучают студенты или ведут профессора
CREATE TRIGGER My_trigger1 
BEFORE DELETE ON Subjects
FOR EACH ROW
EXECUTE FUNCTION My_function1();

-- Нельзя заставить студента посещать две пары сразу. 

CREATE TRIGGER My_trigger2 
BEFORE INSERT OR UPDATE ON Lessons
FOR EACH ROW
EXECUTE FUNCTION My_function2();

-- Нельзя сделать профессора слишком старым

CREATE TRIGGER My_trigger3 
BEFORE INSERT OR UPDATE ON Professors
FOR EACH ROW
EXECUTE FUNCTION My_function3();

