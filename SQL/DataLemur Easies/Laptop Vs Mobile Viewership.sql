SELECT      SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
            SUM(CASE WHEN (device_type = 'tablet') OR (device_type = 'phone') THEN 1 ELSE 0 END) AS mobile_views
            -- SUM CASE WHEN statements essentially act as a tallying system.
                -- For example, in the first SUM CASE WHEN, every time a row has device_type = 'laptop', we add 1 to laptop_views
                -- After traversing through every row, we would have the total number of laptop viewers.
            -- The same logic applies for the 2nd SUM CASE WHEN statement.
FROM        viewership