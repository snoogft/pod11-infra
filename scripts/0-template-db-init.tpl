CREATE DATABASE ${db_name};
CREATE USER ${db_user} WITH ENCRYPTED PASSWORD '${db_password}';
GRANT ALL PRIVILEGES ON DATABASE ${db_name} TO ${db_user};