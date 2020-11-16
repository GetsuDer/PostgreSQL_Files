DROP VIEW IF EXISTS Big_Directions;
DROP VIEW IF EXISTS Largest_Cities;

CREATE VIEW Big_Directions AS
SELECT direction_id, place_city, exams_needed, speciality_size
FROM Learning_Directions
WHERE speciality_size > 250
WITH CHECK OPTION;

CREATE VIEW Largest_Cities AS
SELECT place_city, count(*)
FROM Learning_Directions
GROUP BY place_city
ORDER BY count(*) DESC;