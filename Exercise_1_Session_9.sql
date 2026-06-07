CREATE TABLE Orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  VARCHAR(3) NOT NULL,
    order_date   DATE,
    total_amount INT
);

INSERT INTO Orders (customer_id, order_date, total_amount)
SELECT
    -- 1. Tạo ngẫu nhiên customer_id từ 'C01' đến 'C99' định dạng chuẩn VARCHAR(3)
    'C' || LPAD(floor(random() * 99 + 1)::text, 2, '0')          AS customer_id,

    -- 2. Tạo ngày đặt hàng ngẫu nhiên trong vòng 3 năm qua (khoảng 1095 ngày)
    CURRENT_DATE - (floor(random() * 1095) || ' days')::interval AS order_date,

    -- 3. Tạo giá trị đơn hàng ngẫu nhiên từ 50,000đ đến 5,000,000đ
    floor(random() * (5000000 - 50000 + 1) + 50000)::int         AS total_amount
FROM generate_series(1, 10000) AS i;

EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 'C26';

CREATE INDEX idx_customer_id ON Orders(customer_id);

-- Execution Time before create index: 1.202 ms
-- Execution Time after create index: 0.219 ms