-- 데이터베이스 접속 정보 설정
function thread_init(thread_id)
   db_connect()
end

-- 각 스레드에서 실행할 작업 정의
function event()
   -- INSERT 쿼리 예시
   local table_name = "PRODUCT"
   local name = string.format("Product_%d", id)
   local price = sysbench.rand.default(100, 10000)
   local query = string.format("INSERT INTO PRODUCT (id, name, price) VALUES (%d, '%s', %d)",
                                  id, name, price)

   db_query(query)
end
