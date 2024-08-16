-- product_insert.lua

-- 데이터베이스 접속 초기화
function thread_init(thread_id)
   db_connect()
end

-- 각 스레드에서 실행할 이벤트
function event()
   local id = sysbench.rand.default(1, 1000000)
   local name = string.format("Product_%d", id)
   local price = sysbench.rand.default(100, 10000)

   -- id, name, price 값을 삽입하는 쿼리
   local query = string.format("INSERT INTO PRODUCT (name, price) VALUES ('%s', %d)",
                               name, price)

   -- 쿼리 실행
   db_query(query)
end
