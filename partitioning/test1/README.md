## 파티셔닝 테이블 생성 및 저장

파티셔닝을 활용한 테이블 생성 및 저장

### 시나리오

1. 날짜를 파티셔닝키로 지정하여 테이블을 생성한다.
```sql
CREATE TABLE LOG (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contents` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `created_at`)
) PARTITION BY RANGE (TO_DAYS(created_at)) (
	PARTITION P_202401 VALUES LESS THAN (TO_DAYS('2024-01-01')),
	PARTITION P_202402 VALUES LESS THAN (TO_DAYS('2024-02-01')),
	PARTITION P_202403 VALUES LESS THAN (TO_DAYS('2024-03-01')),
	PARTITION P_maxvalue VALUES LESS THAN MAXVALUE
);
```

2. 파티션이 잘 생성되었는지 확인한다.
- 쿼리
```sql
SELECT PARTITION_NAME,
       TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'LOG';
```
- 결과
```text
-------------------------------
| PARTITION_NAME | TABLE_ROWS |
| P_202401       |     0      |
| P_202402       |     0      |
| P_202403       |     0      |
| P_maxvalue     |     0      |
-------------------------------
```

2. 날짜별로 데이터를 저장한다.

```sql
INSERT INTO LOG
(contents, created_at)
VALUES
('contents 1', '2024-01-01 00:00:00'),
('contents 2', '2024-01-31 23:59:59'),
('contents 3', '2024-02-01 00:00:00'),
('contents 4', '2024-02-28 23:59:59'),
('contents 5', NOW());
```

3. 파티션에 데이터가 잘 저장되었는지 확인한다.
- 쿼리
```sql
SELECT PARTITION_NAME,
       TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'LOG';
```
- 결과
```text
-------------------------------
| PARTITION_NAME | TABLE_ROWS |
| P_202401       |     0      |
| P_202402       |     2      |
| P_202403       |     2      |
| P_maxvalue     |     1      |
-------------------------------
```
