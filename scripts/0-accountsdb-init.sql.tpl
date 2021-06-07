 CREATE DATABASE accountsdb;
 CREATE USER accounts WITH ENCRYPTED PASSWORD '${accounts_db_password}';
 GRANT ALL PRIVILEGES ON DATABASE accountsdb TO accounts;