CREATE TABLE Department (
       d_name text,
       d_address text,
       PRIMARY KEY(d_name)
);

-- ISA
CREATE TABLE Student (
       uni text, 
       s_name text,
       type text,
       date_of_birth date,
       d_name text REFERENCES Department(d_name) NOT NULL,
       PRIMARY KEY(uni),
       CHECK (type in ('graduate', 'undergraduate')),
       CHECK (date_of_birth <= now() - interval '18 year')
);

CREATE TABLE Graduate (
       uni text REFERENCES Student(uni), 
       research_field text,
       PRIMARY KEY (uni)
);

CREATE TABLE Undergraduate (
       uni text REFERENCES Student(uni), 
       concentration text,
       PRIMARY KEY (uni)
);

-- aggregation
CREATE TABLE Term (
       semester text,
       year int,
       PRIMARY KEY(semester, year)
);

CREATE TABLE Course (
       c_number int,
       c_capacity int,
       c_name text,
       d_name text REFERENCES Department(d_name) ON DELETE CASCADE,
       PRIMARY KEY (d_name, c_number)
);

CREATE TABLE Offers (
       o_id int,
       d_name text NOT NULL,
       c_number text NOT NULL,
       semester text NOT NULL,
       year int NOT NULL,
       FOREIGN KEY (d_name, c_number) REFERENCES Course(d_name, c_number),
       FOREIGN KEY (semester, year) REFERENCES Term(semester, year),
       -- a course cannot be offered more than once per semester
       UNIQUE(d_name, c_number, semester, year),
       PRIMARY KEY (o_id)
);

CREATE TABLE Enrolls (
       uni text REFERENCES Student(uni),
       o_id int REFERENCES Offers(o_id)
);