\c postgres;
DROP DATABASE db_olympic;
CREATE DATABASE db_olympic;
\c db_olympic;

CREATE TABLE games(
    idGame INTEGER NOT NULL,
    city VARCHAR,
    year INTEGER NOT NULL CHECK(year > 1895),
    season VARCHAR CHECK(season = 'Summer' OR season = 'Winter'),
    PRIMARY KEY(idGame),
    UNIQUE(idGame)
);


CREATE TABLE nation(
    NOC VARCHAR,
    nameCountry VARCHAR,
    capital VARCHAR,
    population INTEGER,
    region VARCHAR,
    PRIMARY KEY(NOC)
);


CREATE TABLE athletes(
    id INTEGER NOT NULL UNIQUE,
    name VARCHAR NOT NULL,
    sex VARCHAR(1) NOT NULL,
    age INTEGER,
    height INTEGER,
    weight NUMERIC(4, 1),
    NOC VARCHAR(3) NOT NULL,
    sport VARCHAR NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(NOC) REFERENCES nation(NOC)
);


CREATE TABLE medal(
    id INTEGER NOT NULL,
    idGame INTEGER NOT NULL,
    Sport VARCHAR,
    Event VARCHAR,
    Medal VARCHAR,
    FOREIGN KEY(id) REFERENCES athletes(id),
    FOREIGN KEY(idGame) REFERENCES games(idGame)
);
