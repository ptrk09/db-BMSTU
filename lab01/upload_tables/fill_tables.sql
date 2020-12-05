COPY games FROM '/Users/pawtoporkov/db-bmstu/lab01/data/games.csv' DELIMITER ',' NULL AS '' CSV HEADER;

COPY nation FROM '/Users/pawtoporkov/db-bmstu/lab01/data/nation.csv' DELIMITER ';' NULL AS '' CSV HEADER;

COPY athletes FROM '/Users/pawtoporkov/db-BMSTU/lab01/data/athletes.csv' DELIMITER ',' NULL AS '' CSV HEADER;

COPY medal FROM '/Users/pawtoporkov/db-bmstu/lab01/data/medal.csv' DELIMITER ',' NULL AS '' CSV HEADER;