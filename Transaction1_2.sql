BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Изменяем данные (не работает, потому что ждем,
--пока зафиксируется другая транзакция)
UPDATE Lessons SET Duration = Duration / 2 WHERE Lesson_Id = 1;

-- грязное чтение (нет, тк PG его не допускает даже в READ UNCOMMITED)
SELECT * FROM Professors WHERE Professor_Id = 1;
COMMIT;

SELECT * FROM Lessons WHERE Lesson_Id = 1;

BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- неповторяющееся чтение + грязное чтение (которого нет)
SELECT * FROM Professors WHERE Professor_Id = 2;
SELECT * FROM Professors WHERE Professor_Id = 2;
-- результат другой, неповторяющееся чтение
COMMIT;


BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- неповторяющееся чтение, результат не меняется
SELECT * FROM Professors WHERE Professor_Id = 3;
SELECT * FROM Professors WHERE Professor_Id = 3;

-- проверяем на фантомов: до начала транзакции изменения, после, после комита, 
-- после комита этой транзакции. Все ок, фантомизации нет (PG)
SELECT count(*) FROM Students WHERE Group_Id = 2;
COMMIT;

BEGIN;
SET TRANSACTION ISOLATION LEVEL  SERIALIZABLE;
SELECT count(*) FROM Students WHERE Group_Id = 2;
COMMIT;




