-- type mysql -u root at the bash prompt to start the database.

-- see all the databases on your server

show databases;

-- create a new database
create database swimming_coach;

-- change the active database
use swimming_coach;

-- create a new table
-- named 'parents' with some columns
--create table <table name>(
--<col name><col data type><options>
--) engine = innodb
-- The'engine = innodb' is to enable foreign keys

create table parents(
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null,
    last_name varchar(200) default ''
) engine = innodb;

-- show all tables
show tables;

-- create students table
create table students (
    student_id mediumint unsigned auto_increment primary key,
    name varchar(200) not null,
    date_of_birth datetime not null
) engine = innodb;

-- ALTER TABLE: alter an existing table
-- we can: change a column, add a new column, or delete a column

ALTER TABLE students ADD COLUMN parent_id int unsigned not null;

-- Use DESCRIBE to show fields definition of a table.
DESCRIBE students;

-- Define parent_id in students table as foreign key
ALTER TABLE students ADD CONSTRAINT fk_students_parents
FOREIGN KEY (parent_id) REFERENCES parents(parent_id);

-- ALTER TABLE: Modify an existing column
-- Let's make the parent_id foreign key in the 'students' table

ALTER TABLE students MODIFY COLUMN parent_id INT UNSIGNED NOT NULL;

-- Add new data
-- INSERT INTO <table name>(<col1>,<col2>...) VALUES (<col1 value>,<col2 value>...)
INSERT INTO parents (first_name, last_name) VALUES ("John", "Wick");

--See all the rows from the table
--SELECT * FROM parents --> * means all columns
SELECT * FROM parents;

--INSERT into students
INSERT INTO students (name, date_of_birth, parent_id) VALUES ("Jon Snow", "1984-6-13", 1);

--DELETE: remove a row
--the following won't work as only one row left
DELETE FROM parents WHERE parent_id = 1;

--DROP: delete an table
DROP TABLE parents; --won't work as parent_id foreign key still referencing.

--Create the payments table
CREATE TABLE payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date_paid DATETIME NOT NULL,
    parent_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id),
    student_id MEDIUMINT UNSIGNED NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
) engine = innodb;

--alter the payments table to add in the amount
--(deliberately forget to set to as NOT NULL)
ALTER TABLE payments ADD COLUMN amount DECIMAL(10,2);

--change the amount column that is not null
--modifying a column is kike a PUT in RESTFul API

ALTER TABLE payments MODIFY COLUMN amount DECIMAL(10, 2);

--add a dummy column demonstrate dropping
ALTER TABLE payments ADD COLUMN test VARCHAR(100);

--drop a column
ALTER TABLE payments DROP COLUMN test;
