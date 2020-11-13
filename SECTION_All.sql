CREATE TABLE Applications_Sectioned (
	Application_Id int,
	Entrant_Id int,
	Entrant_Data json,
	Direction_Id int,
	Direction_Name text,
	Score int,
	Date_day timestamp
) PARTITION BY RANGE (Date_day);

CREATE TABLE Applications_16_1 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2016-06-01') TO ('2016-06-10');

CREATE TABLE Applications_16_2 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2016-06-10') TO ('2016-06-20');

CREATE TABLE Applications_16_3 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2016-06-20') TO ('2016-10-01');

CREATE TABLE Applications_17_1 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2017-06-01') TO ('2017-06-10');

CREATE TABLE Applications_17_2 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2017-06-10') TO ('2017-06-20');

CREATE TABLE Applications_17_3 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2017-06-20') TO ('2017-10-01');

CREATE TABLE Applications_18_1 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2018-06-01') TO ('2018-06-10');

CREATE TABLE Applications_18_2 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2018-06-10') TO ('2018-06-20');

CREATE TABLE Applications_18_3
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2018-06-20') TO ('2018-10-01');

CREATE TABLE Applications_19_1 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2019-06-01') TO ('2019-06-10');

CREATE TABLE Applications_19_2 
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2019-06-10') TO ('2019-06-20');

CREATE TABLE Applications_19_3
PARTITION OF Applications_Sectioned
FOR VALUES FROM ('2019-06-20') TO ('2019-10-01');

COPY Applications_Sectioned
FROM '/home/getsu/Data/Databases/task3/applications_out' DELIMITER ';';

EXPLAIN SELECT * FROM Applications_Sectioned
WHERE Date_Day = '2018-06-13';

EXPLAIN SELECT * FROM Applications
WHERE Date_Day = '2018-06-13';

--cost=1000...180000 (actual time = 5000)
EXPLAIN ANALYZE SELECT * FROM Applications_Sectioned
WHERE Date_Day = '2018-06-13';


--cost=1000..2000000 (actual time = 50000)
-- exectution time 50000
EXPLAIN ANALYZE SELECT * FROM Applications
WHERE Date_Day = '2018-06-13';

SET enable_indexscan = true;
-- ускорение в 4,5 раза (потому что секционирование не очень большое)












