BEGIN;

COPY Educational_Places FROM '/home/getsu/Data/Databases/task3/places_out' DELIMITER ';';

COPY Learning_Directions FROM '/home/getsu/Data/Databases/task3/dir_out' DELIMITER ';';

COPY Entrants FROM '/home/getsu/Data/Databases/task3/entrants_out' DELIMITER ';';

COPY Applications FROM '/home/getsu/Data/Databases/task3/applications_out' DELIMITER ';';
END;