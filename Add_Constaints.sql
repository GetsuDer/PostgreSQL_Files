ALTER TABLE Educational_Places ADD PRIMARY KEY (Educational_Place_Id);
ALTER TABLE Educational_Places ALTER COLUMN City SET NOT NULL;
ALTER TABLE Educational_Places ALTER COLUMN Place_Name SET NOT NULL;

ALTER TABLE Entrants ADD PRIMARY KEY (Entrant_Id);

ALTER TABLE Learning_Directions ADD PRIMARY KEY (Direction_Id);
ALTER TABLE Learning_Directions ALTER COLUMN Speciality_Name SET NOT NULL;
ALTER TABLE Learning_Directions ALTER COLUMN Duration SET NOT NULL;
ALTER TABLE Learning_Directions ADD CONSTRAINT St_num CHECK(Student_Number > 0);
ALTER TABLE Learning_Directions 
	ADD CONSTRAINT FK1 FOREIGN KEY (Place_Id)
	REFERENCES Educational_Places ON DELETE RESTRICT ON UPDATE CASCADE;


ALTER TABLE Applications ADD PRIMARY KEY (Application_Id);
ALTER TABLE Applications
	ADD CONSTRAINT FK2 FOREIGN KEY (Entrant_Id)
	REFERENCES Entrants ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Applications
	ADD CONSTRAINT FK3 FOREIGN KEY (Direction_Id)
	REFERENCES Learning_Directions ON DELETE RESTRICT ON UPDATE CASCADE;