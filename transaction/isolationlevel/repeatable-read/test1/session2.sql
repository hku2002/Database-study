
-- 4
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 5
START TRANSACTION;

-- 6
SELECT * FROM BOOK WHERE id = 1;

-- 8
SELECT * FROM BOOK WHERE id = 1;

-- 9
COMMIT;
