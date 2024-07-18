
-- 3
START TRANSACTION;

-- 4
UPDATE BUTTON SET activated = 1 WHERE activated = 0;

-- 8
COMMIT;
