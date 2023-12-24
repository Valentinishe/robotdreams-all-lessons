USE mydb;


CREATE TABLE Clients (
id integer auto_increment PRIMARY KEY,
firstName varchar(50) NOT NULL,
lastName varchar(50) NOT NULL,
email varchar(100),
);

CREATE TABLE Products (
id integer auto_increment PRIMARY KEY,
name varchar(50) NOT NULL,
price integer NOT NULL,
);

CREATE TABLE Orders (
id integer auto_increment PRIMARY KEY,
purchasedAt date,
clientId integer,
productId integer,
FOREIGN KEY (clientId) REFERENCES Clients(id)
FOREIGN KEY (productId) REFERENCES Products(id)
);

INSERT INTO Clients (firstName, lastName, email) VALUES 
('John', 'Tri Volta', 'john@star.com'),
('Nicolas', 'Keys', 'kolya@star.com'),
('Micle', 'Tucson', 'micle@bobik.com'),
('Rayan', 'King', 'ray@king.com'),
('Rob', 'Marlya', 'marlya@mail.com');

INSERT INTO Products (name, price) VALUES 
('Pulp Fiction', 100),
('he Unbearable Weight of Massive Talent',  200);

INSERT INTO Orders (clientId, productId, purchasedAt) VALUES 
(1, 1, '2023-12-17'),
(2, 1, '2023-12-16'),
(2, 2, '2023-12-15'),
(3, 1, '2023-12-17'),
(3, 2, '2023-12-11'),
(4, 1, '2023-12-17'),
(5, 1, '2023-12-16');