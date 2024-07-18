
-- 1
START TRANSACTION;

-- 2
UPDATE BUTTON SET activated = 1 WHERE id = 1 AND activated = 0;

-- 5
COMMIT;
