-- Assumption: retrieving a registrants' id is adequate----------------
-- Part A
-- coalesce function returns the first non-null value in set https://www.w3schools.com/sql/func_sqlserver_coalesce.asp
-- I could have also done: 'WHERE f.amount IS NOT NULL', but I think coalesce is powerful 
SELECT r.registrant_id, SUM(f.amount) as total
FROM analyst.registrants AS r
         JOIN analyst.filings AS f ON r.registrant_id = f.registrant_id
GROUP BY r.registrant_id
HAVING COALESCE(SUM(amount::numeric), 0) > 10000000
LIMIT 10;
--  (converting from money type to numeric) https://www.postgresql.org/docs/current/datatype-money.html

