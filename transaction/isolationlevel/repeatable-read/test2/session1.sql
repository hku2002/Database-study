
-- 1
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ ;

-- 2
START TRANSACTION;

-- 3
SELECT * FROM BOOK WHERE id >= 1;

-- 8
SELECT * FROM BOOK WHERE id >= 1;

-- 9
COMMIT;
