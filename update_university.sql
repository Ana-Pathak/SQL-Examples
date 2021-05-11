/* Delete the tables if they already exist */
DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;


DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS prerequisite CASCADE;
DROP TABLE IF EXISTS section CASCADE; 
DROP TABLE IF EXISTS course CASCADE;


CREATE TABLE student (
	name 	  	VARCHAR(50) NOT NULL,
	student_number  CHAR(9) NOT NULL,
	class_year 	CHAR(4),
	major		VARCHAR(20),
	PRIMARY KEY (student_number)
);

CREATE TABLE course (
	course_name 	VARCHAR(50) NOT NULL,
	course_number	INT(4) NOT NULL,
	credit_hours	INT(2),
	department	VARCHAR(40) NOT NULL,
	PRIMARY KEY (course_number)
--     CONSTRAINT course_number_limit  CHECK (course_number > 1000 AND course_number < 6999)
);


CREATE TABLE prerequisite (
    course_number INT(4) NOT NULL,
    prerequisite_number INT(4),
    PRIMARY KEY (course_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number)
);


INSERT INTO course VALUE ('Databases and SQL', 2215, 3, 'Computer Science');
INSERT INTO course VALUE ('Intro to C Programming', 1110, 3, 'Computer Science');
INSERT INTO course VALUE ('Data Structures and Algorithms', 2226, 3, 'Computer Science');

INSERT INTO course (course_name, course_number, department) 
VALUE ('Computer Organization Lab', 3331, 'Computer Science');


CREATE TABLE section (
    section_identifier INT(2) NOT NULL,
    course_number INT(4) NOT NULL,
    semester VARCHAR(10),
    year INT(4),
    instructor VARCHAR(50),
    PRIMARY KEY (section_identifier,course_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number)
);

INSERT INTO section (section_identifier, course_number, semester, year)
SELECT 1, course_number, 'Fall', 2019 FROM course; 

INSERT INTO section VALUE (2, 1110, 'Fall', 2019, NULL);

DELETE FROM section WHERE course_number = 1110;

UPDATE section SET instructor = 'Sara Riazi' 
WHERE course_number = 2215;

ALTER TABLE section
ADD days CHAR(3); 

ALTER TABLE section
ADD fee INT(4)
DEFAULT 240;

ALTER TABLE section
DROP fee;

-------------------------------------------------------------------------------------------------------------------------------

/**QUESTION 1: **/
drop table if exists grade_report;

/**1: **/
INSERT INTO student VALUE ('Ana Pathak', 4444, 2023, 'Computer Science');
INSERT INTO student VALUE ('Jade Little', 2200, 2021, 'Computer Engineering');
INSERT INTO student VALUE ('Kevin Cheng', 1111, 2024, 'Computer Science');
/**2: **/
CREATE TABLE grade_report (
	student_number CHAR(9) not Null,
    section_identifier INT(2) Not Null,
    course_number INT(4) Not Null,
    grade decimal(5,2),
    PRIMARY KEY(student_number, section_identifier, course_number),
    foreign key (course_number)  references course(course_number),
    foreign key (student_number)  references student(student_number),
	foreign key (section_identifier)  references section(section_identifier));
/**3: **/
INSERT INTO grade_report VALUES (4444, 1, 2215, NULL);
/**4: **/
UPDATE grade_report SET grade = 80 
	WHERE student_number = 4444
	AND course_number = 2215;
/**5: **/
ALTER TABLE section
	ADD location VARCHAR(50);
/**6: **/
UPDATE section SET location = 'BCKM 208'
	WHERE section_identifier = 1
	AND course_number = 2215;
/**7: **/
ALTER TABLE section
	DROP location;
/**8: **/
DELETE FROM grade_report WHERE course_number = 2215;
/**9: **/
DROP TABLE  grade_report;
/**10: **/
DELETE FROM student WHERE student_number = 1111;
DELETE FROM student	WHERE student_number = 2200;
DELETE FROM student	WHERE student_number = 4444;