-- SELECT HOSPITALS
SELECT H.id AS "ID", H.name AS "HOSPITAL", H.city || ', ' || H.address AS "address" FROM hospital H;

-- SELECT THE STOCK (BLOOD QUANTITY, NOT NUMBER OF DONATIONS) FOR EVERY HOSPITAL
WITH
    o_plus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'O' AND S.blood_rh = '+'),
    o_minus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'O' AND S.blood_rh = '-'),
    a_plus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'A' AND S.blood_rh = '+'),
    a_minus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'A' AND S.blood_rh = '-'),
    b_plus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'B' AND S.blood_rh = '+'),
    b_minus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'B' AND S.blood_rh = '-'),
    ab_plus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'AB' AND S.blood_rh = '+'),
    ab_minus AS (SELECT S.quantity, S.hospital_id FROM stock S WHERE S.blood_group = 'AB' AND S.blood_rh = '-')
SELECT
    S.id AS "ID",
    S.name AS "HOSPITAL",
    OP.quantity AS "O+",
    OM.quantity AS "O-",
    AP.quantity AS "A+",
    AM.quantity AS "A-",
    BP.quantity AS "B+",
    BM.quantity AS "B-",
    ABP.quantity AS "AB+",
    ABM.quantity AS "AB-"
FROM hospital S
    FULL JOIN o_plus OP ON OP.hospital_id = S.id
    FULL JOIN o_minus OM ON OM.hospital_id = S.id
    FULL JOIN a_plus AP ON AP.hospital_id = S.id
    FULL JOIN a_minus AM ON AM.hospital_id = S.id
    FULL JOIN b_plus BP ON BP.hospital_id = S.id
    FULL JOIN b_minus BM ON BM.hospital_id = S.id
    FULL JOIN ab_plus ABP ON ABP.hospital_id = S.id
    FULL JOIN ab_minus ABM ON ABM.hospital_id = S.id;

-- SELECT ALL DONATIONS WITH THE NAME OF THE DONOR
SELECT D.id AS "ID", TO_CHAR(D.donation_date, 'dd/mm/yyyy') AS "DONATION DATE", D.available_quantity AS "AVAILABLE BLOOD QUANTITY", TO_CHAR(MD.birth_date, 'dd/mm/yyyy') AS "BIRTH_DATE", MD.blood_group || MD.blood_rh AS "BLOOD TYPE", DN.last_name || ' ' || DN.first_name AS "NAME" FROM donation D, donor DN, medical_data MD
    WHERE D.donor_id = DN.id AND MD.donor_id = DN.id;

-- SELECT AVAILABLE DONATIONS WITH THE NAME OF THE DONOR
SELECT D.id AS "ID", TO_CHAR(D.donation_date, 'dd/mm/yyyy') AS "DONATION DATE", D.available_quantity AS "BLOOD QUANTITY", TO_CHAR(MD.birth_date, 'dd/mm/yyyy') AS "BIRTH_DATE", MD.blood_group || MD.blood_rh AS "BLOOD TYPE", DN.last_name || ' ' || DN.first_name AS "NAME" FROM donation D, donor DN, medical_data MD
    WHERE D.donor_id = DN.id AND MD.donor_id = DN.id AND D.available_quantity != 0;

-- SELECT THE NUMBER OF DONATIONS THAT HAVEN'T BEEN TOUCHED
WITH
    o_plus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'O' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    o_minus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'O' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    a_plus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'A' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    a_minus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'A' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    b_plus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'B' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    b_minus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'B' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    ab_plus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'AB' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)),
    ab_minus AS (SELECT count(*) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'AB' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id AND D.id NOT IN
            (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id))
SELECT
    o_plus.counter AS "O+",
    o_minus.counter AS "O-",
    a_plus.counter AS "A+",
    a_minus.counter AS "A-",
    b_plus.counter AS "B+",
    b_minus.counter AS "B-",
    ab_plus.counter AS "AB+",
    ab_minus.counter AS "AB-"
FROM o_plus, o_minus, a_plus, a_minus, b_plus, b_minus, ab_plus, ab_minus;

-- SELECT THE QUANTITY OF BLOOD
WITH
    o_plus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'O' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id),
    o_minus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'O' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id),
    a_plus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'A' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id),
    a_minus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'A' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id),
    b_plus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'B' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id),
    b_minus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'B' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id),
    ab_plus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'AB' AND MD.blood_rh = '+' AND D.donor_id = MD.donor_id),
    ab_minus AS (SELECT SUM(available_quantity) AS counter FROM donation D, medical_data MD
        WHERE MD.blood_group = 'AB' AND MD.blood_rh = '-' AND D.donor_id = MD.donor_id)
SELECT
    o_plus.counter AS "O+",
    o_minus.counter AS "O-",
    a_plus.counter AS "A+",
    a_minus.counter AS "A-",
    b_plus.counter AS "B+",
    b_minus.counter AS "B-",
    ab_plus.counter AS "AB+",
    ab_minus.counter AS "AB-"
FROM o_plus, o_minus, a_plus, a_minus, b_plus, b_minus, ab_plus, ab_minus;

-- SELECT DONORS WITH PERSONAL DATA
SELECT DN.id AS "ID", DN.last_name || ' ' || DN.first_name AS "NAME", PD.CNP AS "CNP", PD.series_id || PD.number_id AS "SERIES", PD.city || ', ' || PD.address AS "ADDRESS", PD.phone AS "phone NUMBER" FROM donor DN, personal_data PD
    WHERE DN.id = PD.donor_id;

-- SELECT DONORS WITH MEDICAL DATA
SELECT DN.id AS "ID", TO_CHAR(DN.birth_date, 'dd/mm/yyyy') AS "BIRTH_DATE", DN.last_name || ' ' || DN.first_name AS "NAME", MD.blood_group || MD.blood_rh AS "BLOOD TYPE", MD.sex AS "SEX", MD.weight || 'kg' AS weight, MD.height/100 || 'm' AS height FROM donor DN, medical_data MD
    WHERE DN.id = MD.donor_id;

-- SELECT EVERY DONOR THAT DONATED TODAY
SELECT DN.last_name || ' ' || DN.first_name AS "NAME" FROM donor DN, medical_data MD
    WHERE MD.last_donation_date > TRUNC(SYSDATE) AND MD.last_donation_date < SYSDATE AND DN.id = MD.donor_id;

-- SELECT THE HOSPITAL NAME FOR EVERY TRANSACTION
SELECT T.donation_id AS "DONATION ID", H.name AS "HOSPITAL", T.transaction_date AS "TRANSACTION DATE", MD.blood_group || MD.blood_rh AS "BLOOD TYPE" FROM donation D, medical_data MD, transaction T, stock S, hospital H
    WHERE T.donation_id = D.id AND MD.donor_id = D.donor_id AND T.stock_id = S.id AND S.hospital_id = H.id;
