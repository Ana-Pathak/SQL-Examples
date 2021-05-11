CREATE DATABASE IF NOT EXISTS hospital;
SET foreign_key_checks = 0;
drop table if exists PATIENT;
drop table if exists HEALTH_RECORDS;
drop table if exists INVOICE;
drop table if exists MEDICINE;
drop table if exists NURSE;
drop table if exists INSTRUCTIONS;
drop table if exists PHYSICIAN;
drop table if exists ROOMS;
drop table if exists GIVES;
drop table if exists ORDERS;
drop table if exists ISEXECUTED;
drop table if exists ISMONITORED;
drop table if exists PAYABLE;
drop view if exists patient_info;
drop view if exists physician_info;
drop view if exists nurse_info;
drop procedure if exists insert_meds;
drop trigger if exists patient_meds;
SET foreign_key_checks = 1;

CREATE TABLE IF NOT EXISTS ROOMS(
	capacity int(2),
    payable_id INT(4),
    number INT(4),
    PRIMARY KEY(number)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS PATIENT(
	name VARCHAR(50),
    address VARCHAR(200),
    unique_idP INT(4),
    phone_number VARCHAR(20),
    r_number int(4),
    PRIMARY KEY(unique_idP)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS HEALTH_RECORDS(
	unique_idH INT(4),
    status VARCHAR(20),
    description VARCHAR(200),
    disease VARCHAR(150),
    date DATETIME,
    unique_idP INT(4),
    PRIMARY KEY(unique_idH, unique_idP)
);

CREATE TABLE IF NOT EXISTS INVOICE(
	amount_to_be_payed INT(20),
    invoice_id INT(4),
    date_issued DATE,
    unique_idP INT(4),
    PRIMARY KEY(invoice_id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS MEDICINE(
	pharmacy_meds VARCHAR(200),
    prescription VARCHAR(100),
    PRIMARY KEY(prescription)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS NURSE(
	address VARCHAR(200),
    certification_no INT(10),
    phone_number VARCHAR(20),
    name VARCHAR(50),
    unique_idN INT(4),
    PRIMARY KEY(unique_idN)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS INSTRUCTIONS(
	description VARCHAR(200),
    payable_id INT(4),
    unique_idI INT(4),
    PRIMARY KEY(unique_idI)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS PHYSICIAN(
	address VARCHAR(200),
    certification_no INT(10),
    phone_number VARCHAR(20),
    name VARCHAR(50),
    field VARCHAR(50),
    unique_id INT(4),
    PRIMARY KEY(unique_id)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS GIVES(
	 prescription VARCHAR(200),
     unique_idN INT(4),
     unique_idI INT(4),
     specific_amount VARCHAR(200),
     unique_idP INT(20),
	 PRIMARY KEY(prescription, unique_idN, unique_idI)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ORDERS(
	date DATETIME,
	unique_idI INT(4),
    unique_id INT(4),
    unique_idP INT(4),
	PRIMARY KEY(unique_idI, unique_id, unique_idP)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ISEXECUTED(
	dates DATETIME,
    results VARCHAR(10),
    unique_id INT(4),
    unique_idN INT(4),
    unique_idI INT(4),
    PRIMARY KEY(unique_id, unique_idN, unique_idI)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ISMONITORED(
	duration INT(10),
    unique_id INT(4),
    unique_idP INT(4),
    PRIMARY KEY(unique_id, unique_idP)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS PAYABLE(
	fees INT(10),
    payable_id INT(4),
    invoice_id INT(4),
    PRIMARY KEY(payable_id)
)ENGINE = InnoDB;

/*FOREIGN KEY*/
alter table ROOMS add FOREIGN KEY (payable_id) REFERENCES PAYABLE (payable_id);
 
alter table PATIENT add FOREIGN KEY (r_number) REFERENCES ROOMS (number);
 
alter table HEALTH_RECORDS add FOREIGN KEY (unique_idP) REFERENCES PATIENT (unique_idP);
  
alter table INVOICE add FOREIGN KEY (unique_idP) REFERENCES PATIENT (unique_idP);
 
alter table INSTRUCTIONS add FOREIGN KEY (payable_id) REFERENCES PAYABLE (payable_id);
 
alter table GIVES add FOREIGN KEY (prescription) REFERENCES MEDICINE (prescription);
alter table GIVES add FOREIGN KEY (unique_idN) REFERENCES NURSE (unique_idN);
alter table GIVES add FOREIGN KEY (unique_idI) REFERENCES INSTRUCTIONS (unique_idI);
alter table GIVES add FOREIGN KEY (unique_idP) REFERENCES PATIENT (unique_idP);

alter table ORDERS add FOREIGN KEY (unique_idI) REFERENCES INSTRUCTIONS (unique_idI);
alter table ORDERS add FOREIGN KEY (unique_id) REFERENCES PHYSICIAN (unique_id);
alter table ORDERS add FOREIGN KEY (unique_idP) REFERENCES PATIENT (unique_idP);
 
alter table ISEXECUTED add FOREIGN KEY (unique_id) REFERENCES PHYSICIAN (unique_id);
alter table ISEXECUTED add FOREIGN KEY (unique_idN) REFERENCES NURSE (unique_idN);
alter table ISEXECUTED add FOREIGN KEY (unique_id) REFERENCES PHYSICIAN (unique_id);
alter table ISEXECUTED add FOREIGN KEY (unique_idI) REFERENCES INSTRUCTIONS (unique_idI);
 
alter table ISMONITORED add FOREIGN KEY (unique_id) REFERENCES PHYSICIAN (unique_id);
alter table ISMONITORED add FOREIGN KEY(unique_idP) REFERENCES PATIENT (unique_idP);

alter table PAYABLE add FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id);

/**Insert into medicine: **/
INSERT INTO MEDICINE VALUES(' xyz','Prescription1');
INSERT INTO MEDICINE VALUES(' lno','Prescription2');
INSERT INTO MEDICINE VALUES('abc', 'Prescription3');
INSERT INTO MEDICINE VALUES( 'x','Prescription4');
INSERT INTO MEDICINE VALUES('anmxc','Prescription5');

/**Insert into nurse: **/
INSERT INTO NURSE VALUES('1234 home home, 20908, NC', 9089010, '880-780-9845', 'Joceyln Kung', 9908);
INSERT INTO NURSE VALUES('2340 street home, 20978, TN', 89694020, '705-886-3453', 'Sage McCaffery', 8870);
INSERT INTO NURSE VALUES('7890 name of street, 10978, SC', 86222201, '704-990-8790', 'Andrew Scales', 4567);
INSERT INTO NURSE VALUES('8097 street name, 32018, FL', 0090867, '980-345-6790', 'Sasha Fray', 1290);
INSERT INTO NURSE VALUES('2000 home, 34090, AZ', 74110234, '704-3456-1221', 'Ryan Lucas', 9876);

/**Insert into physicians: **/
INSERT INTO PHYSICIAN VALUES('1234 home street 28078, SC', 901030, '980-765-5698', 'Raymond Hughes', 'neurosurgeon', 9876);
INSERT INTO PHYSICIAN VALUES('2245 home street2 29998, TX', 99990, '980-777-5998', 'Elijah King', 'Dermatologist', 1116);
INSERT INTO PHYSICIAN VALUES('1980 home street3 22231, AK', 188345, '704-7789-0001', 'Robert Singh', 'Pediatrican', 4431);
INSERT INTO PHYSICIAN VALUES('0001 home street3 29998, NJ', 15820, '704-997-8657', 'Raj Patel', 'Anesthesiology', 9987);
INSERT INTO PHYSICIAN VALUES('6555 home street4 20088, OH', 15776, '704-907-8050', 'Susan Mallery', 'Ophthalmology', 5541);


/*Insert into rooms: */
INSERT INTO ROOMS VALUES(2, null, 1212);
INSERT INTO ROOMS VALUES(2, null, 2188);
INSERT INTO ROOMS VALUES(4, null, 1414);
INSERT INTO ROOMS VALUES(3, null, 9908);
INSERT INTO ROOMS VALUES(5, null, 1209);

/*insert into patient: */
INSERT INTO PATIENT VALUES('Kelly hayes', '1234 home street 28078, SC', 1212, '705-668-9807',1212);
INSERT INTO PATIENT VALUES('Corey Anderson', '9809 random street 28090, NC', 3012, '980-789-6605',2188);
INSERT INTO PATIENT VALUES('Jayden Wright', '7807 street name 90078, AZ', 5409, '985-608-1807',1212);
INSERT INTO PATIENT VALUES('Matilda stone', '4590 street 29999, NC', 1002, '905-699-9907',9908);
INSERT INTO PATIENT VALUES('Leigh Anne', '9990 street street 20018, TN', 1440, '908-049-9807',1209);

/**insert into invoice: **/
INSERT INTO INVOICE VALUES('10000', '4400', '2021-02-01', 1212 );
INSERT INTO INVOICE VALUES('90000', '4340', '2021-06-01',3012 );
INSERT INTO INVOICE VALUES('0', '9089', '2019-04-04', 5409);
INSERT INTO INVOICE VALUES('8000', '9800', '2021-03-22', 1002);
INSERT INTO INVOICE VALUES('10000', '4000', '2021-04-22', 1440);

/**Insert into payable: **/
INSERT INTO PAYABLE VALUES('80000',1234, 4400);
INSERT INTO PAYABLE VALUES('834',4321, 4340);
INSERT INTO PAYABLE VALUES('9076',3214, 9089);
INSERT INTO PAYABLE VALUES('77654',2341, 9800);
INSERT INTO PAYABLE VALUES('2312',4123, 4000);

/**insert into health_record: **/
INSERT INTO HEALTH_RECORDS VALUES(1212, 'observation', 'Kelly Hayes is currently under observation as of 2021', 'brain tumor', '2021-01-01', 1212);
INSERT INTO HEALTH_RECORDS VALUES(3012, 'in surgery', 'Corey Anderson is currently in surgey as of 2021', 'kidney transplant', '2021-05-01', 3012 );
INSERT INTO HEALTH_RECORDS VALUES(5409, 'fully trated', 'Jayden Wright is fully reated of of 2019', 'Coronary artery disease','2019-03-04', 5409);
INSERT INTO HEALTH_RECORDS VALUES(1002, 'observation', 'Matilda Stone id under ibservation as if 2021', 'Cardia arrest', '2021-02-22',1002);
INSERT INTO HEALTH_RECORDS VALUES(1440, 'critical', 'Leigh Anne is in critical condition as of 2021', 'brain tumor', '2021-03-22',1440 );


/**Insert into instructions: **/
INSERT INTO INSTRUCTIONS VALUES('Give medication on time to patient', 1234, 0001);
INSERT INTO INSTRUCTIONS VALUES('Give meds before eating to patient', 4123, 1908);
INSERT INTO INSTRUCTIONS VALUES('Give meds after eating to patient', 4321, 8760);
INSERT INTO INSTRUCTIONS VALUES('weekly check ups for patient', 3214, 2345);
INSERT INTO INSTRUCTIONS VALUES('Rewrap dressing on patient', 2341, 1233);

/**Insert into gives: **/
INSERT INTO GIVES VALUES('Prescription1',9908, 0001, '300 mg', 1212);
INSERT INTO GIVES VALUES('Prescription2',8870,1908, '500 mg', 3012);
INSERT INTO GIVES VALUES('Prescription3',4567,8760, '20 tablets', 5409);
INSERT INTO GIVES VALUES('Prescription4',1290,2345, '15 tablets', 1002);
INSERT INTO GIVES VALUES('Prescription5',9876,1233, '75 mg',1440);

/**Insert into orders: **/
INSERT INTO ORDERS VALUES('2021-01-21',0001,9876,1212);
INSERT INTO ORDERS VALUES('2021-02-22',1908,1116,3012);
INSERT INTO ORDERS VALUES('2021-03-10',8760,4431,5409);
INSERT INTO ORDERS VALUES('2021-03-21',2345,9987,1002);
INSERT INTO ORDERS VALUES('2021-04-17',1233,5541,1440);

/**Insert into isExecuted: **/
INSERT INTO ISEXECUTED VALUES('2021-03-21', 'good', 9876, 9908, 0001);
INSERT INTO ISEXECUTED VALUES('2021-04-11', 'good', 1116, 8870, 1908);
INSERT INTO ISEXECUTED VALUES('2021-05-08', 'good', 4431, 4567, 8760);
INSERT INTO ISEXECUTED VALUES('2021-06-05', 'good', 9987, 1290, 2345);
INSERT INTO ISEXECUTED VALUES('2021-07-02', 'good', 5541, 9876, 1233);

/**Insert into isMonitored: **/
INSERT INTO ISMONITORED VALUES(50, 9876, 1212);
INSERT INTO ISMONITORED VALUES(90, 1116, 3012);
INSERT INTO ISMONITORED VALUES(150, 4431, 5409);
INSERT INTO ISMONITORED VALUES(500, 9987, 1002);
INSERT INTO ISMONITORED VALUES(90, 5541, 1440);

UPDATE rooms SET payable_id = 1234 WHERE rooms.number = 1212;
UPDATE rooms SET payable_id = 4321 WHERE rooms.number = 2188;
UPDATE rooms SET payable_id = 3214 WHERE rooms.number = 1414;
UPDATE rooms SET payable_id = 2341 WHERE rooms.number = 9908;
UPDATE rooms SET payable_id = 4123 WHERE rooms.number = 1209;

/**Join query 1: **/
SELECT name, address, r_number AS 'Room', capacity
	FROM PATIENT JOIN ROOMS
    ON r_number = number;
    
/**Join query 2: **/
SELECT status, HEALTH_records.unique_idP AS 'ID', name
	FROM HEALTH_RECORDS JOIN PATIENT
	ON HEALTH_RECORDS.unique_idP = PATIENT.unique_idP;
    
/**Join query 3: **/
SELECT count(ismonitored.unique_idP), physician.name
	FROM ismonitored JOIN physician ON
	ismonitored.unique_id = physician.unique_id
           GROUP BY physician.unique_id;

/**Join query 4: **/
SELECT  patient.name, health_records.disease, health_records.description, health_records.status
	FROM patient JOIN health_records ON
	patient.unique_idP = health_records.unique_idP
    where health_records.status = 'observation'
    GROUP BY health_records.unique_idP;

/**Aggregate Function #1: **/
SELECT COUNT(*) , name
	FROM PATIENT
    GROUP BY NAME;
    
/**Aggregate Function #2: **/
SELECT SUM(amount_to_be_payed),name
	FROM INVOICE JOIN PATIENT ON
    INVOICE.unique_idP = PATIENT.unique_idP
    GROUP BY name;
    
/**Aggregation query 3: **/
SELECT sum(duration), physician.name
	FROM ismonitored JOIN physician ON
	ismonitored.unique_id = physician.unique_id
  	GROUP BY physician.unique_id;

/**Aggregation query 4: **/
SELECT count(physician.field), field
			FROM physician
    			GROUP BY physician.field;

/**Nested Query #1 : **/
SELECT DISTINCT name, unique_idP AS 'ID', phone_number
	FROM PATIENT
	WHERE EXISTS
		(SELECT amount_to_be_payed
			FROM INVOICE
			WHERE amount_to_be_payed >= 10000 AND PATIENT.unique_idP = INVOICE.unique_idP );

/**Nested Query #2: **/
SELECT DISTINCT name, unique_idP AS 'ID'
	FROM PATIENT
	WHERE EXISTS
		(SELECT date_issued
			FROM INVOICE
			WHERE amount_to_be_payed = 0 AND PATIENT.unique_idP = INVOICE.unique_idP );

/**Nested Query 3: **/
SELECT DISTINCT patient.name, orders.date AS 'date order given'
	FROM patient join orders on patient.unique_idP = orders.unique_idP
	WHERE EXISTS
		(select patient.name
            from patient 
            WHERE patient.unique_idP = orders.unique_idP
            AND patient.name = 'Kelly hayes');

/**VIEW 1: **/
CREATE VIEW patient_info AS
	SELECT pat.name, pat.phone_number, pat.address
    FROM PATIENT AS pat;

/**VIEW 2: **/
CREATE VIEW physician_info AS
	SELECT p.name, p.phone_number, p.address, p.certification_no
    FROM PHYSICIAN AS p;
    
/**VIEW 3: **/
CREATE VIEW nurse_info AS
	SELECT n.name, n.phone_number, n.address, n.certification_no
    FROM NURSE AS n;
    
/** PRESCRIPTION QUERY: **/
SELECT prescription, specific_amount, patient.name
	FROM GIVES, PATIENT
    WHERE GIVES.unique_idP = PATIENT.unique_idP
    ORDER BY name;

/**PATIENT RESULT QUERY: **/
SELECT ismonitored.duration,isexecuted.results, patient.name
	FROM ismonitored, isexecuted, patient
    WHERE ismonitored.unique_id = isexecuted.unique_id
    AND ismonitored.unique_idP = patient.unique_idP
    ORDER BY name ASC;
    
/**prescription data based on patient name and nurse name **/
SELECT nurse.name AS 'nurse name', gives.prescription, patient.name AS 'patient name'
	FROM nurse, gives, patient
    where nurse.unique_idN = gives.unique_idN
    and patient.unique_idP = gives.unique_idP
    GROUP BY nurse.name;
    
/**Physician info from all fields: **/
select name, phone_number, address, field
	from physician
	group by unique_id;
    
/**Transaction 1: **/
SET autocommit = 0;
START TRANSACTION;
	INSERT INTO MEDICINE VALUES('AAA','Prescription9');
COMMIT;

/**Transaction 2: **/
DELIMITER //
CREATE PROCEDURE insert_meds()
BEGIN
DECLARE rollback_ BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
    SET @rollback_ = 1;
END;
SET autocommit = 0;
START TRANSACTION;
	DELETE FROM MEDICINE WHERE prescription = 'AAA';
	INSERT INTO MEDICINE VALUES('LBSC','Prescription10');
IF @rollback_ THEN
ROLLBACK;
ELSE 
COMMIT;
END IF;
END// 
DELIMITER ;

/**Transaction 3: **/
SET autocommit = 0;
START TRANSACTION;
	SELECT patient.name, patient.r_number, health_records.status
    FROM patient JOIN health_records WHERE
	patient.unique_idP = health_records.unique_idP;
    DELETE FROM health_records WHERE health_records.status = 'fully trated'; 
COMMIT;

/**Transaction 4: **/
SET autocommit = 0;
START TRANSACTION;
	SELECT orders.date, instructions.description
    FROM orders JOIN instructions WHERE
	orders.unique_idI = instructions.unique_idI;
    UPDATE instructions SET  description = 'Provide IV' WHERE instructions.unique_idI = '0001';
COMMIT;

/**Trigger 1: **/
DELIMITER // 
    CREATE TRIGGER roomsize 
    AFTER INSERT ON patient
    FOR EACH ROW
BEGIN
    UPDATE rooms SET capacity = capacity - 1 
    WHERE rooms.number = NEW.r_number;
END;

/**Trigger 2: **/
DELIMITER // 
    CREATE TRIGGER health_record_Trig 
    before INSERT ON physician
    FOR EACH ROW
		if new.field is null then
		set new.field = "General Practice";
    end if;

/**Trigger 3: **/
DELIMITER // 
    CREATE TRIGGER nurse_record_Trig 
    before INSERT ON nurse
    FOR EACH ROW
		if new.address is null then
		set new.address = "Needs to see HR";
    end if;
