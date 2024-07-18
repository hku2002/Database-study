
-- 1
START TRANSACTION;

-- 2
UPDATE BUTTON SET activated = 1 WHERE activated = 0 AND name = 'Button1';

-- 5
COMMIT;
