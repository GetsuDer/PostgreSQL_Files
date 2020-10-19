BEGIN;

DROP TABLE IF EXISTS Applications;
DROP TABLE IF EXISTS Learning_Directions;
DROP TABLE IF EXISTS Entrants;
DROP TABLE IF EXISTS Educational_Places;
-- 1000 строк
CREATE TABLE Educational_Places (
	Educational_Place_Id int,
	City text,
	Place_Info text,
	Place_Name text
);

-- 2 000 000
CREATE TABLE Entrants (
	Entrant_Id int,
	Entrant_Name text,
	Exams jsonb,
	Made_Applications int[],
	Essay text
);

-- 30 000 строк
CREATE TABLE Learning_Directions (
	Direction_Id int,
	Speciality_Name text,
	Duration INTERVAL MONTH,
	Place_Id int,
	Student_Number int,
	Exams_Needed int[]
);
 -- 100 000 000
CREATE TABLE Applications (
	Application_Id int,
	Entrant_Id int,
	Direction_Id int,
	Date_day timestamp,
	Score int
);

COMMIT;




