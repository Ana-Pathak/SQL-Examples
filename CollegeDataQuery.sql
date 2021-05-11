/** Query 1: **/
SELECT MIN(GPA)
	FROM Student, Apply
	WHERE Student.sID = Apply.sID 
    AND major = 'CS';

/** Query 2: **/
SELECT MAX(GPA)
	FROM Student, Apply
	WHERE Student.sID = Apply.sID
    AND major = 'CS';

/** Query 3: **/
SELECT cName, major, MIN(GPA), MAX(GPA)
	FROM Student, Apply
	WHERE Student.sID = Apply.sID
	GROUP BY cName, major;

/** Query 4: **/
SELECT state, SUM(enrollment) AS 'Total enrollment'
	FROM College
	GROUP BY state;

/** Query 5: **/
(select avg(student.GPA) 
    from student
    where sID  in (SELECT distinct apply.sID FROM apply 
    WHERE apply.major = "CS"));

/** Query 6: **/    
SELECT ((select avg(student.GPA) 
    FROM student
    WHERE sID  IN (SELECT distinct apply.sID FROM apply 
    WHERE apply.major = "CS"))
    - (select avg(student.GPA)
    from student
    where sID not in (SELECT distinct apply.sID FROM apply 
    WHERE apply.major = "CS")))as "dif";
        
/** Query 7: **/
SELECT COUNT( * ) AS  'Number of rows' 
	FROM student;
    
/** Query 8: **/
SELECT COUNT(DISTINCT sID) AS 'No.of distinct students'
	FROM Apply
	WHERE cName = 'Cornell';

/** Query 9a: **/
SELECT Student.sID, COUNT(DISTINCT cName) AS 'No.of colleges applied to'
	FROM Student, Apply
	WHERE Student.sID = Apply.sID
	GROUP BY Student.sID;

/**Query 9b: **/
SELECT Student.sID, Student.sName,COUNT(DISTINCT cName) AS 'No.of colleges applied to'
	FROM Student, Apply
	WHERE Student.sID = Apply.sID
	GROUP BY Student.sID;
    
/**Query 10: **/
SELECT cName
	FROM Apply
	GROUP BY cName
	HAVING COUNT(*) < 5;
    
/**A: **/
SELECT * FROM Student;
      Insert into Student values (432, 'Kevin', null, 1500);
      Insert into Student values (321, 'Lori', null, 2500);
      SELECT * FROM Student;
      
/**B: **/
 SELECT count(*)
       FROM Student;
       
/**C: **/
       SELECT count(GPA)
       FROM Student;
       
/**D:  **/
SET SQL_SAFE_UPDATES = 0;
       DELETE FROM Student WHERE GPA is null;


