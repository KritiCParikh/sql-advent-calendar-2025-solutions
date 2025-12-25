-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

WITH previous_scores AS (
    SELECT
        log_date,
        mischief_score,
        LAG(mischief_score) OVER (ORDER BY log_date) AS prev_score
    FROM grinch_mischief_log
)
SELECT
    log_date,
    mischief_score,
    COALESCE(mischief_score - prev_score, 0) AS change,
    CASE 
        WHEN COALESCE(mischief_score - prev_score, 0) > 0 THEN CONCAT('+', mischief_score - prev_score)
        WHEN COALESCE(mischief_score - prev_score, 0) < 0 THEN CONCAT('-', ABS(mischief_score - prev_score))
        ELSE '0'
    END AS increase_decrease
FROM previous_scores
ORDER BY log_date;
