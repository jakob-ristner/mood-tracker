--DROP TABLE IF EXISTS Users CASCADE;
--CREATE TABLE Users (
   --id SERIAL PRIMARY KEY,
   --admin BOOLEAN NOT NULL DEFAULT FALSE,
   --name TEXT NOT NULL,
   --email TEXT NOT NULL,
   --password TEXT NOT NULL,
   --uuid TEXT NOT NULL,
   --created_at TIMESTAMP DEFAULT NOW()
--);

--DROP TABLE IF EXISTS PleasantLogs CASCADE;
--CREATE TABLE PleasantLogs (
   --id SERIAL PRIMARY KEY,
   --user_id INT NOT NULL,
   --score DOUBLE PRECISION NOT NULL CHECK (score >= 0 AND score <= 1),
   --created_at TIMESTAMP DEFAULT NOW(),
   --FOREIGN KEY (user_id) REFERENCES Users(id)
--);

--DROP TABLE IF EXISTS EnergyLogs CASCADE;
--CREATE TABLE EnergyLogs (
   --id SERIAL PRIMARY KEY,
   --user_id INT NOT NULL,
   --score DOUBLE PRECISION NOT NULL CHECK (score >= 0 AND score <= 1),
   --created_at TIMESTAMP DEFAULT NOW(),
   --FOREIGN KEY (user_id) REFERENCES Users(id)
--);

--DROP TABLE IF EXISTS Groups CASCADE;
--CREATE TABLE Groups (
   --id SERIAL PRIMARY KEY,
   --name TEXT NOT NULL,
   --created_at TIMESTAMP DEFAULT NOW()
--);

--DROP TABLE IF EXISTS GroupMembers CASCADE;
--CREATE TABLE GroupMembers (
   --id SERIAL PRIMARY KEY,
   --user_id INT NOT NULL,
   --group_id INT NOT NULL,
   --group_admin BOOLEAN NOT NULL DEFAULT FALSE,
   --created_at TIMESTAMP DEFAULT NOW(),
   --FOREIGN KEY (user_id) REFERENCES Users(id),
   --FOREIGN KEY (group_id) REFERENCES Groups(id)
--);

\set QUIET on
\i sql/tables.sql
\set QUIET off

INSERT INTO Users (admin, name, email, password) VALUES (TRUE, 'admin', 'admin@admin.com', 'admin_password');
INSERT INTO Users (admin, name, email, password) VALUES (FALSE, 'test_user_1', 'test1@test.com' , 'test_password_1');

INSERT INTO PleasantLogs (user_id, score) VALUES (1, 0.5);
INSERT INTO PleasantLogs (user_id, score) VALUES (2, 0.7);

INSERT INTO EnergyLogs (user_id, score) VALUES (1, 0.5);
INSERT INTO EnergyLogs (user_id, score) VALUES (2, 0.7);

INSERT INTO Groups (name) VALUES ('test_group_1');
INSERT INTO Groups (name) VALUES ('test_group_2');

INSERT INTO GroupMembers (user_id, group_id, group_admin) VALUES (1, 1, TRUE);
INSERT INTO GroupMembers (user_id, group_id, group_admin) VALUES (2, 2, FALSE);

SELECT * FROM Users LIMIT 2

