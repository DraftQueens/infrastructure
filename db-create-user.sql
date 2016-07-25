CREATE USER '<user>'@'%' IDENTIFIED BY '<pass>';                                     
GRANT CREATE, DROP, REFERENCES, ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE, CREATE TEMPORARY TABLES, CREATE VIEW, SHOW VIEW
ON scratch.*                                                                      
TO '<user>'@'%';
GRANT REFERENCES, SELECT, CREATE VIEW, SHOW VIEW
on lahman.*
TO '<user>'@'%';

