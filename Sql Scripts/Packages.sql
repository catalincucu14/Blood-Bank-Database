-- PACKAGE
CREATE OR REPLACE PACKAGE blood_bank_package IS
    --PROCEDURE USED TO TRANSFER A SPECIFIED DONATION
    PROCEDURE transfer_donation_by_id(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_donation_id IN donation.id%TYPE);
    -- PROCEDURE USED TO TRANSFER A SPECIFIED NUMBER OF DONATIONS WITH A SPECIFIED BLOOD GROUP AND RH
    PROCEDURE transfer_donations_by_quantity(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_donations_quantity IN NUMBER, p_blood_group IN medical_data.blood_group%TYPE, p_blood_rh IN medical_data.blood_rh%TYPE);
    -- PROCEDURE USED TO TRANSFER A SPECIFIED QUNATITY OF BLOOD WITH A SPECIFIED BLOOD GROUP AND RH
    PROCEDURE transfer_blood_by_quantity(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_blood_quantity IN NUMBER, p_blood_group IN medical_data.blood_group%TYPE, p_blood_rh IN medical_data.blood_rh%TYPE);
    -- FUNCTION USED TO INCREMENT A VALUE
    FUNCTION increment(f_val IN NUMBER) RETURN NUMBER;
END;
/

--PROCEDURE USED TO TRANSFER A SPECIFIED DONATION
CREATE OR REPLACE PACKAGE BODY blood_bank_package IS
    PROCEDURE transfer_donation_by_id(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_donation_id IN donation.id%TYPE) IS
        v_temp         NUMBER;
        v_stock_id     stock.id%TYPE;
        r_donation     donation%ROWTYPE;
        r_medical_data medical_data%ROWTYPE;
    BEGIN
        -- Check if the given hospital id is valid
        SELECT COUNT(*) INTO v_temp FROM hospital H WHERE H.id = p_hospital_id;
        IF (v_temp = 0) THEN
            RAISE_APPLICATION_ERROR( -20101, 'TRANSACTION FAILED, INVALID hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ].' );
        END IF;
        -- Check if the given donation id is valid
        SELECT COUNT(*) INTO v_temp FROM donation D WHERE D.id = p_donation_id AND TRUNC(D.donation_date) <= TRUNC(p_transfer_date);
        IF (v_temp = 0) THEN
            RAISE_APPLICATION_ERROR( -20102, 'TRANSACTION FAILED, INVALID DONATION.id [ ' || TO_CHAR(p_donation_id) || ' ].' );
        END IF;
        -- Check if the donation was not touched before :)
        SELECT count(*) INTO v_temp FROM transaction T WHERE T.donation_id = p_donation_id;
        -- Check if the donations is already transferred (has a stock_id)
        IF(v_temp = 0) THEN
            SELECT * INTO r_donation FROM donation D WHERE D.id = p_donation_id;
            SELECT * INTO r_medical_data FROM medical_data MD WHERE MD.donor_id = (SELECT D.donor_id FROM donation D where D.id = p_donation_id);
            -- Update the hospital stock with the quantity of the donation
            UPDATE stock S SET S.quantity = S.quantity + r_donation.available_quantity
                WHERE S.blood_group = r_medical_data.blood_group AND S.blood_rh = r_medical_data.blood_rh AND S.hospital_id = p_hospital_id;
            -- Check if any columns have updated, if not then that stock does not exists
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR( -20103, 'TRANSACTION FAILED, hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ] DOES NOT HAVE STOCK FOR blood_group [ ' || TO_CHAR(r_medical_data.blood_group) || ' ] AND blood_rh [ ' || TO_CHAR(r_medical_data.blood_rh) || ' ].' );
                ROLLBACK;
            END IF;
            -- Select the updated stock id
            SELECT S.id INTO v_stock_id FROM stock S
                WHERE S.blood_group = r_medical_data.blood_group AND S.blood_rh = r_medical_data.blood_rh AND S.hospital_id = p_hospital_id;
            -- Create the transaction
            INSERT INTO transaction(stock_id, donation_id, transaction_date, quantity)
                VALUES(v_stock_id, p_donation_id, p_transfer_date, r_donation.available_quantity);
            -- Update the blood available_quantity
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu DISABLE';
            UPDATE donation D SET D.available_quantity = 0
                WHERE id = p_donation_id;
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu ENABLE';
            -- Commit the changes
            COMMIT;
            DBMS_OUTPUT.put_line( 'TRANSACTION COMPLETED.' );
        ELSE
            RAISE_APPLICATION_ERROR( -20104, 'TRANSACTION FAILED, donation.id [ ' || TO_CHAR(p_donation_id) || ' ] COULD NOT BE TRANSFERRED BECASE IS ALREADY TRANSFERRED OR A PART OF IT.' );
        END IF;
    END;

    -- PROCEDURE USED TO TRANSFER A SPECIFIED NUMBER OF DONATIONS WITH A SPECIFIED BLOOD GROUP AND RH
    PROCEDURE transfer_donations_by_quantity(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_donations_quantity IN NUMBER, p_blood_group IN medical_data.blood_group%TYPE, p_blood_rh IN medical_data.blood_rh%TYPE) IS
        v_counter         NUMBER := 0;
        v_temp            NUMBER;
        v_donations_stock NUMBER;
        v_donations       donation%ROWTYPE;
        v_stock_id        stock.id%TYPE;
    BEGIN
        -- Check if the given hospital id is valid
        SELECT COUNT(*) INTO v_temp FROM hospital H WHERE H.id = p_hospital_id;
        IF (v_temp = 0) THEN
            RAISE_APPLICATION_ERROR( -20101, 'TRANSACTION FAILED, INVALID hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ].' );
        END IF;
        -- Select the number of donations with the blood group and rh specified that haven't been touched before
        SELECT COUNT(*) INTO v_donations_stock FROM donation D, medical_data MD
            WHERE D.donor_id = MD.donor_id AND MD.blood_group = p_blood_group AND MD.blood_rh = p_blood_rh AND TRUNC(D.donation_date) <= TRUNC(p_transfer_date) AND D.id NOT IN
                (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id);
        -- Check if the number of donations available is higher than the requested amount
        IF(p_donations_quantity > v_donations_stock) THEN
            RAISE_APPLICATION_ERROR( -20102, 'TRANSACTION FAILED, STOCK INSUFFCIENT, REQUESTED [ ' || TO_CHAR(p_donations_quantity) || ' ] AND AVAILABLE [ ' || TO_CHAR(v_donations_stock) || ' ]. ');
        END IF;
        FOR i IN (SELECT D.id, D.available_quantity FROM donation D, medical_data MD
                    WHERE D.donor_id = MD.donor_id AND MD.blood_group = p_blood_group AND MD.blood_rh = p_blood_rh AND D.id NOT IN
                        (SELECT T.donation_id FROM transaction T WHERE T.donation_id = D.id)) LOOP
            -- Update the hospital stock with the quantity of the donation
            UPDATE stock S SET S.quantity = S.quantity + i.available_quantity
                        WHERE S.blood_group = p_blood_group AND S.blood_rh = p_blood_rh AND S.hospital_id = p_hospital_id;
            -- Check if any columns have updated, if not then that stock does not exists
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR( -20103, 'TRANSACTION FAILED, hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ] DOES NOT HAVE STOCK FOR blood_group [ ' || TO_CHAR(p_blood_group) || ' ] AND blood_rh [ ' || TO_CHAR(p_blood_rh) || ' ].' );
                ROLLBACK;
            END IF;
            -- Select the updated stock id
            SELECT id INTO v_stock_id FROM stock S
                WHERE S.blood_group = p_blood_group AND S.blood_rh = p_blood_rh AND S.hospital_id = p_hospital_id;
            -- Create the transaction
            INSERT INTO transaction(stock_id, donation_id, transaction_date, quantity)
                VALUES(v_stock_id, i.id, p_transfer_date, i.available_quantity);
            -- Update the blood quantity
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu DISABLE';
            UPDATE donation D SET D.available_quantity = 0
                WHERE id = i.id;
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu ENABLE';
            -- If the requested amount is transferred then stop
            v_counter := increment(v_counter);
            IF(v_counter = p_donations_quantity) THEN
                EXIT;
            END IF;
        END LOOP;
        -- Commit the changes
        COMMIT;
        DBMS_OUTPUT.put_line( 'TRANSACTION COMPLETED.' );
    END;

    -- PROCEDURE USED TO TRANSFER A SPECIFIED QUNATITY OF BLOOD WITH A SPECIFIED BLOOD GROUP AND RH
    PROCEDURE transfer_blood_by_quantity(p_transfer_date IN DATE, p_hospital_id IN hospital.id%TYPE, p_blood_quantity IN NUMBER, p_blood_group IN medical_data.blood_group%TYPE, p_blood_rh IN medical_data.blood_rh%TYPE) IS
        v_counter         NUMBER := 0;
        v_temp            NUMBER;
        v_quantity_stock  NUMBER;
        v_blood_quantity  NUMBER;
        v_donations       donation%ROWTYPE;
        v_stock_id        stock.id%TYPE;
    BEGIN
        -- Check if the given hospital id is valid
        SELECT COUNT(*) INTO v_temp FROM hospital H WHERE H.id = p_hospital_id;
        IF (v_temp = 0) THEN
            RAISE_APPLICATION_ERROR( -20101, 'TRANSACTION FAILED, INVALID hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ].' );
        END IF;
        -- Select the quantity of blood with the blood group and rh specified
        SELECT SUM(D.available_quantity) INTO v_quantity_stock FROM donation D, medical_data MD
            WHERE D.donor_id = MD.donor_id AND MD.blood_group = p_blood_group AND MD.blood_rh = p_blood_rh AND TRUNC(D.donation_date) <= TRUNC(p_transfer_date);
        -- Check if the number of blood available is higher than the requested amount
        IF(p_blood_quantity > v_quantity_stock) THEN
            RAISE_APPLICATION_ERROR( -20102, 'TRANSACTION FAILED, STOCK INSUFFCIENT, REQUESTED [ ' || TO_CHAR(p_blood_quantity) || ' ] AND AVAILABLE [ ' || TO_CHAR(v_quantity_stock) || ' ]. ');
        END IF;
        v_blood_quantity := p_blood_quantity;
        FOR i IN (SELECT D.id, D.available_quantity FROM donation D, medical_data MD
                    WHERE D.donor_id = MD.donor_id AND MD.blood_group = p_blood_group AND MD.blood_rh = p_blood_rh) LOOP
            -- Update the hospital stock with the quantity of the donation
            IF(v_blood_quantity >= i.available_quantity) THEN
                v_temp := i.available_quantity;
            ELSE
                v_temp := v_blood_quantity;
            END IF;
            -- Update the hospital stock with the quantity of the donation
            UPDATE stock S SET S.quantity = S.quantity + v_temp
                        WHERE S.blood_group = p_blood_group AND S.blood_rh = p_blood_rh AND S.hospital_id = p_hospital_id;
            -- Check if any columns have updated, if not then that stock does not exists
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR( -20103, 'TRANSACTION FAILED, hospital.id [ ' || TO_CHAR(p_hospital_id) || ' ] DOES NOT HAVE STOCK FOR blood_group [ ' || TO_CHAR(p_blood_group) || ' ] AND blood_rh [ ' || TO_CHAR(p_blood_rh) || ' ].' );
                ROLLBACK;
            END IF;
            -- Select the updated stock id
            SELECT id INTO v_stock_id FROM stock S
                WHERE S.blood_group = p_blood_group AND S.blood_rh = p_blood_rh AND S.hospital_id = p_hospital_id;
            -- Create the transaction
            INSERT INTO transaction(stock_id, donation_id, transaction_date, quantity)
                VALUES(v_stock_id, i.id, p_transfer_date, v_temp);
            -- Update the blood available_quantity
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu DISABLE';
            UPDATE donation D SET D.available_quantity = i.available_quantity - v_temp
                WHERE id = i.id;
            EXECUTE IMMEDIATE 'ALTER TRIGGER trg_donation_date_2_briu ENABLE';
            -- If the requested amount is transferred then stop
            v_blood_quantity := v_blood_quantity - v_temp;
            IF(v_blood_quantity = 0) THEN
                EXIT;
            END IF;
        END LOOP;
        -- Commit the changes
        COMMIT;
        DBMS_OUTPUT.put_line( 'TRANSACTION COMPLETED.' );
    END;

    -- FUNCTION USED TO INCREMENT A VALUE
    FUNCTION increment(f_val IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN f_val + 1;
    END;
END;
/
