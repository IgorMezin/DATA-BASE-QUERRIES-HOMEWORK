CREATE DATABASE Neeps;
CREATE TABLE staff(
id varchar(15) UNIQUE PRIMARY KEY,
name VARCHAR(100) NOT NULL
);
CREATE TABLE student(
    id varchar(20) UNIQUE PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    sze int NOT NULL,
    parent VARCHAR(20) REFERENCES student(id)
);
CREATE table modle(
    id VARCHAR(20) UNIQUE PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE room(
    id VARCHAR(30) UNIQUE PRIMARY KEY,
    name VARCHAR(100),
    capacity int NOT NULL,
    parent VARCHAR(30) REFERENCES room(id)
);
CREATE TABLE event(
    id VARCHAR(30) UNIQUE PRIMARY KEY,
    modle VARCHAR(10) REFERENCES modle(id),
    kind VARCHAR(1) NOT NULL,
    dow VARCHAR(15) NOT NULL,
    tod time NOT NULl,
    duration int NOT NULL,
    room VARCHAR(30) REFERENCES room(id)
);
CREATE TABLE attends(
    student VARCHAR(20) REFERENCES student(id),
    event VARCHAR(40) REFERENCES event(id)

);
CREATE TABLE teaches(
 staff VARCHAR(15) REFERENCES staff(id),
 event VARCHAR (30) REFERENCES event(id)
);
CREATE TABLE week(
id varchar(2) UNIQUE PRIMARY KEY,
wkstart DATE NOT NULL
);

CREATE TABLE occurs(
    event VARCHAR (30) REFERENCES event(id),
    week VARCHAR REFERENCES week(id)
);
CREATE PROCEDURE delete_from_week(id_check varchar)
    DELETE FROM week
    WHERE id = id_check;

CREATE TRIGGER check_id_week
    BEFORE UPDATE OF id ON week
    FOR EACH ROW
    WHEN id NOT LIKE '(^[0]\d$)|(^[1][0-3]$)'
    EXECUTE PROCEDURE delete_from_week(id)

CREATE VIEW event_week_wkstart as
    SELECT event.id as id , occurs.week as week, week.wkstart as wkstart
    FROM event JOIN occurs o on event.id = o.event JOIN week w on o.week = w.id

