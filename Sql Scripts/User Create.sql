ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;  

CREATE USER blood_bank IDENTIFIED BY pwd;
  
GRANT ALL PRIVILEGES TO blood_bank;
  