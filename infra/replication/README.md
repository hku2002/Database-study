## Replication mysql 구성

1. mysql 2개를 생성
2. master 에서 File 과 Position 조회
```shell
docker exec -it mysql-master bash
mysql -uroot -p
```
```sql
show master status;
```
3. master 정보를 바탕으로 replica 서버에서 다음 세팅 진행
```shell
docker exec -it mysql-replica bash
mysql -uroot -p
```

```sql
CHANGE MASTER TO
    MASTER_HOST='mysql-master',
    MASTER_PORT=3306,
    MASTER_USER='root',
    MASTER_PASSWORD='1234',
    MASTER_LOG_FILE='mysql-bin.000001', # master 에서 조회한 file 정보
    MASTER_LOG_POS=157, # master 에서 조회한 position 정보
    MASTER_CONNECT_RETRY=60,
    GET_MASTER_PUBLIC_KEY=1;

start slave;
```

4. 완료