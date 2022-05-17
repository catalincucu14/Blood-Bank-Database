-- DROP TABLES
DROP TABLE hospital CASCADE CONSTRAINTS PURGE;
DROP TABLE stock CASCADE CONSTRAINTS PURGE;
DROP TABLE donor CASCADE CONSTRAINTS PURGE;
DROP TABLE personal_data CASCADE CONSTRAINTS PURGE;
DROP TABLE medical_data CASCADE CONSTRAINTS PURGE;
DROP TABLE donation CASCADE CONSTRAINTS PURGE;
DROP TABLE transaction CASCADE CONSTRAINTS PURGE;

-- DROP AUTOINCREMENTS
DROP SEQUENCE hospital_id_seq;
DROP SEQUENCE stock_id_seq;
DROP SEQUENCE donor_id_seq;
DROP SEQUENCE donation_id_seq;
DROP SEQUENCE transaction_id_seq;
