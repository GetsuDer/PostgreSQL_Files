BEGIN;

DROP TABLE IF EXISTS Applications;
DROP TABLE IF EXISTS Learning_Directions;
DROP TABLE IF EXISTS Entrants;
DROP TABLE IF EXISTS Educational_Places;
-- 1000 строк
CREATE TABLE Educational_Places (
	Educational_Place_Id SERIAL PRIMARY KEY,
	City text NOT NULL,
	Place_Info text,
	Place_Name text NOT NULL
);

-- 20 000 000
CREATE TABLE Entrants (
	Entrant_Id SERIAL PRIMARY KEY,
	Entrant_Name text,
	Exams json,
	Made_Applications int[],
	Essay text
);

-- 30 000 строк
CREATE TABLE Learning_Directions (
	Direction_Id SERIAL PRIMARY KEY,
	Speciality_Name text NOT NULL,
	Duration INTERVAL MONTH,
	Place_Id int REFERENCES Educational_Places ON DELETE RESTRICT ON UPDATE CASCADE,
	Student_Number int CHECK(Student_Number > 0),
	Exams_Needed int[]
);

CREATE TABLE Applications (
	Application_Id SERIAL PRIMARY KEY,
	Entrant_Id int REFERENCES Entrants ON DELETE RESTRICT ON UPDATE CASCADE,
	Direction_Id int REFERENCES Learning_Directions ON DELETE RESTRICT ON UPDATE CASCADE,
	Date_day timestamp,
	Score int
);

END;




