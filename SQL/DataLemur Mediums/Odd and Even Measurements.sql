-- First, I used a CTE to associate a row number with each measurement e.g 1st, 2nd, 3rd measurement of the day.
WITH measurement_ranking AS (SELECT     *,
                                        ROW_NUMBER() OVER (PARTITION BY measurement_time::DATE ORDER BY measurement_time ASC) AS measurement_rank
                                        -- ::DATE Casts the DATETIME to a DATE. This is useful since we want to partition our window function over the entire day as oppopsed to sppecific times.
                                        -- We want to order by the DATETIME version of measurement_time to get the order of the measurements throughout the day.
                            FROM        measurements)

-- Now we have the necessary data and can format it to the result
SELECT      measurement_time::DATE AS measurement_day,
            SUM(CASE WHEN measurement_rank % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
            SUM(CASE WHEN measurement_rank % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM        measurement_ranking
GROUP BY    measurement_day
ORDER BY    measurement_day ASC