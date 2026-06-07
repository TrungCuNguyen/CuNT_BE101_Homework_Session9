CREATE TABLE Products
(
    product_id     SERIAL PRIMARY KEY,
    category_id    VARCHAR(10) NOT NULL,
    price          NUMERIC,
    stock_quantity INT
);

INSERT INTO Products (category_id, price, stock_quantity)
SELECT
    -- 1. Tạo ngẫu nhiên category_id từ 'CAT01' đến 'CAT20'
    'CAT' || LPAD(floor(random() * 20 + 1)::text, 2, '0') AS category_id,

    -- 2. Tạo giá ngẫu nhiên từ 10.00 đến 1000.00 (làm tròn 2 chữ số thập phân)
    ROUND((random() * (1000 - 10) + 10)::numeric, 2)      AS price,

    -- 3. Tạo số lượng tồn kho ngẫu nhiên từ 0 đến 500 sản phẩm
    floor(random() * 501)::int                            AS stock_quantity
FROM generate_series(1, 10000) AS i;

EXPLAIN ANALYZE
SELECT *
FROM Products
WHERE category_id = 'CAT15'
ORDER BY price;

CREATE INDEX idx_products_category_id ON Products (category_id);
CLUSTER Products USING idx_products_category_id;

CREATE INDEX idx_products_price ON Products (price);

-- Execution Time before create index: 1.893 ms
-- Execution Time after create index: 0.421 ms