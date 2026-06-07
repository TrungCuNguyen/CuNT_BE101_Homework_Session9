CREATE TABLE Users
(
    user_id  SERIAL PRIMARY KEY,
    email    VARCHAR(100) NOT NULL,
    username VARCHAR(100)
);

INSERT INTO Users (email, username)
SELECT 'user' || i || '@gmail.com' AS email,
       'Nguyen Van ' || i          AS username
FROM generate_series(1, 10000) AS i;

EXPLAIN ANALYZE
SELECT *
FROM Users
WHERE email = 'example@example.com';

CREATE INDEX idx_email ON Users USING hash(email);

-- Execution Time before create index: 1.312 ms
-- Execution Time after create index: 0.055 ms