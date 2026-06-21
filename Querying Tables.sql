SELECT
    Id,
    ROUND(AVG(TotalSteps), 0) AS avg_steps,
    CASE
        WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
        WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
        WHEN AVG(TotalSteps) < 10000 THEN 'Active'
        ELSE                              'Very Active'
    END AS activity_segment
FROM daily_activity
GROUP BY Id
ORDER BY avg_steps;


WITH user_segments AS (
    SELECT
        Id,
        AVG(TotalSteps)        AS avg_steps,
        AVG(TotalDistance)     AS avg_distance,
        AVG(Calories)          AS avg_calories,
        AVG(SedentaryMinutes)  AS avg_sedentary_min,
        AVG(VeryActiveMinutes) AS avg_very_active_min,
        AVG(FairlyActiveMinutes) AS avg_fairly_active_min,
        AVG(LightlyActiveMinutes) AS avg_lightly_active_min,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment
    FROM daily_activity
    GROUP BY Id
)
SELECT
    activity_segment,
    COUNT(Id)                              AS user_count,
    ROUND(AVG(avg_steps), 0)              AS avg_steps,
    ROUND(AVG(avg_calories), 0)           AS avg_calories,
    ROUND(AVG(avg_distance), 2)           AS avg_distance_km,
    ROUND(AVG(avg_sedentary_min), 0)      AS avg_sedentary_min,
    ROUND(AVG(avg_sedentary_min)/60, 1)   AS avg_sedentary_hrs,
    ROUND(AVG(avg_very_active_min), 1)    AS avg_very_active_min,
    ROUND(AVG(avg_fairly_active_min), 1)  AS avg_fairly_active_min,
    ROUND(AVG(avg_lightly_active_min), 1) AS avg_lightly_active_min,
    ROUND(
        (AVG(avg_very_active_min) + AVG(avg_fairly_active_min)) / 960 * 100
    , 1)                                   AS pct_time_active
FROM user_segments
GROUP BY activity_segment
ORDER BY avg_steps;


WITH user_segments AS (
    SELECT
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment,
        AVG(TotalSteps) AS avg_steps_activity
    FROM daily_activity
    GROUP BY Id
)
SELECT
    s.Id,
    ROUND(AVG(s.TotalMinutesAsleep) / 60, 2)              AS avg_hours_asleep,
    ROUND(AVG(s.TotalTimeInBed - s.TotalMinutesAsleep), 1) AS avg_awake_in_bed_min,
    ROUND(AVG(a.TotalSteps), 0)                            AS avg_steps,
    ROUND(AVG(a.Calories), 0)                              AS avg_calories,
    us.activity_segment
FROM sleep_day s
JOIN daily_activity a
    ON s.Id = a.Id
    AND s.Date_Only = a.ActivityDate
JOIN user_segments us
    ON s.Id = us.Id
GROUP BY s.Id, us.activity_segment
ORDER BY avg_hours_asleep DESC;


WITH user_segments AS (
    SELECT
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment
    FROM daily_activity
    GROUP BY Id
)
SELECT
    a.Id,
    ROUND(AVG(a.SedentaryMinutes) / 60, 1)   AS avg_sedentary_hrs,
    ROUND(AVG(a.VeryActiveMinutes), 1)        AS avg_very_active_min,
    ROUND(AVG(a.FairlyActiveMinutes), 1)      AS avg_fairly_active_min,
    ROUND(AVG(a.LightlyActiveMinutes), 1)     AS avg_lightly_active_min,
    ROUND(
        (AVG(a.VeryActiveMinutes) + AVG(a.FairlyActiveMinutes)) / 960 * 100
    , 1)                                       AS pct_time_active,
    us.activity_segment
FROM daily_activity a
JOIN user_segments us
    ON a.Id = us.Id
GROUP BY a.Id, us.activity_segment
ORDER BY avg_sedentary_hrs DESC;


WITH user_segments AS (
    SELECT
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment
    FROM daily_activity
    GROUP BY Id
)
SELECT
    a.Id,
    COUNT(DISTINCT a.ActivityDate) AS days_worn,
    us.activity_segment,
    CASE
        WHEN COUNT(DISTINCT a.ActivityDate) >= 25 THEN 'High (25+ days)'
        WHEN COUNT(DISTINCT a.ActivityDate) >= 15 THEN 'Moderate (15-24 days)'
        ELSE                                           'Low (<15 days)'
    END AS wear_frequency
FROM daily_activity a
JOIN user_segments us
    ON a.Id = us.Id
GROUP BY a.Id, us.activity_segment
ORDER BY days_worn DESC;


WITH user_segments AS (
    SELECT
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment
    FROM daily_activity
    GROUP BY Id
)
SELECT
    DAYNAME(a.ActivityDate)                AS day_of_week,
    DAYOFWEEK(a.ActivityDate)              AS day_num,
    us.activity_segment,
    ROUND(AVG(a.TotalSteps), 0)           AS avg_steps,
    ROUND(AVG(a.Calories), 0)             AS avg_calories,
    ROUND(AVG(a.SedentaryMinutes), 0)     AS avg_sedentary_min
FROM daily_activity a
JOIN user_segments us
    ON a.Id = us.Id
GROUP BY
    DAYNAME(a.ActivityDate),
    DAYOFWEEK(a.ActivityDate),
    us.activity_segment
ORDER BY day_num, activity_segment;
 
 
 
 WITH user_segments AS (
    SELECT
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000  THEN 'Sedentary'
            WHEN AVG(TotalSteps) < 7500  THEN 'Lightly Active'
            WHEN AVG(TotalSteps) < 10000 THEN 'Active'
            ELSE                              'Very Active'
        END AS activity_segment
    FROM daily_activity
    GROUP BY Id
)
SELECT
    HOUR(hs.Time_Only)                    AS hour_of_day,
    us.activity_segment,
    ROUND(AVG(hs.StepTotal), 0)          AS avg_steps,
    COUNT(*)                              AS record_count
FROM hourly_steps hs
JOIN user_segments us
    ON hs.Id = us.Id
GROUP BY
    HOUR(hs.Time_Only),
    us.activity_segment
ORDER BY hour_of_day, activity_segment;