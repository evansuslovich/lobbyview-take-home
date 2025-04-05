----------------
-- Part C


-- First implementation, listing the registrants by unique bill counts
-- SELECT
--     filings.registrant_id,
--     COUNT(DISTINCT filing_bills.bill_id) AS unique_bills_count
-- FROM analyst.filings AS filings
--          JOIN analyst.filings_bills AS filing_bills
--               ON filings.filing_uuid = filing_bills.filing_uuid
-- WHERE filing_bills.general_issue_code = 'MMM'
-- GROUP BY filings.registrant_id;

-- getting unique bills in Medicare/Medicaid issue category of most lobbying registrant
WITH most_lobbying_registrant AS (
    SELECT
        filings.registrant_id,
        COUNT(DISTINCT filing_bills.bill_id) AS unique_bills_count
    FROM analyst.filings AS filings
             JOIN analyst.filings_bills AS filing_bills
                  ON filings.filing_uuid = filing_bills.filing_uuid
    WHERE filing_bills.general_issue_code = 'MMM'
    GROUP BY filings.registrant_id
    ORDER BY unique_bills_count desc
    LIMIT 1
)
SELECT filings.registrant_id, filing_bills.bill_id
FROM analyst.filings AS filings
         JOIN analyst.filings_bills AS filing_bills -- get filing bills
              ON filings.filing_uuid = filing_bills.filing_uuid
         JOIN most_lobbying_registrant AS mlr -- get filings from registrant_id
              ON filings.registrant_id = mlr.registrant_id
WHERE filing_bills.general_issue_code = 'MMM'
GROUP BY filings.registrant_id, filing_bills.bill_id
LIMIT 10;