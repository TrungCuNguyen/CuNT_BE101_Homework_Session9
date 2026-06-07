CREATE TABLE Products
(
    product_id  SERIAL PRIMARY KEY,
    category_id INT     NOT NULL,
    name        VARCHAR(100),
    price       NUMERIC NOT NULL
);

INSERT INTO Products (category_id, name, price)
VALUES (1, 'Laptop Dell Inspiron', 1500.00),
       (1, 'MacBook Air M2', 1200.00),
       (2, 'iPhone 15 Pro', 999.00),
       (2, 'Samsung Galaxy S24', 899.00),
       (3, 'Sony WH-1000XM5 Headphones', 350.00),
       (3, 'Logitech MX Master 3 Mouse', 120.00),
       (4, 'LG 55-inch OLED TV', 1800.00),
       (4, 'Samsung 65-inch QLED TV', 2000.00),
       (5, 'Canon EOS R Camera', 2500.00),
       (5, 'Nikon Z6 II Camera', 2200.00);

-- Tạo Procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC) để tăng giá tất cả sản phẩm trong một category_id theo phần trăm
CREATE OR REPLACE PROCEDURE update_product_price(p_category_id INT, p_increase_percent NUMERIC)
    language plpgsql
AS
$$
DECLARE
    v_item      RECORD;
    v_new_price NUMERIC;
BEGIN
    FOR v_item IN SELECT product_id, price FROM Products
        LOOP
            v_new_price := v_item.price * (1 + p_increase_percent / 100);
            UPDATE Products
            SET price = v_new_price
            WHERE v_item.product_id = product_id;
        END LOOP;
END;
$$;

DO
$$
    BEGIN
        CALL update_product_price(1, 50);
    END;
$$;

SELECT *
FROM Products;


