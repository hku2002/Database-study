
sysbench ./product_insert.lua \
  --db-driver=mysql \
  --mysql-host=127.0.0.1 \
  --mysql-port=3306 \
  --mysql-user=root \
  --mysql-password=1234 \
  --mysql-db=study \
  --threads=1 \
  --events=1000 \
  --time=0 \
run
