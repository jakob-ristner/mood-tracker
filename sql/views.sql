CREATE OR REPLACE VIEW dates_this_year AS
SELECT 
    generate_series(
        DATE_TRUNC('year', CURRENT_DATE), 
        DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' - INTERVAL '1 day',
        INTERVAL '1 day'
    ) AS date;

DROP VIEW IF EXISTS pe_logs_curr_year CASCADE;
CREATE OR REPLACE VIEW pe_logs_curr_year AS
SELECT
    d.date,
    u.id AS user_id,
    u.uuid AS user_uuid,
    u.email AS user_email,
    u.name AS user_name,
    COALESCE(pl.score, 0.5) AS pleasant_score,
    COALESCE(el.score, 0.5) AS energy_score
FROM 
    dates_this_year d
CROSS JOIN 
    Users u
LEFT JOIN 
    PleasantLogs pl
ON 
    u.id = pl.user_id AND d.date::DATE = pl.log_date::DATE
LEFT JOIN 
    EnergyLogs el
ON 
    u.id = el.user_id AND d.date::DATE = el.log_date::DATE
WHERE
    d.date < NOW();

