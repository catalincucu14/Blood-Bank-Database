-- HOSPITAL + STOCK
INSERT INTO hospital(name, city, address) VALUES('Spitalul Clinic de Urgenta pentru Copii Sfanta Maria', 'Iasi', 'Str. Vasile Lupu nr. 62');
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '-', hospital_id_seq.currval);

INSERT INTO hospital(name, city, address) VALUES('Spitalul Sfantul Spiridon', 'Iasi', 'Bd. Independentei nr. 1');
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '-', hospital_id_seq.currval);

INSERT INTO hospital(name, city, address) VALUES('Spitalul de Boli Infectioase Sfinta Cuvioasa Paraschiva', 'Iasi', 'Str. Octav Botez nr. 2');
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '-', hospital_id_seq.currval);

INSERT INTO hospital(name, city, address) VALUES('Spitalul Clinic Militar de Urgenta', 'Iasi', 'Str. General Henri Mathias Berthelot nr. 7-9');
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '-', hospital_id_seq.currval);

INSERT INTO hospital(name, city, address) VALUES('Spitalul Clinic de Urgenta Prof. Dr. Nicolae Oblu', 'Iasi', 'Str. Ateneului nr. 2');
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '+', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'O', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'A', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'B', '-', hospital_id_seq.currval);
INSERT INTO stock(quantity, blood_group, blood_rh, hospital_id) VALUES(0, 'AB', '-', hospital_id_seq.currval);

