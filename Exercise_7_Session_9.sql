CREATE TABLE Customers
(
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100),
    email       VARCHAR(100) NOT NULL
);

CREATE TABLE Orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers (customer_id),
    amount      INT,
    order_date  DATE
);

INSERT INTO Customers (name, email)
VALUES ('Nguyen Van A', 'vana@example.com'),
       ('Tran Thi B', 'thib@example.com'),
       ('Le Van C', 'vanc@example.com'),
       ('Pham Thi D', 'thid@example.com'),
       ('Hoang Van E', 'vane@example.com');


INSERT INTO Orders (customer_id, amount, order_date)
VALUES (1, 3, '2026-01-10'),
       (2, 2, '2026-01-15'),
       (3, 5, '2026-01-20'),
       (4, 1, '2026-02-01'),
       (5, 4, '2026-02-05'),
       (1, 2, '2026-02-10'),
       (2, 6, '2026-02-18'),
       (3, 3, '2026-03-01'),
       (4, 7, '2026-03-12'),
       (5, 2, '2026-03-20');

-- Tạo Procedure add_order(p_customer_id INT, p_amount NUMERIC) để thêm đơn hàng
CREATE OR REPLACE PROCEDURE add_order(p_customer_id INT, p_amount NUMERIC)
    language plpgsql
AS
$$
DECLARE
    v_customer_id_find INT;
BEGIN
    SELECT customer_id
    INTO v_customer_id_find
    FROM Customers;
    IF p_customer_id = v_customer_id_find THEN
        INSERT INTO Orders (customer_id, amount, order_date)
        VALUES (p_customer_id, p_amount, CURRENT_DATE);
    ELSE
        RAISE EXCEPTION 'Khong ton tai khach hang';
    END IF;
END;
$$;

DO
$$
    BEGIN
        CALL add_order(1, 20);
    END;
$$;

SELECT *
FROM Orders;


