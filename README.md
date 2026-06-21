# Bellabeat-Fitness-Data-Analysis-Marketing-Strategy-Dashboard

Situation:
Bellabeat, a high-tech wellness company for women, sought to understand how consumers use existing smart fitness devices in order to inform marketing strategy for one of their own product lines (Leaf, Time, or Spring). As a junior analyst on the marketing analytics team, I was tasked with analyzing third-party smart device usage data (FitBit Fitness Tracker Data, public dataset via Kaggle/Mobius) to surface behavioral trends that could be applied to Bellabeat's customer base and translated into actionable marketing recommendations.

Task:The objective was threefold-

Identify trends in how users engage with fitness-tracking smart devices across activity levels
Determine how those trends apply to Bellabeat's target customers
Translate those insights into concrete, high-level marketing strategy recommendations for the Bellabeat executive team

The deliverable: an end-to-end analysis — from raw data cleaning through an interactive dashboard — supporting a clear business narrative and presentable findings.

Action:
Data Cleaning & Preparation (Python)
Used Python (Pandas) to clean and standardize inconsistent date/time formats across 15+ raw FitBit datasets. Applied datetime parsing and segmentation logic to handle data volume that exceeded what Excel could reliably process, ensuring consistency before loading into the database layer.

Data Processing (SQL)
Queried and joined 10+ relational tables in MySQL Workbench using JOINs, subqueries, and aggregations to consolidate daily activity, sleep, and device-wear data into analysis-ready tables. Resolved schema/view errors during this stage to ensure query reliability.

Data Modeling & Analysis (Power BI)
Built a Power BI data model by establishing relationships between the cleaned SQL-sourced tables. Authored DAX measures and calculated columns (including sort-by-column logic and RANKX-based ranking) to segment 33 users into four activity tiers — Sedentary, Lightly Active, Active, and Very Active — based on average daily steps.

Dashboard Design:
Designed an interactive Power BI dashboard featuring-
1.A segment-based slicer enabling dynamic filtering across all visuals
2.KPI cards summarizing average calories, steps, sedentary hours, and active minutes
3.A scatter plot (with trend line) testing the relationship between steps and calories burned
4.Visualizations of weekly activity rhythm, device-wear consistency, and sleep duration by segment

The analysis surfaced several insights that directly inform marketing strategy:

88% of users maintained high device engagement (25+ days of wear), indicating that adherence is not Bellabeat's core challenge — translating tracked data into actionable outcomes is
Sedentary time remained high across all activity segments (13.5–19.6 hrs/day), including the most active users, showing that increased activity does not offset prolonged inactivity
Sleep duration declined ~36% from least to most active users (7.3 hrs → 4.7 hrs), revealing a sleep/activity tradeoff that activity-tracking alone doesn't address
Every segment showed a consistent midweek activity dip (Wed–Fri) with a rebound on Saturday, challenging the conventional "Monday motivation" marketing cadence used across the fitness industry

Recommendations delivered:
Shift Bellabeat's marketing from pure activity-tracking toward actionable insight delivery (e.g., flagging sleep/activity tradeoffs to users)
Launch campaigns timed to the observed midweek dip rather than generic Monday-themed content
Position Bellabeat products around holistic wellness (sleep + activity + recovery) rather than step-count-centric messaging


# Tools Used
Python (Pandas), MySQL, Power BI (DAX, Power Query, Data Modeling), Tableau, Excel


# Dashboard Preview- 
<img width="1920" height="1020" alt="Screenshot 2026-06-21 184824" src="https://github.com/user-attachments/assets/54b1b177-72ee-48f3-9c5d-b2f4070ba501" />
<img width="1920" height="1020" alt="Screenshot 2026-06-21 184851" src="https://github.com/user-attachments/assets/66e5f4b8-ed06-439d-a645-3b5c7d16c875" />
<img width="1920" height="1020" alt="Screenshot 2026-06-21 184916" src="https://github.com/user-attachments/assets/e6cc6675-db68-4518-a1b7-33b879b9d0d7" />
<img width="1920" height="1020" alt="Screenshot 2026-06-21 184927" src="https://github.com/user-attachments/assets/bbbe5f2b-a1cf-4e9f-bd17-e312554612c9" />
<img width="1920" height="1020" alt="Screenshot 2026-06-21 184937" src="https://github.com/user-attachments/assets/360e8043-a17b-491c-91a4-e711e2eb5726" />


