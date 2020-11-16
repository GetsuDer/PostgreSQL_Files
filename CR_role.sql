REASSIGN OWNED BY test TO postgres;
DROP TABLE ue_test_create;
DROP VIEW Largest_Cities;
DROP VIEW Big_Directions;
REVOKE ALL ON TABLE Largest_Cities FROM test;
REVOKE ALL ON TABLE Big_Directions FROM database_user;
REVOKE ALL ON TABLE Learning_Directions FROM test;
REVOKE ALL ON TABLE Entrants FROM test;
REVOKE ALL ON TABLE Applications FROM test;
REVOKE ALL ON DATABASE "University_Entrences_test" FROM test; -- убрать права
DROP ROLE IF EXISTS test;
DROP ROLE IF EXISTS database_user;


CREATE USER test;

GRANT ALL ON DATABASE "University_Entrences_test" TO test;

GRANT SELECT, UPDATE, INSERT ON TABLE Learning_Directions TO test;
GRANT SELECT (exams, contact_data, entrant_id), 
	  UPDATE (exams, contact_data, entrant_id) ON TABLE Entrants TO test;
GRANT SELECT ON TABLE Applications TO test;

GRANT SELECT ON TABLE Largest_Cities TO test;

CREATE ROLE database_user;
GRANT SELECT (speciality_size), UPDATE (speciality_size) ON TABLE Big_Directions TO database_user;

GRANT database_user TO test; 