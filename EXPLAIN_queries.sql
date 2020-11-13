SET enable_indexscan = false;
SET enable_indexscan = true;

-- создать нужный индекс. ДОЛГО.
CREATE INDEX Entrant_Id_Index_In_Applications ON Applications (Entrant_Id);

-- запрос к одной базе данных с фильтрацией по нескольким полям
EXPLAIN SELECT * FROM Applications
WHERE Date_Day > '21/06/2017' AND Score > 190 AND Application_Id > 1000
ORDER BY Entrant_Id
LIMIT 1000;

--без индексов cost=2500000, actual time = 50000
--c индексами cost=6000, actual time = 100
EXPLAIN ANALYZE SELECT * FROM Applications
WHERE Date_Day > '21/06/2017' AND Score > 190 AND Application_Id > 1000
ORDER BY Entrant_Id
LIMIT 1000;

-- запрос к нескольким таблицам с фильтрацией по нескольким полям
EXPLAIN SELECT *
FROM Applications JOIN Entrants USING (Entrant_Id)
WHERE Entrant_Id < 10000 AND Direction_Id > 20000;

-- without cost=2000000 actual time = 20000ms
-- with cost=400000 actual time = 19000ms
EXPLAIN ANALYZE SELECT *
FROM Applications JOIN Entrants USING (Entrant_Id)
WHERE Entrant_Id < 10000 AND Direction_Id > 20000;

-- полнотекстовый поиск
-- поле essay в таблицу entrants имеет вид текст
--CREATE INDEX essay_index ON Entrants USING GIN (to_tsvector('english', essay));

EXPLAIN SELECT * FROM Entrants
WHERE to_tsvector('english', essay) @@ 'magic';

--without index cost=35000 time=31000ms
--with cost = 34000 actual time = 21000ms
EXPLAIN ANALYZE SELECT * FROM Entrants
WHERE to_tsvector('english', essay) @@ 'magic';

-- работа с массивами
-- array_ops - класс операторов индекса GIN,
CREATE INDEX array_index ON Entrants USING GIN (Made_Applications array_ops);
EXPLAIN SELECT * FROM Entrants
WHERE Made_Applications && ARRAY[1, 2, 100];

--without cost=90000 time=500ms
--with cost=80000 time = 40ms
EXPLAIN ANALYZE SELECT * FROM Entrants
WHERE Made_Applications && ARRAY[1, 2, 100];

-- работа с jsonb. Тот же GIN, что и в прошлом пункте.
--CREATE INDEX json_index ON Entrants USING GIN (exams);

EXPLAIN SELECT * FROM Entrants
WHERE exams @> '{"exam1": 100}';

--without cost 8000 time 15000
--with cost 75000 time 12000
EXPLAIN ANALYZE SELECT * FROM Entrants
WHERE exams @> '{"exam1": 100}';
