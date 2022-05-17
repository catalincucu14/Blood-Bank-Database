--TRIGGER DONATION.DONATION_DATE: 3 MONTHS BETWEEN 2 DONATIONS
CREATE OR REPLACE TRIGGER trg_donation_date_1_briu
    BEFORE INSERT OR UPDATE ON donation
    FOR EACH ROW
DECLARE
	 v_last_donation_date medical_data.last_donation_date%TYPE;
BEGIN
    -- Check if the donor has donated before
    SELECT last_donation_date INTO v_last_donation_date FROM medical_data WHERE donor_id = :new.donor_id;
    IF(v_last_donation_date IS NOT NULL) THEN
        -- Check if from donor's last donation and the new donation have passed at least 3 months
        IF(MONTHS_BETWEEN(:new.donation_date, v_last_donation_date) < 3 AND :old.donation_date != :new.donation_date) THEN
            RAISE_APPLICATION_ERROR( -20110, 'donation.donation_date INVALID [ ' || TO_CHAR(:new.donation_date, 'DD.MM.YYYY') || ' ]. IT MUST BE PASSED AT LEAST 3 MONTHS FROM THE LAST DONATION.' );
        END IF;
    END IF;
END;
/

--TRIGGER DONATION.INITIAL_QUANTITY, DONATION.AVAILABLE_QUANTITY
CREATE OR REPLACE TRIGGER trg_donation_date_2_briu
    BEFORE INSERT OR UPDATE ON donation
    FOR EACH ROW
BEGIN
    -- Check if is inserting
    IF INSERTING THEN
        -- Check if the inserted quantity is valid
        IF :new.initial_quantity > 449 AND :new.initial_quantity < 501 THEN
            :new.available_quantity := :new.initial_quantity;
        ELSE
            RAISE_APPLICATION_ERROR( -20110, 'donation.initial_quantity CANNOT BE LESS THAN 450 AND MORE THAT 500.' );
        END IF;
    END IF;
    -- Check if is updating
    IF UPDATING THEN
        IF :old.initial_quantity = :new.initial_quantity AND :old.available_quantity != :new.available_quantity THEN
            DBMS_OUTPUT.put_line( 'donation.available_quantity CANNOT BE UPDATED.' );
        END IF;
        -- Check if the donation have been transferred before
        IF :new.initial_quantity > 449 AND :new.initial_quantity < 501 THEN
            IF :old.initial_quantity = :old.available_quantity THEN
                :new.available_quantity := :new.initial_quantity;
            ELSE
                RAISE_APPLICATION_ERROR( -20111, 'donation.initial_quantity CANNOT BE CHANGED AFTER TRANSFER.' );
            END IF;
        ELSE
            RAISE_APPLICATION_ERROR( -20110, 'donation.initial_quantity CANNOT BE LESS THAN 450 AND MORE THAT 500.' );
        END IF;
    END IF;
END;
/

--TRIGGER DONOR.BIRTH_DATE: DONORS MUST BE AGED BETWEEN 19-60 YEARS OLD
CREATE OR REPLACE TRIGGER trg_birth_date_briu
    BEFORE INSERT OR UPDATE ON medical_data
    FOR EACH ROW
BEGIN
    -- Check if the donor is not aged below 18 years old
    IF(MONTHS_BETWEEN(SYSDATE, :new.birth_date)/12 < 18) THEN
        RAISE_APPLICATION_ERROR( -20110, 'donor.birth_date INVALID [ ' || TO_CHAR(:new.birth_date, 'DD.MM.YYYY') || ' ]. DONOR CANNOT BE YOUNGER THAN 18 YEARS OLD.' );
    END IF;
    -- Check if the donor is not aged above 60 years old
    IF(MONTHS_BETWEEN(SYSDATE, :new.birth_date)/12 > 60) THEN
        RAISE_APPLICATION_ERROR( -20111, 'donor.birth_date INVALID [ ' || TO_CHAR(:new.birth_date, 'DD.MM.YYYY') || ' ]. DONOR CANNOT BE OLDER THAN 60 YEAS OLD.' );
    END IF;
END;
/

-- TRIGGER DONATION DML: DON'T MAKE ANY DML ON DONATION OUTSIDE THE WORKING PROGRAM
CREATE OR REPLACE TRIGGER trg_blood_bank_dml_briud BEFORE
    INSERT OR UPDATE OR DELETE ON donation
BEGIN
    IF(TO_CHAR(SYSDATE, 'dy') IN ('sat', 'sun')) OR (TO_CHAR(SYSDATE, 'hh24mi') NOT BETWEEN '0600' AND '2000') THEN
        RAISE_APPLICATION_ERROR(-20110, 'DML OPERATIONS OUTSIDE THE WORKING HOURS [ 06:00 - 20:00 ]' );
    END IF;
END;
/
