DROP TABLE IF EXISTS Users CASCADE;
CREATE TABLE Users (
   id SERIAL PRIMARY KEY,
   admin BOOLEAN NOT NULL DEFAULT FALSE,
   name TEXT NOT NULL,
   email TEXT NOT NULL,
   password TEXT NOT NULL,
   uuid UUID NOT NULL DEFAULT gen_random_uuid(),
   created_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS PleasantLogs CASCADE;
CREATE TABLE PleasantLogs (
   id SERIAL PRIMARY KEY,
   user_id INT NOT NULL,
   score DOUBLE PRECISION NOT NULL CHECK (score >= 0 AND score <= 1),
   created_at TIMESTAMP DEFAULT NOW(),
   log_date DATE GENERATED ALWAYS AS (created_at::DATE) STORED,
   FOREIGN KEY (user_id) REFERENCES Users(id),
   CONSTRAINT pleasant_logs_user_id_log_date_unique UNIQUE (user_id, log_date)
);

DROP TABLE IF EXISTS EnergyLogs CASCADE;
CREATE TABLE EnergyLogs (
   id SERIAL PRIMARY KEY,
   user_id INT NOT NULL,
   score DOUBLE PRECISION NOT NULL CHECK (score >= 0 AND score <= 1),
   created_at TIMESTAMP DEFAULT NOW(),
   log_date DATE GENERATED ALWAYS AS (created_at::DATE) STORED,
   FOREIGN KEY (user_id) REFERENCES Users(id),
   CONSTRAINT energy_logs_user_id_log_date_unique UNIQUE (user_id, log_date)
);

DROP TABLE IF EXISTS Groups CASCADE;
CREATE TABLE Groups (
   id SERIAL PRIMARY KEY,
   name TEXT NOT NULL,
   created_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS GroupMembers CASCADE;
CREATE TABLE GroupMembers (
   user_id INT NOT NULL,
   group_id INT NOT NULL,
   group_admin BOOLEAN NOT NULL DEFAULT FALSE,
   created_at TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY (user_id, group_id),
   FOREIGN KEY (user_id) REFERENCES Users(id),
   FOREIGN KEY (group_id) REFERENCES Groups(id)
);
