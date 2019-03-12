DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  danger_level VARCHAR(255),
  bounty_value INT,
  fave_weapon VARCHAR(255)
  );