Bellabeat Dataset Source:
https://www.kaggle.com/datasets/arashnic/fitbit

#SQL Files-
[Creating database uploading tables.sql](https://github.com/user-attachments/files/29176712/Creating.database.uploading.tables.sql)

CREATE DATABASE bellabeat;
USE bellabeat;
CREATE TABLE IF NOT EXISTS daily_activity (
    Id BIGINT,
    ActivityDate DATE,
    TotalSteps INT,
    TotalDistance FLOAT,
    TrackerDistance FLOAT,
    LoggedActivitiesDistance FLOAT,
    VeryActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    SedentaryActiveDistance FLOAT,
    VeryActiveMinutes INT,
    FairlyActiveMinutes INT,
    LightlyActiveMinutes INT,
    SedentaryMinutes INT,
    Calories INT
);
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/dailyActivity.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT * 
FROM daily_activity
LIMIT 10;

CREATE TABLE IF NOT EXISTS daily_calories (
    Id BIGINT,
    ActivityDay DATE,
    Calories INT
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/dailyCalories.csv'
INTO TABLE daily_calories
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT *
FROM daily_calories
LIMIT 10;

CREATE TABLE IF NOT EXISTS daily_intensities (
    Id BIGINT,
    ActivityDay DATE,
    SedentaryMinutes INT,
    LightlyActiveMinutes INT,
    FairlyActiveMinutes INT,
    VeryActiveMinutes INT,
    SedentaryActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    VeryActiveDistance FLOAT
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/dailyIntensities.csv'
INTO TABLE daily_intensities
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT *
FROM daily_intensities
LIMIT 10;

CREATE TABLE IF NOT EXISTS daily_steps (
    Id BIGINT,
    ActivityDay DATE,
    StepTotal INT
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/dailySteps.csv'
INTO TABLE daily_steps
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT *
FROM daily_steps
LIMIT 10;
SELECT COUNT(*)
FROM daily_steps;

CREATE TABLE IF NOT EXISTS heartrate_minutes (
	Id BIGINT,
    Times DATETIME,
    Rate INT,
    Dateonly DATE,
    Timeonly DATETIME
    );
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/heartrate_seconds.csv'
INTO TABLE daily_steps
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
DROP TABLE IF EXISTS heartrate_minutes;

CREATE TABLE heartrate_seconds (
    Id BIGINT,
    Times DATETIME,
    Rate INT,
    Dateonly DATE,
    Timeonly TIME  
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/heartrateSeconds.csv'
INTO TABLE heartrate_seconds
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT COUNT(*)
FROM heartrate_seconds;
SELECT *
FROM heartrate_seconds
LIMIT 10;

CREATE TABLE IF NOT EXISTS hourly_intensities (
    Id BIGINT,
    ActivityHour DATETIME,
    TotalIntensity INT,
    AverageIntensity DECIMAL(10, 6), -- Using DECIMAL to handle the 6 decimal places shown
    Date_Only DATE,
    Time_Only TIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/hourlyIntensities.csv'
INTO TABLE hourly_intensities
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT *
FROM hourly_intensities
LIMIT 10;

CREATE TABLE IF NOT EXISTS hourly_steps (
    Id BIGINT,
    ActivityHour DATETIME,
    StepTotal INT,
    Date_Only DATE,
    Time_Only TIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/hourlySteps.csv'
INTO TABLE hourly_steps
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS hourly_calories (
    Id BIGINT,
    ActivityHour DATETIME,
    Calories INT
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/hourlyCalories.csv'
INTO TABLE hourly_calories
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SHOW WARNINGS;

DROP TABLE IF EXISTS hourly_calories;

CREATE TABLE hourly_calories (
    Id BIGINT,
    ActivityHour DATETIME,
    Calories INT,
    Date_Only DATE,
    Time_Only TIME
);

-- 2. Load the data
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/hourlyCalories.csv'
INTO TABLE hourly_calories
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS minute_calories_narrow (
    Id BIGINT, ActivityMinute DATETIME, Calories DECIMAL(10,2), Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteCaloriesNarrow.csv'
INTO TABLE minute_calories_narrow 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS;
SHOW WARNINGS;
DROP TABLE IF EXISTS minute_calories_narrow;
CREATE TABLE IF NOT EXISTS minute_calories_narrow (
    Id BIGINT,
    ActivityMinute DATETIME,
    Calories DOUBLE,
    Date_Only DATE,
    Time_Only TIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteCaloriesNarrow.csv'
INTO TABLE minute_calories_narrow
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT * FROM minute_calories_narrow LIMIT 5;

CREATE TABLE minute_calories_wide (
    Id BIGINT, 
    ActivityHour DATETIME,
    Calories00 DOUBLE, Calories01 DOUBLE, Calories02 DOUBLE, Calories03 DOUBLE, Calories04 DOUBLE,
    Calories05 DOUBLE, Calories06 DOUBLE, Calories07 DOUBLE, Calories08 DOUBLE, Calories09 DOUBLE,
    Calories10 DOUBLE, Calories11 DOUBLE, Calories12 DOUBLE, Calories13 DOUBLE, Calories14 DOUBLE,
    Calories15 DOUBLE, Calories16 DOUBLE, Calories17 DOUBLE, Calories18 DOUBLE, Calories19 DOUBLE,
    Calories20 DOUBLE, Calories21 DOUBLE, Calories22 DOUBLE, Calories23 DOUBLE, Calories24 DOUBLE,
    Calories25 DOUBLE, Calories26 DOUBLE, Calories27 DOUBLE, Calories28 DOUBLE, Calories29 DOUBLE,
    Calories30 DOUBLE, Calories31 DOUBLE, Calories32 DOUBLE, Calories33 DOUBLE, Calories34 DOUBLE,
    Calories35 DOUBLE, Calories36 DOUBLE, Calories37 DOUBLE, Calories38 DOUBLE, Calories39 DOUBLE,
    Calories40 DOUBLE, Calories41 DOUBLE, Calories42 DOUBLE, Calories43 DOUBLE, Calories44 DOUBLE,
    Calories45 DOUBLE, Calories46 DOUBLE, Calories47 DOUBLE, Calories48 DOUBLE, Calories49 DOUBLE,
    Calories50 DOUBLE, Calories51 DOUBLE, Calories52 DOUBLE, Calories53 DOUBLE, Calories54 DOUBLE,
    Calories55 DOUBLE, Calories56 DOUBLE, Calories57 DOUBLE, Calories58 DOUBLE, Calories59 DOUBLE,
    Date_Only DATE, 
    Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteCaloriesWide.csv'
INTO TABLE minute_calories_wide FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS minute_intensities_narrow (
    Id BIGINT, ActivityMinute DATETIME, Intensity INT, Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteIntensitiesNarrow.csv'
INTO TABLE minute_intensities_narrow FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE minute_intensities_wide (
    Id BIGINT, 
    ActivityHour DATETIME,
    Intensity00 INT, Intensity01 INT, Intensity02 INT, Intensity03 INT, Intensity04 INT,
    Intensity05 INT, Intensity06 INT, Intensity07 INT, Intensity08 INT, Intensity09 INT,
    Intensity10 INT, Intensity11 INT, Intensity12 INT, Intensity13 INT, Intensity14 INT,
    Intensity15 INT, Intensity16 INT, Intensity17 INT, Intensity18 INT, Intensity19 INT,
    Intensity20 INT, Intensity21 INT, Intensity22 INT, Intensity23 INT, Intensity24 INT,
    Intensity25 INT, Intensity26 INT, Intensity27 INT, Intensity28 INT, Intensity29 INT,
    Intensity30 INT, Intensity31 INT, Intensity32 INT, Intensity33 INT, Intensity34 INT,
    Intensity35 INT, Intensity36 INT, Intensity37 INT, Intensity38 INT, Intensity39 INT,
    Intensity40 INT, Intensity41 INT, Intensity42 INT, Intensity43 INT, Intensity44 INT,
    Intensity45 INT, Intensity46 INT, Intensity47 INT, Intensity48 INT, Intensity49 INT,
    Intensity50 INT, Intensity51 INT, Intensity52 INT, Intensity53 INT, Intensity54 INT,
	Intensity55 INT, Intensity56 INT, Intensity57 INT, Intensity58 INT, Intensity59 INT,
    Date_Only DATE, 
    Time_Only TIME
    );
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteIntensitiesWide.csv'
INTO TABLE minute_intensities_wide FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS minute_mets_narrow (
    Id BIGINT, ActivityMinute DATETIME, METs INT, Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteMETsNarrow.csv'
INTO TABLE minute_mets_narrow FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
    
CREATE TABLE IF NOT EXISTS minute_sleep (
    Id BIGINT, date DATETIME, value INT, logId BIGINT, Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteSleep.csv'
INTO TABLE minute_sleep FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS minute_steps_narrow (
    Id BIGINT, ActivityMinute DATETIME, Steps INT, Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteStepsNarrow.csv'
INTO TABLE minute_steps_narrow FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS minute_steps_wide (
    Id BIGINT, ActivityHour DATETIME,
    Steps00 INT, Steps01 INT, Steps02 INT, Steps03 INT, Steps04 INT,
    Steps05 INT, Steps06 INT, Steps07 INT, Steps08 INT, Steps09 INT,
    Steps10 INT, Steps11 INT, Steps12 INT, Steps13 INT, Steps14 INT,
	Steps15 INT, Steps16 INT, Steps17 INT, Steps18 INT, Steps19 INT,
    Steps20 INT, Steps21 INT, Steps22 INT, Steps23 INT, Steps24 INT,
    Steps25 INT, Steps26 INT, Steps27 INT, Steps28 INT, Steps29 INT,
    Steps30 INT, Steps31 INT, Steps32 INT, Steps33 INT, Steps34 INT,
    Steps35 INT, Steps36 INT, Steps37 INT, Steps38 INT, Steps39 INT,
    Steps40 INT, Steps41 INT, Steps42 INT, Steps43 INT, Steps44 INT,
    Steps45 INT, Steps46 INT, Steps47 INT, Steps48 INT, Steps49 INT,
    Steps50 INT, Steps51 INT, Steps52 INT, Steps53 INT, Steps54 INT,
	Steps55 INT, Steps56 INT, Steps57 INT, Steps58 INT, Steps59 INT,
    Date_Only DATE, Time_Only TIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/minuteStepsWide.csv'
INTO TABLE minute_steps_wide FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS sleep_day (
    Id BIGINT, SleepDay DATETIME, TotalSleepRecords INT, TotalMinutesAsleep INT, TotalTimeInBed INT, Date_Only DATE, Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/sleepDay.csv'
INTO TABLE sleep_day FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
DROP TABLE IF EXISTS sleep_day;

CREATE TABLE IF NOT EXISTS weight_log_info (
    Id BIGINT,
    Date_Time DATETIME,
    WeightKg DOUBLE,
    WeightPounds DOUBLE,
    Fat VARCHAR(10), -- Using VARCHAR to safely import empty/null values
    BMI DOUBLE,
    IsManualReport BOOLEAN,
    LogId BIGINT,
    Date_Only DATE,
    Time_Only TIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/weightLogInfo.csv'
INTO TABLE weight_log_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
-- Use variables (@) for columns that need transformation
(Id, Date_Time, WeightKg, WeightPounds, @vFat, BMI, @vIsManualReport, LogId, Date_Only, Time_Only)
SET 
    -- Fix for the 'True/False' text issue
    IsManualReport = CASE 
        WHEN @vIsManualReport = 'True' THEN 1 
        WHEN @vIsManualReport = 'False' THEN 0 
        ELSE NULL 
    END,
    -- Keeps your existing fix for empty Fat values
    Fat = NULLIF(@vFat, '');
    
    CREATE TABLE IF NOT EXISTS sleep_day (
    Id BIGINT,
    SleepDay DATETIME,
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT,
    Date_Only DATE,
    Time_Only TIME
);

-- 2. Load the data from the CSV
LOAD DATA LOCAL INFILE 'C:/Users/Medha/OneDrive/Desktop/Date Time Corrected Files FitBit/sleepDay.csv'
INTO TABLE sleep_day
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = 'bellabeat'
ORDER BY 
    TABLE_NAME, 
    ORDINAL_POSITION;



    [Querying Tables.sql](https://github.com/user-attachments/files/29176719/Querying.Tables.sql)


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



Aggregated Results of Queries Final Table in Excel that was loaded in Power BI for further analysis:
[Bellabeat_Dashboard_Data.xlsx](https://github.com/user-attachments/files/29176738/Bellabeat_Dashboard_Data.xlsx)

Bellabeat DAX and measures used during analysis:
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/b4787b97-7bad-4643-b3f2-9e60a1121a73" />

Bellabeat Data Modeling:
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/29342d05-6c25-4bab-97a0-cd58ca31acce" />

Bellbeat Python Script:
[Bellabeat.ipynb](https://github.com/user-attachments/files/29176867/Bellabeat.ipynb)




