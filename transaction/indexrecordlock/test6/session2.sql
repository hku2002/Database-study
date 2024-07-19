
-- 3
START TRANSACTION;

-- 4
UPDATE BUTTON SET activated = 0 WHERE activated = 1 AND name = 'Button1';

-- 8
COMMIT;
