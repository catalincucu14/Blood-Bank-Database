-- HOSPITAL
CREATE TABLE hospital (
    id      NUMBER(2) NOT NULL,
    name    VARCHAR2(75) NOT NULL,
    city    VARCHAR2(25) NOT NULL,
    address VARCHAR2(75) NOT NULL
);

ALTER TABLE hospital
  ADD CONSTRAINT hospital_pk PRIMARY KEY ( id );

ALTER TABLE hospital
  ADD CONSTRAINT hospital_name_ck CHECK ( length(name) > 3 );

ALTER TABLE hospital
  ADD CONSTRAINT hospital_city_ck CHECK ( length(city) > 3 );

ALTER TABLE hospital
  ADD CONSTRAINT hospital_address_ck CHECK ( length(address) > 3 );

-- STOCK
CREATE TABLE stock (
    id          NUMBER(4) NOT NULL,
    hospital_id NUMBER(2) NOT NULL,
    quantity    NUMBER(20) NOT NULL,
    blood_group CHAR(2) NOT NULL,
    blood_rh    CHAR(1) NOT NULL
);

ALTER TABLE stock
  ADD CONSTRAINT stock_hospital_fk FOREIGN KEY ( hospital_id ) REFERENCES hospital ( id );

ALTER TABLE stock
	ADD CONSTRAINT stock_pk PRIMARY KEY ( id );

ALTER TABLE stock
    ADD CONSTRAINT stock_bl_gr_rh_hospital_id_un UNIQUE ( blood_group, blood_rh, hospital_id );

ALTER TABLE stock
    ADD CONSTRAINT stock_blood_group_ck CHECK ( blood_group IN ( 'A', 'AB', 'B', 'O' ) );

ALTER TABLE stock
    ADD CONSTRAINT stock_blood_rh_ck CHECK ( blood_rh IN ( '+', '-' ) );

-- DONOR
CREATE TABLE donor (
    id         NUMBER(10) NOT NULL,
    first_name VARCHAR2(50) NOT NULL,
    last_name  VARCHAR2(25) NOT NULL
);

ALTER TABLE donor
  ADD CONSTRAINT donor_pk PRIMARY KEY ( id );

ALTER TABLE donor
  ADD CONSTRAINT donor_first_name_last_name_un UNIQUE ( first_name, last_name );

ALTER TABLE donor
  ADD CONSTRAINT donor_first_name_ck CHECK ( length(first_name) > 3 );

ALTER TABLE donor
  ADD CONSTRAINT donor_last_name_ck CHECK ( length(last_name) > 2 );

-- PERSONAL_DATA
CREATE TABLE personal_data (
    donor_id  NUMBER(10) NOT NULL,
    cnp       VARCHAR2(13) NOT NULL,
    series_id CHAR(2) NOT NULL,
    number_id VARCHAR2(6) NOT NULL,
    city      VARCHAR2(25) NOT NULL,
    address   VARCHAR2(75) NOT NULL,
    phone     VARCHAR2(10) NOT NULL,
    mail      VARCHAR2(50)
);

ALTER TABLE personal_data
  ADD CONSTRAINT personal_data_donor_fk FOREIGN KEY ( donor_id ) REFERENCES donor ( id );

ALTER TABLE personal_data
	ADD CONSTRAINT personal_data_mail_un UNIQUE ( mail );

ALTER TABLE personal_data
	ADD CONSTRAINT personal_data_phone_un UNIQUE ( phone );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_sr_no_id_un UNIQUE ( series_id, number_id );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_cnp_ck CHECK ( length(cnp) = 13 );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_series_id_ck CHECK ( REGEXP_LIKE ( series_id, '[a-zA-Z][a-zA-Z]' ) );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_number_id_ck CHECK ( REGEXP_LIKE ( number_id, '[0-9][0-9][0-9][0-9][0-9][0-9]' ) );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_city_ck CHECK ( length(city) > 3 );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_address_ck CHECK ( length(address) > 5 );

