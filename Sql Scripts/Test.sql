---- TEST TRIGGERS
SET SERVEROUTPUT ON;
INSERT INTO donor(last_name, first_name) VALUES('Mironel', 'Mimi');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1781002223237', 'MZ', '422132', 'Iasi', 'str. Stefan cel Mare si Sfint nr. 10', '0715782521', donor_id_seq.currval);
-- FAIL, TOO YOUNG
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('02/10/2005', 'dd/mm/yyyy'), 'A', '+', 'M', '80', '179', donor_id_seq.currval);
-- FAIL, TOO OLD
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('02/10/1901', 'dd/mm/yyyy'), 'A', '+', 'M', '80', '179', donor_id_seq.currval);
-- FAIL, ALREADY DONATED
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('02/10/1999', 'dd/mm/yyyy'), 'A', '+', 'M', '80', '179', SYSDATE, donor_id_seq.currval);
INSERT INTO donation(donation_date, quantity, donor_id) VALUES(sysdate, 475, donor_id_seq.currval);

---- TEST PROCEDURE
SET SERVEROUTPUT ON;
-- FAIL, THE DONATION WASN'T DONATED AT THAT DATE
EXECUTE blood_bank_package.transfer_donation_by_id(SYSDATE - 10, 1 , 15);
-- SUCCESS
EXECUTE blood_bank_package.transfer_donation_by_id(SYSDATE + 2, 1 , 15);
-- FAIL, ALREADY TRANSFERRED
EXECUTE blood_bank_package.transfer_donation_by_id(SYSDATE + 2, 1 , 15);
-- FAIL, HOSPITAL ID IS INVALID
EXECUTE blood_bank_package.transfer_donation_by_id(SYSDATE, 1000, 3);
-- FAIL, DONATION ID IS INVALID
EXECUTE blood_bank_package.transfer_donation_by_id(SYSDATE, 3 , 1000);
-- SUCCESS
EXECUTE blood_bank_package.transfer_donations_by_quantity(SYSDATE, 2, 1, 'B', '+');
-- FAIL, STOCK IS INSUFFICIENT
EXECUTE blood_bank_package.transfer_donations_by_quantity(SYSDATE, 2, 10, 'A', '+');
-- FAILL, HOSPITAL ID IS INVALID
EXECUTE blood_bank_package.transfer_donations_by_quantity(SYSDATE, 1000, 2, 'O', '+');
-- SUCCESS
EXECUTE blood_bank_package.transfer_blood_by_quantity(SYSDATE, 2, 2050, 1, 'O', '-');
-- FAIL, STOCK IS INSUFFICIENT
EXECUTE blood_bank_package.transfer_blood_by_quantity(SYSDATE, 2, 10000, 'A', '+');
-- FAILL, HOSPITAL ID IS INVALID
EXECUTE blood_bank_package.transfer_blood_by_quantity(SYSDATE, 1000, 535, 'O', '+');
