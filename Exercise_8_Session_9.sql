CREATE TABLE Customers
(
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100),
    total_spent NUMERIC
);

CREATE TABLE Orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES Customers (customer_id),
    total_amount NUMERIC
);

INSERT INTO Customers (name, total_spent)
VALUES ('Nguyen Van A', 1),
       ('Tran Thi B', 2),
       ('Le Van C', 3),
       ('Pham Thi D', 2),
       ('Hoang Van E', 4);


INSERT INTO Orders (customer_id, total_amount)
VALUES (1, 3),
       (2, 2),
       (3, 5),
       (4, 1),
       (5, 4),
       (1, 2),
       (2, 6),
       (3, 3),
       (4, 7),
       (5, 2);

CREATE OR REPLACE PROCEDURE add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC)
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
        INSERT INTO Orders (customer_id, total_amount)
        VALUES (p_customer_id, p_amount);

        UPDATE Customers
        SET total_spent = total_spent + 1
        WHERE p_customer_id = customer_id;
    ELSE
        RAISE EXCEPTION 'Thêm đơn hàng thất bại';
    END IF;
END;
$$;

DO
$$
    BEGIN
        CALL add_order_and_update_customer(1, 20);
        CALL add_order_and_update_customer(10, 20);
    END;
$$;

SELECT *
FROM Customers;
SELECT *
FROM Orders;