ALTER TABLE personal_data
    ADD CONSTRAINT personal_data_phone_ck CHECK ( REGEXP_LIKE ( phone, '07[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) );

CREATE UNIQUE INDEX personal_data__idx ON
    personal_data (
        donor_id
    ASC );

-- MEDICAL_DATA
CREATE TABLE medical_data (
    donor_id           NUMBER(10) NOT NULL,
    birth_date         DATE NOT NULL,
    blood_group        CHAR(2) NOT NULL,
    blood_rh           CHAR(1) NOT NULL,
    sex                CHAR(1) NOT NULL,
    weight             NUMBER(2) NOT NULL,
    height             NUMBER(3) NOT NULL,
    last_donation_date DATE
);

ALTER TABLE medical_data
  ADD CONSTRAINT medical_data_donor_fk FOREIGN KEY ( donor_id ) REFERENCES donor ( id );

ALTER TABLE medical_data
    ADD CONSTRAINT medical_data_blood_group_ck CHECK ( blood_group IN ( 'A', 'AB', 'B', 'O' ) );

ALTER TABLE medical_data
    ADD CONSTRAINT medical_data_blood_rh_ck CHECK ( blood_rh IN ( '+', '-' ) );

ALTER TABLE medical_data
    ADD CONSTRAINT medical_data_sex_ck CHECK ( sex IN ( 'F', 'M' ) );

ALTER TABLE medical_data
 ADD CONSTRAINT medical_data_weight_ck CHECK ( weight > 50 );

ALTER TABLE medical_data
  ADD CONSTRAINT medical_data_height_ck CHECK ( height > 150 );

CREATE UNIQUE INDEX medical_data__idx ON
    medical_data ( donor_id ASC );

-- DONATION
CREATE TABLE donation (
    id                 NUMBER(15) NOT NULL,
    donor_id           NUMBER(10) NOT NULL,
    donation_date      DATE NOT NULL,
    initial_quantity   NUMBER(3) NOT NULL,
    available_quantity NUMBER(3) 
);

ALTER TABLE donation
	ADD CONSTRAINT donation_pk PRIMARY KEY ( id );

ALTER TABLE donation
    ADD CONSTRAINT donation_donor_fk FOREIGN KEY ( donor_id ) REFERENCES donor ( id );

-- TRANSACTION
CREATE TABLE transaction (
    id               NUMBER(20) NOT NULL,
    stock_id         NUMBER(4) NOT NULL,
    donation_id      NUMBER(15) NOT NULL,
    transaction_date DATE NOT NULL,
    quantity         NUMBER(3) NOT NULL
);

ALTER TABLE transaction
    ADD CONSTRAINT transaction_pk PRIMARY KEY ( id );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_stock_fk FOREIGN KEY ( stock_id ) REFERENCES stock ( id );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_donation_fk FOREIGN KEY ( donation_id ) REFERENCES donation ( id );

-- AUTOINCREMENT HOSPITAL
CREATE SEQUENCE HOSPITAL_ID_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER HOSPITAL_ID_TRG
	BEFORE INSERT ON HOSPITAL
	FOR EACH ROW
	WHEN (NEW.ID IS NULL)
BEGIN
	:new.id := hospital_id_seq.nextval;
END;
/

-- AUTOINCREMENT STOCK
CREATE SEQUENCE STOCK_ID_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER STOCK_ID_TRG
	BEFORE INSERT ON STOCK
	FOR EACH ROW
	WHEN (NEW.ID IS NULL)
BEGIN
	:new.id := stock_id_seq.nextval;
END;
/

-- AUTOINCREMENT DONOR
CREATE SEQUENCE DONOR_ID_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER DONOR_ID_TRG
	BEFORE INSERT ON DONOR
	FOR EACH ROW
	WHEN (NEW.ID IS NULL)
BEGIN
	:new.id := donor_id_seq.nextval;
END;
/

-- AUTOINCREMENT DONATION
CREATE SEQUENCE DONATION_ID_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER DONATION_ID_TRG
	BEFORE INSERT ON DONATION
	FOR EACH ROW
	WHEN (NEW.ID IS NULL)
BEGIN
	:new.id := donation_id_seq.nextval;
END;
/

-- AUTOINCREMENT TRANSACTION
CREATE SEQUENCE TRANSACTION_ID_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER TRANSACTION_ID_TRG
    BEFORE INSERT ON TRANSACTION
    FOR EACH ROW
    WHEN (NEW.ID IS NULL)
BEGIN
    :new.id := transaction_id_seq.nextval;
end;
/
