DROP TRIGGER IF EXISTS My_trigger1 ON Subjects;
DROP FUNCTION IF EXISTS My_function1;
DROP TRIGGER IF EXISTS My_trigger2 ON Lessons;
DROP FUNCTION IF EXISTS My_function2;

DROP TABLE IF EXISTS Knowledge_Areas;
DROP TABLE IF EXISTS Factical_Learnings;


DROP TABLE IF EXISTS Professors;
DROP TABLE IF EXISTS Students;

DROP TABLE IF EXISTS Student_Groups;
DROP TABLE IF EXISTS Lessons;
DROP TABLE IF EXISTS Subjects;

CREATE TABLE Professors (
	Professor_Id SERIAL PRIMARY KEY,
	Address text,
	Professor_Name text NOT NULL,
	Phone_number text UNIQUE,
	Birthday_Date date CHECK(Birthday_Date > '01/01/1900'),
	Email text
);

CREATE TABLE Student_Groups (
	Group_Id SERIAL PRIMARY KEY,
	Group_Number integer NOT NULL UNIQUE,
	Course integer NOT NULL DEFAULT 1
);

CREATE TABLE Students (
	Student_Id SERIAL PRIMARY KEY,
	Student_Name text NOT NULL,
	Email text,
	Group_Id integer REFERENCES Student_Groups ON DELETE RESTRICT ON UPDATE CASCADE,
	Leader bool DEFAULT false
);


CREATE TABLE Subjects (
	Subject_Id SERIAL PRIMARY KEY,
	Subject_Name text NOT NULL,
	Sertification_Type text NULL,
	Importancy text NOT NULL,
	CHECK(Importancy IN ('Required', 'Optional')),
	CHECK(Sertification_Type IN ('Test', 'Exam'))
);

CREATE TABLE Lessons (
	Lesson_Id SERIAL PRIMARY KEY,
	Subject_Id integer REFERENCES Subjects ON DELETE RESTRICT ON UPDATE CASCADE,
	Classroom text NOT NULL,
	Lesson_Type text NOT NULL DEFAULT 'Usial',
	Week_day text,
	Start_time time,
	Duration interval NOT NULL DEFAULT INTERVAL '90' MINUTE,
	CHECK(Lesson_Type IN ('Usial', 'Exam', 'Consultation')),
	CHECK(Week_day IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'))
);

CREATE TABLE Knowledge_Areas (
	Subject_Id integer NOT NULL REFERENCES Subjects ON DELETE RESTRICT ON UPDATE CASCADE,
	Professor_Id integer NOT NULL REFERENCES Professors ON DELETE RESTRICT ON UPDATE CASCADE,
	UNIQUE (Subject_Id, Professor_Id)
);

CREATE TABLE Factical_Learnings (
	Subject_Id integer NOT NULL REFERENCES Subjects ON DELETE RESTRICT ON UPDATE CASCADE,
	Student_Id integer NOT NULL REFERENCES Students ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE (Subject_Id, Student_Id)
);


