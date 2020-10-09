BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- изменяем данные
UPDATE Lessons SET Duration = Duration / 2 WHERE Lesson_Id = 1;
-- Меняем данные
UPDATE Professors SET Professor_Name = 'NONE' WHERE Professor_Id = 1;

COMMIT;


BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Меняем данные
UPDATE Professors SET Professor_Name = 'NONE' WHERE Professor_Id = 2;


COMMIT;


BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
UPDATE Professors SET Professor_Name = 'NONE' WHERE Professor_Id = 3;

UPDATE Students SET Group_Id = 2 WHERE Student_Id = 1;
COMMIT;

BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE Students SET Group_Id = 2 WHERE Student_Id = 2;
COMMIT;
