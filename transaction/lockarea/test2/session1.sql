
-- 1
START TRANSACTION;

-- 2
UPDATE BUTTON SET activated = 1 WHERE activated = 0;

-- 5
COMMIT;
