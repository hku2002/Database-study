
--1
START TRANSACTION;

--2
SELECT * FROM STOCK WHERE id = 1 FOR UPDATE;

--5
COMMIT;
