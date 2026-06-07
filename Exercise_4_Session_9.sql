CREATE TABLE Sales
(
    sale_id     SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id  INT NOT NULL,
    sale_date   DATE,
    amount      INT NOT NULL
);

INSERT INTO Sales (customer_id, product_id, sale_date, amount)
VALUES (1, 101, '2026-01-15', 300),
       (2, 102, '2026-01-20', 1000),
       (3, 103, '2026-02-05', 50),
       (4, 104, '2026-02-10', 200),
       (5, 105, '2026-02-18', 40),
       (1, 106, '2026-03-01', 10000),
       (2, 107, '2026-03-12', 600),
       (3, 108, '2026-03-25', 20),
       (2, 109, '2026-04-02', 300),
       (1, 110, '2026-04-15', 700);

CREATE VIEW CustomerSales AS
SELECT customer_id, SUM(amount) total_amount
FROM Sales
GROUP BY customer_id;

SELECT *
FROM CustomerSales
WHERE total_amount > 1000;

-- Không cập nhật được VIEW vì nó ko còn là VIEW đơn giản nữa do tổng amount và GROUP BY customer_id


