-- CREATE DATABASE db_olympic;
-- \c db_olympic;
-- psql -U postgres -h 127.0.0.1 -d db_olympic -f fill_tables.sql
-- DROP DAATBASE db_olympic;

CREATE TABLE athletes(
    id INTEGER,
    name VARCHAR,
    sex VARCHAR(1),
    age INTEGER,
    height INTEGER,
    weight NUMERIC(4, 1),
    NOC VARCHAR(3),
    sport VARCHAR
);


CREATE TABLE games(
    idGame INTEGER,
    city VARCHAR,
    year INTEGER,
    season VARCHAR
);


CREATE TABLE nation(
    NOC VARCHAR(3),
    nameCountry VARCHAR,
    capital VARCHAR,
    population INTEGER,
    region VARCHAR
);


CREATE TABLE medal(
    id INTEGER,
    idGame INTEGER,
    Sport VARCHAR,
    Event VARCHAR,
    Medal VARCHAR
);