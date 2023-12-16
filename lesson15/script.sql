ALTER USER 'developer'@'%' IDENTIFIED WITH mysql_native_password BY '3AMTf?DcXxpczeaUPx2_?tTethw4aFmF';
CREATE DATABASE lesson15;


USE my_database;

CREATE TABLE Employees (
id integer auto_increment PRIMARY KEY,
firstName varchar(50) NOT NULL,
lastName varchar(50) NOT NULL,
email varchar(100),
position ENUM('manager', 'developer')
);

CREATE TABLE Projects (
id integer auto_increment PRIMARY KEY,
name varchar(100) NOT NULL,
startAt date,
endAt date,
managerId integer,
FOREIGN KEY (managerId) REFERENCES Employees(id)
);

CREATE TABLE Tasks (
id integer auto_increment PRIMARY KEY,
projectId integer,
name varchar(100) NOT NULL,
description text,
status ENUM('TODO', 'IN PROGRESS', 'DONE'),
dueAt date,
emploeeId integer,
FOREIGN KEY (projectId) REFERENCES Projects(id),
FOREIGN KEY (emploeeId) REFERENCES Employees(id)
);

INSERT INTO Employees (firstName, lastName, email, position) VALUES 
('John', 'Tri Volta', 'john@star.com', 'manager'),
('Nicolas', 'Keys', 'kolya@star.com', 'manager'),
('Micle', 'Tucson', 'micle@bobik.com', 'developer'),
('Rayan', 'King', 'ray@king.com', 'developer'),
('Rob', 'Marlya', 'marlya@mail.com', 'developer');

INSERT INTO Projects (name, startAt, endAt, managerId) VALUES 
('Pulp Fiction', '1993-10-14', '1994-10-14', 1),
('he Unbearable Weight of Massive Talent', '2020-01-01', 'ProjectsProjects2022-03-12', 2);

INSERT INTO Tasks (projectId, name, description, status, dueAt, emploeeId) VALUES 
(1, 'Money', 'No kino - no money', 'DONE', '1993-07-17', 3),
(1, 'Script', 'Write script', 'DONE', '1993-08-17', 4),
(1, 'Sell', 'Sell film to cinema', 'DONE', '1994-08-17', 5),
(2, 'Find heroes', 'Really hard a task', 'TODO', '2021-08-10', 3),
(2, 'Find scenarion', 'Really hard a task', 'TODO', '2021-08-11', 3),
(2, 'Buy buhlo', 'Really hard a task', 'DONE', '2021-08-12', 3),
(2, 'Buy cars for producers', 'Really hard a task', 'IN PROGRESS', '2021-08-17', 3),
(2, 'Corporative', 'Corporative', 'DONE', '2022-02-17', 4);


-- #1 Напишіть SQL-запит, який виведе всі проєкти разом зі списком працівників, які ними керують.
SELECT p.id, p.name, e.firstName, e.lastName, e.email
FROM Projects as p
INNER JOIN Employees as e
ON p.managerId = e.id


-- #2 Напишіть SQL-запит, який виведе всі завдання для конкретного проєкту разом з працівниками, яким призначено ці завдання.
SELECT t.id, t.name, e.firstName, e.lastName, e.email, t.projectId
FROM Tasks as t 
INNER JOIN Employees as e
ON t.emploeeId = e.id
WHERE t.projectId = 1

-- #3.1 Обчисліть та виведіть середній термін виконання завдань усіх проєктів.
SELECT AVG(dayofyear(from_days((to_days(t.dueAt) - to_days(p.startAt))))) as diff
FROM Tasks as t 
INNER JOIN Projects as p
ON t.projectId = p.id
-- #3.2 Обчисліть та виведіть максимальний термін виконання завдань усіх проєктів.
SELECT MAX(dayofyear(from_days((to_days(t.dueAt) - to_days(p.startAt))))) as diff
FROM Tasks as t 
INNER JOIN Projects as p
ON t.projectId = p.id