-- DONOR + PERSONAL_DATA + MEDICAL_DATA + DONATION
INSERT INTO donor(last_name, first_name) VALUES('Popescu', 'Mircea');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1781002223567', 'MZ', '432432', 'Iasi', 'str. Stefan cel Mare si Sfint nr. 69', '0716789526', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('02/10/1978', 'dd/mm/yyyy'), 'A', '+', 'M', '80', '179', TO_DATE('02/07/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 475, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Tanasa', 'Robert');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1990110223567', 'MZ', '247895', 'Iasi', 'str. Anastasie Panu nr. 60', '0716875634', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('10/01/1999', 'dd/mm/yyyy'), 'AB', '-', 'M', '75', '181', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 455, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Popa', 'Andrei');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1870505223567', 'MZ', '245631', 'Iasi', 'bd. Stefan cel Mare si Sfant nr. 11', '0704566706', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('05/05/1987', 'dd/mm/yyyy'), 'B', '-', 'M', '71', '174', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 488, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Dumitru', 'Beatrice');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2981011233567', 'MZ', '042607', 'Iasi', 'bd. Carol I Nr.27', '0745870067', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('23/11/1998', 'dd/mm/yyyy'), 'O', '-', 'F', '65', '164', TO_DATE('21/03/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 461, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 470, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Apostu', 'Catalin');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('5010311223567', 'MX', '046809', 'Iasi', 'str. Pacurari nr. 4', '0715799522', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('11/03/2001', 'dd/mm/yyyy'), 'B', '-', 'M', '78', '171', TO_DATE('14/07/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 475, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 456, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Ticu', 'Ionut');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1300802223567', 'MZ', '152308', 'Iasi', 'str. Alexandru Lapusneanu nr. 7', '0701462780', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('30/08/1992', 'dd/mm/yyyy'), 'A', '+', 'M', '91', '190', TO_DATE('22/01/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 455, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Neacsu', 'Cezar');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1990912223567', 'MZ', '017892', 'Iasi', 'str. Sararie nr. 150', '0714765203', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('12/09/1999', 'dd/mm/yyyy'), 'AB', '-', 'M', '87', '188', TO_DATE('07/04/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 1, 461, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Anghel', 'Stefan');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1971222223567', 'MZ', '340679', 'Iasi', 'str. Cuza Voda 29,', '0715578624', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('22/12/1997', 'dd/mm/yyyy'), 'B', '+', 'M', '77', '181', TO_DATE('03/02/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 1, 487, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 1, 462, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Ignat', 'Delia');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('4000523223567', 'MX', '100588', 'Iasi', 'str. Cuza Voda 29,', '0701468758', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('23/05/2000', 'dd/mm/yyyy'), 'A', '-', 'F', '67', '167', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 456, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Bujor', 'Gabriel');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1950828223567', 'MZ', '302557', 'Iasi', 'str. Agatha Barsescu nr.18', '0703498533', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('28/08/1995', 'dd/mm/yyyy'), 'O', '+', 'M', '79', '171', TO_DATE('11/06/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 477, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Andronic', 'Razvan');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1911109223567', 'MX', '780024', 'Iasi', 'str. Pictorului nr. 14', '0704468706', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('09/11/1991', 'dd/mm/yyyy'), 'O', '-', 'M', '75', '179', TO_DATE('29/03/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 465, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Gherciu', 'Monica');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2811004223567', 'MZ', '176892', 'Iasi', 'str. Pictorului nr. 14', '0720466783', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('04/10/1981', 'dd/mm/yyyy'), 'A', '+', 'F', '71', '172', TO_DATE('11/02/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 1, 481, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Gabrea', 'Cosmin');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1740401223567', 'MZ', '163007', 'Iasi', 'str. Stefan cel Mare nr. 4', '0734870568', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('01/04/1974', 'dd/mm/yyyy'), 'AB', '+', 'M', '76', '175', TO_DATE('02/01/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 3, 478, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 2, 455, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Calacean', 'Ioana');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2790519223567', 'MZ', '168725', 'Iasi', 'str. Vasile Conta nr.30', '0738478559', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('19/05/1979', 'dd/mm/yyyy'), 'B', '+', 'F', '66', '162', TO_DATE('03/06/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 453, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 471, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Oaida', 'Olivia');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2960727223567', 'MZ', '165700', 'Iasi', 'bd. Socola 134', '0721004997', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('27/07/1996', 'dd/mm/yyyy'), 'AB', '-', 'F', '63', '159', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 2, 471, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Racliu', 'Mihai');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1771013223567', 'MZ', '147586', 'Iasi', 'str. Palat nr. 1', '0714725980', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('13/10/1977', 'dd/mm/yyyy'), 'B', '-', 'M', '78', '173', TO_DATE('06/06/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 2, 466, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Ugrutan', 'Cristian');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1870721223567', 'MZ', '146233', 'Iasi', 'str. Pacurari 4', '0716573498', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('21/07/1987', 'dd/mm/yyyy'), 'A', '-', 'M', '74', '173', TO_DATE('14/08/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 478, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 488, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Miclaus', 'Roxana');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2790316223567', 'MX', '015567', 'Iasi', 'str. Lascar Catargi nr. 38', '0715743685', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('16/03/1979', 'dd/mm/yyyy'), 'A', '-', 'M', '64', '169', TO_DATE('04/05/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 3, 451, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Hagas', 'Paul');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1930909223567', 'MZ', '175689', 'Iasi', 'bd. Dimitrie Mangeron nr. 67', '0730499752', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('09/09/1993', 'dd/mm/yyyy'), 'B', '+', 'M', '79', '174', TO_DATE('23/07/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 475, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Neagu', 'Teodora');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2851018223567', 'MZ', '103649', 'Iasi', 'str. Ghica Voda nr. 13', '0732540387', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('18/10/1985', 'dd/mm/yyyy'), 'AB', '+', 'F', '61', '160', TO_DATE('18/08/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 488, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Pacala', 'Nicolae');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1890224223567', 'MX', '016887', 'Iasi', 'str. George Cosbuc 3', '0726047309', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('24/02/1989', 'dd/mm/yyyy'), 'O', '-', 'M', '79', '179', TO_DATE('10/09/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 1, 482, donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 1, 455, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Ripiceanu', 'Narcis');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('1811105223567', 'MZ', '789951', 'Iasi', 'str. Otilia Cazimir nr. 14', '0703489516', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('05/11/1981', 'dd/mm/yyyy'), 'AB', '-', 'M', '78', '189', TO_DATE('19/01/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 1, 471, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Vela', 'Mioara');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2760602223567', 'MZ', '697852', 'Iasi', 'str. Vasile Conta nr. 2', '0715786987', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('02/06/1976', 'dd/mm/yyyy'), 'B', '+', 'F', '71', '180', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE, 457, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Habuc', 'Georgiana');
INSERT INTO personal_data(cnp, series_id, number_id, city, address, phone, donor_id) VALUES('2830715223567', 'MZ', '168745', 'Iasi', 'str. Anastasia Panu nr. 26', '0730486572', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, last_donation_date, donor_id) VALUES(TO_DATE('15/07/1983', 'dd/mm/yyyy'), 'B', '+', 'F', '68', '176', TO_DATE('16/07/2020', 'dd/mm/yyyy'), donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE + 1, 458, donor_id_seq.currval);

INSERT INTO donor(last_name, first_name) VALUES('Maxim', 'Madalina');
INSERT INTO personal_data(cnp, series_id, number_id, city , address, phone, donor_id) VALUES('4000428223567', 'MX', '120035', 'Iasi', 'str. Gheorghe Asachi 18', '0725446870', donor_id_seq.currval);
INSERT INTO medical_data(birth_date, blood_group, blood_rh, sex, weight, height, donor_id) VALUES(TO_DATE('28/04/2000', 'dd/mm/yyyy'), 'A', '-', 'F', '78', '174', donor_id_seq.currval);
INSERT INTO donation(donation_date, initial_quantity, donor_id) VALUES(SYSDATE - 1, 461, donor_id_seq.currval);

-- UPDATE medical_data.last_donation_date
BEGIN
    FOR i IN (SELECT D.id, D.donor_id FROM donation D) LOOP
        UPDATE medical_data SET last_donation_date = (SELECT D.donation_date FROM donation D WHERE D.id = i.id) WHERE donor_id = i.donor_id;
    END LOOP;
END;
/
