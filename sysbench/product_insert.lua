-- 데이터베이스 접속 초기화
function thread_init(thread_id)
    db_connect()
end

-- 랜덤 문자열 생성 함수
function generate_random_string(length)
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local random_string = ''
    for i = 1, length do
        local rand_index = sysbench.rand.default(1, #chars)
        random_string = random_string .. chars:sub(rand_index, rand_index)
    end
    return random_string
end

-- 각 스레드에서 실행할 이벤트
function event()
    -- bulk insert
    local bulk_size = 10000
    local values = {}

    for i = 1, bulk_size do
        local name = generate_random_string(15)
        local price = sysbench.rand.default(100, 10000)
        values[#values + 1] = string.format("('%s', %d)", name, price)
    end

    -- Bulk INSERT 쿼리 생성
    local query = "INSERT INTO PRODUCT (name, price) VALUES " .. table.concat(values, ", ")

    -- 쿼리 실행
    db_query(query)
end
