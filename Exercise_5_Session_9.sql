CREATE TABLE Sales
(
    sale_id     SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    sale_date   DATE,
    amount      INT NOT NULL
);

INSERT INTO Sales (customer_id, sale_date, amount)
VALUES (1, '2026-01-15', 300),
       (2, '2026-01-20', 1000),
       (3, '2026-02-05', 50),
       (4, '2026-02-10', 200),
       (5, '2026-02-18', 40),
       (1, '2026-03-01', 10000),
       (2, '2026-03-12', 600),
       (3, '2026-03-25', 20),
       (2, '2026-04-02', 300),
       (1, '2026-04-15', 700);

-- Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC)
CREATE OR REPLACE PROCEDURE calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC)
    language plpgsql
AS
$$
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

DO
$$
    DECLARE
        v_total NUMERIC;
    BEGIN
        CALL calculate_total_sales('2026-02-01', '2026-05-01', v_total);
        RAISE NOTICE 'tổng amount trong khoảng: %', v_total;
    END;
$$;



