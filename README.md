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
[Uploading Bell{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "deda814c-d0b3-439c-98a1-1a9224054dfe",
   "metadata": {
    "jupyter": {
     "source_hidden": true
    }
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "ActivityDate column standardized to MDY format.\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "df = pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\dailyActivity_merged.csv\")\n",
    "df['ActivityDate'] = pd.to_datetime(df['ActivityDate'], errors='coerce')\n",
    "df['ActivityDate'] = df['ActivityDate'].dt.strftime('%m/%d/%Y')\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\dailyActivity_cleaned.csv\", index=False)\n",
    "\n",
    "print(\"ActivityDate column standardized to MDY format.\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "2e8858ba-a183-443f-940f-98a6d6c7b850",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Medha\n"
     ]
    }
   ],
   "source": [
    "import os\n",
    "print(os.getcwd())"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "6391f5fc-7ec4-429d-be62-a07281102957",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "cc629ad6-79c2-4e0d-882c-95445895b476",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "0    04/12/2016\n",
      "1    04/13/2016\n",
      "2    04/14/2016\n",
      "3    04/15/2016\n",
      "4    04/16/2016\n",
      "5    04/17/2016\n",
      "6    04/18/2016\n",
      "7    04/19/2016\n",
      "8    04/20/2016\n",
      "9    04/21/2016\n",
      "Name: ActivityDate, dtype: object\n"
     ]
    }
   ],
   "source": [
    "print(df['ActivityDate'].head(10))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "5a449068-9cc7-4309-93ae-721428abeb8c",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "0   2016-04-12\n",
      "1   2016-04-13\n",
      "2   2016-04-14\n",
      "3   2016-04-15\n",
      "4   2016-04-16\n",
      "5   2016-04-17\n",
      "6   2016-04-18\n",
      "7   2016-04-19\n",
      "8   2016-04-20\n",
      "9   2016-04-21\n",
      "Name: ActivityDate, dtype: datetime64[ns]\n"
     ]
    }
   ],
   "source": [
    "df['ActivityDate'] = pd.to_datetime(df['ActivityDate'])\n",
    "print(df['ActivityDate'].head(10))\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "178fbe8d-0d61-4361-8b6d-4a35a827182a",
   "metadata": {},
   "outputs": [],
   "source": [
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\dailyActivity_merged.csv\", index=False)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "70f77253-fe56-42de-96a8-e71465fc02e5",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "0   2016-04-12\n",
      "1   2016-04-13\n",
      "2   2016-04-14\n",
      "3   2016-04-15\n",
      "4   2016-04-16\n",
      "5   2016-04-17\n",
      "6   2016-04-18\n",
      "7   2016-04-19\n",
      "8   2016-04-20\n",
      "9   2016-04-21\n",
      "Name: ActivityDay, dtype: datetime64[ns]\n",
      "ActivityDay column standardized to MDY format.\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\dailyCalories_merged.csv\")\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'], errors='coerce')\n",
    "df['ActivityDay'] = df['ActivityDay'].dt.strftime('%m/%d/%Y')\n",
    "\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'])\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\dailyCalories_cleaned.csv\", index=False)\n",
    "print(df['ActivityDay'].head(10))\n",
    "\n",
    "print(\"ActivityDay column standardized to MDY format.\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "6521d840-96c7-4439-adfc-8fcf32e43294",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "0   2016-04-12\n",
      "1   2016-04-13\n",
      "2   2016-04-14\n",
      "3   2016-04-15\n",
      "4   2016-04-16\n",
      "5   2016-04-17\n",
      "6   2016-04-18\n",
      "7   2016-04-19\n",
      "8   2016-04-20\n",
      "9   2016-04-21\n",
      "Name: ActivityDay, dtype: datetime64[ns]\n",
      "ActivityDay column standardized to MDY format.\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\dailyIntensities_merged.csv\")\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'], errors='coerce')\n",
    "df['ActivityDay'] = df['ActivityDay'].dt.strftime('%m/%d/%Y')\n",
    "\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'])\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\dailyIntensities_cleaned.csv\", index=False)\n",
    "print(df['ActivityDay'].head(10))\n",
    "\n",
    "print(\"ActivityDay column standardized to MDY format.\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "d24d290d-c2df-464a-9a01-bda9e1e32110",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "0   2016-04-12\n",
      "1   2016-04-13\n",
      "2   2016-04-14\n",
      "3   2016-04-15\n",
      "4   2016-04-16\n",
      "5   2016-04-17\n",
      "6   2016-04-18\n",
      "7   2016-04-19\n",
      "8   2016-04-20\n",
      "9   2016-04-21\n",
      "Name: ActivityDay, dtype: datetime64[ns]\n",
      "ActivityDay column standardized to MDY format.\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\dailySteps_merged.csv\")\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'], errors='coerce')\n",
    "df['ActivityDay'] = df['ActivityDay'].dt.strftime('%m/%d/%Y')\n",
    "\n",
    "df['ActivityDay'] = pd.to_datetime(df['ActivityDay'])\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\dailySteps_cleaned.csv\", index=False)\n",
    "print(df['ActivityDay'].head(10))\n",
    "\n",
    "print(\"ActivityDay column standardized to MDY format.\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "d4a0b830-5b1f-40f7-8a33-22a3bcefb74a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 2483658\n",
      "           Id                Time  Value  Date_Only Time_Only\n",
      "0  2022484408 2016-04-12 07:21:00     97 2016-04-12  07:21:00\n",
      "1  2022484408 2016-04-12 07:21:05    102 2016-04-12  07:21:05\n",
      "2  2022484408 2016-04-12 07:21:10    105 2016-04-12  07:21:10\n",
      "3  2022484408 2016-04-12 07:21:20    103 2016-04-12  07:21:20\n",
      "4  2022484408 2016-04-12 07:21:25    101 2016-04-12  07:21:25\n",
      "5  2022484408 2016-04-12 07:22:05     95 2016-04-12  07:22:05\n",
      "6  2022484408 2016-04-12 07:22:10     91 2016-04-12  07:22:10\n",
      "7  2022484408 2016-04-12 07:22:15     93 2016-04-12  07:22:15\n",
      "8  2022484408 2016-04-12 07:22:20     94 2016-04-12  07:22:20\n",
      "9  2022484408 2016-04-12 07:22:25     93 2016-04-12  07:22:25\n",
      "Id                    int64\n",
      "Time         datetime64[ns]\n",
      "Value                 int64\n",
      "Date_Only    datetime64[ns]\n",
      "Time_Only            object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "df = pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\heartrate_seconds_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['Time'] = pd.to_datetime(df['Time'], errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['Time'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['Time'].dt.time\n",
    "\n",
    "\n",
    "df['Time'] = pd.to_datetime(df['Time'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\heartrateSeconds_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "d0e8908a-454d-4251-be80-5e73d2515d79",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 22099\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Medha\\AppData\\Local\\Temp\\ipykernel_21164\\4286648169.py:4: UserWarning: Could not infer format, so each element will be parsed individually, falling back to `dateutil`. To ensure parsing is consistent and as-expected, please specify a format.\n",
      "  df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "           Id        ActivityHour  Calories  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00        81 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 01:00:00        61 2016-04-12  01:00:00\n",
      "2  1503960366 2016-04-12 02:00:00        59 2016-04-12  02:00:00\n",
      "3  1503960366 2016-04-12 03:00:00        47 2016-04-12  03:00:00\n",
      "4  1503960366 2016-04-12 04:00:00        48 2016-04-12  04:00:00\n",
      "5  1503960366 2016-04-12 05:00:00        48 2016-04-12  05:00:00\n",
      "6  1503960366 2016-04-12 06:00:00        48 2016-04-12  06:00:00\n",
      "7  1503960366 2016-04-12 07:00:00        47 2016-04-12  07:00:00\n",
      "8  1503960366 2016-04-12 08:00:00        68 2016-04-12  08:00:00\n",
      "9  1503960366 2016-04-12 09:00:00       141 2016-04-12  09:00:00\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "Calories                 int64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\hourlyCalories_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\heartrateSeconds_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "b942a818-7bb3-404f-8da7-ddcea2797e03",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 22099\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Medha\\AppData\\Local\\Temp\\ipykernel_21164\\1199371608.py:4: UserWarning: Could not infer format, so each element will be parsed individually, falling back to `dateutil`. To ensure parsing is consistent and as-expected, please specify a format.\n",
      "  df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "           Id        ActivityHour  TotalIntensity  AverageIntensity  \\\n",
      "0  1503960366 2016-04-12 00:00:00              20          0.333333   \n",
      "1  1503960366 2016-04-12 01:00:00               8          0.133333   \n",
      "2  1503960366 2016-04-12 02:00:00               7          0.116667   \n",
      "3  1503960366 2016-04-12 03:00:00               0          0.000000   \n",
      "4  1503960366 2016-04-12 04:00:00               0          0.000000   \n",
      "5  1503960366 2016-04-12 05:00:00               0          0.000000   \n",
      "6  1503960366 2016-04-12 06:00:00               0          0.000000   \n",
      "7  1503960366 2016-04-12 07:00:00               0          0.000000   \n",
      "8  1503960366 2016-04-12 08:00:00              13          0.216667   \n",
      "9  1503960366 2016-04-12 09:00:00              30          0.500000   \n",
      "\n",
      "   Date_Only Time_Only  \n",
      "0 2016-04-12  00:00:00  \n",
      "1 2016-04-12  01:00:00  \n",
      "2 2016-04-12  02:00:00  \n",
      "3 2016-04-12  03:00:00  \n",
      "4 2016-04-12  04:00:00  \n",
      "5 2016-04-12  05:00:00  \n",
      "6 2016-04-12  06:00:00  \n",
      "7 2016-04-12  07:00:00  \n",
      "8 2016-04-12  08:00:00  \n",
      "9 2016-04-12  09:00:00  \n",
      "Id                           int64\n",
      "ActivityHour        datetime64[ns]\n",
      "TotalIntensity               int64\n",
      "AverageIntensity           float64\n",
      "Date_Only           datetime64[ns]\n",
      "Time_Only                   object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\hourlyIntensities_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\hourlyIntensities_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "29a7f77a-53a4-4dcf-be0a-c2a221dd3d36",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 22099\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Medha\\AppData\\Local\\Temp\\ipykernel_21164\\1397591957.py:4: UserWarning: Could not infer format, so each element will be parsed individually, falling back to `dateutil`. To ensure parsing is consistent and as-expected, please specify a format.\n",
      "  df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "           Id        ActivityHour  StepTotal  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00        373 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 01:00:00        160 2016-04-12  01:00:00\n",
      "2  1503960366 2016-04-12 02:00:00        151 2016-04-12  02:00:00\n",
      "3  1503960366 2016-04-12 03:00:00          0 2016-04-12  03:00:00\n",
      "4  1503960366 2016-04-12 04:00:00          0 2016-04-12  04:00:00\n",
      "5  1503960366 2016-04-12 05:00:00          0 2016-04-12  05:00:00\n",
      "6  1503960366 2016-04-12 06:00:00          0 2016-04-12  06:00:00\n",
      "7  1503960366 2016-04-12 07:00:00          0 2016-04-12  07:00:00\n",
      "8  1503960366 2016-04-12 08:00:00        250 2016-04-12  08:00:00\n",
      "9  1503960366 2016-04-12 09:00:00       1864 2016-04-12  09:00:00\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "StepTotal                int64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\hourlySteps_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\hourlySteps_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "0cc685d5-18a7-4b26-a944-5ac6c8c90c72",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 1325580\n",
      "           Id      ActivityMinute  Calories  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00    0.7865 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 00:01:00    0.7865 2016-04-12  00:01:00\n",
      "2  1503960366 2016-04-12 00:02:00    0.7865 2016-04-12  00:02:00\n",
      "3  1503960366 2016-04-12 00:03:00    0.7865 2016-04-12  00:03:00\n",
      "4  1503960366 2016-04-12 00:04:00    0.7865 2016-04-12  00:04:00\n",
      "5  1503960366 2016-04-12 00:05:00    0.9438 2016-04-12  00:05:00\n",
      "6  1503960366 2016-04-12 00:06:00    0.9438 2016-04-12  00:06:00\n",
      "7  1503960366 2016-04-12 00:07:00    0.9438 2016-04-12  00:07:00\n",
      "8  1503960366 2016-04-12 00:08:00    0.9438 2016-04-12  00:08:00\n",
      "9  1503960366 2016-04-12 00:09:00    0.9438 2016-04-12  00:09:00\n",
      "Id                         int64\n",
      "ActivityMinute    datetime64[ns]\n",
      "Calories                 float64\n",
      "Date_Only         datetime64[ns]\n",
      "Time_Only                 object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteCaloriesNarrow_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityMinute'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityMinute'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteCaloriesNarrow_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "40337fdd-fc7f-476b-94e7-f2fef72e625a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 21645\n",
      "           Id        ActivityHour  Calories00  Calories01  Calories02  \\\n",
      "0  1503960366 2016-04-13 00:00:00      1.8876      2.2022      0.9438   \n",
      "1  1503960366 2016-04-13 01:00:00      0.7865      0.7865      0.7865   \n",
      "2  1503960366 2016-04-13 02:00:00      0.7865      0.7865      0.7865   \n",
      "3  1503960366 2016-04-13 03:00:00      0.7865      0.7865      0.7865   \n",
      "4  1503960366 2016-04-13 04:00:00      0.7865      0.7865      0.7865   \n",
      "5  1503960366 2016-04-13 05:00:00      0.7865      0.7865      0.7865   \n",
      "6  1503960366 2016-04-13 06:00:00      0.7865      0.7865      0.7865   \n",
      "7  1503960366 2016-04-13 07:00:00      0.7865      0.7865      0.7865   \n",
      "8  1503960366 2016-04-13 08:00:00      0.9438      0.7865      0.7865   \n",
      "9  1503960366 2016-04-13 09:00:00      0.9438      2.2022      2.0449   \n",
      "\n",
      "   Calories03  Calories04  Calories05  Calories06  Calories07  ...  \\\n",
      "0      0.9438      0.9438      2.0449      0.9438      2.2022  ...   \n",
      "1      0.7865      0.9438      0.9438      0.9438      0.7865  ...   \n",
      "2      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "3      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "4      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "5      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "6      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "7      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "8      0.7865      0.7865      0.7865      0.7865      0.7865  ...   \n",
      "9      2.5168      2.6741      2.2022      2.3595      2.0449  ...   \n",
      "\n",
      "   Calories52  Calories53  Calories54  Calories55  Calories56  Calories57  \\\n",
      "0      2.0449      0.9438      2.3595      1.8876      0.9438      0.9438   \n",
      "1      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "2      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "3      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "4      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "5      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "6      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "7      0.7865      0.7865      0.7865      0.7865      0.7865      0.7865   \n",
      "8      0.9438      0.9438      0.9438      0.7865      2.5168      0.9438   \n",
      "9      0.9438      0.9438      0.9438      0.7865      0.9438      0.9438   \n",
      "\n",
      "   Calories58  Calories59  Date_Only  Time_Only  \n",
      "0      0.9438      0.9438 2016-04-13   00:00:00  \n",
      "1      0.7865      0.7865 2016-04-13   01:00:00  \n",
      "2      0.7865      0.7865 2016-04-13   02:00:00  \n",
      "3      0.7865      0.7865 2016-04-13   03:00:00  \n",
      "4      0.7865      0.7865 2016-04-13   04:00:00  \n",
      "5      0.7865      0.7865 2016-04-13   05:00:00  \n",
      "6      0.7865      0.7865 2016-04-13   06:00:00  \n",
      "7      0.7865      2.2022 2016-04-13   07:00:00  \n",
      "8      2.8314      1.8876 2016-04-13   08:00:00  \n",
      "9      0.9438      5.3482 2016-04-13   09:00:00  \n",
      "\n",
      "[10 rows x 64 columns]\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "Calories00             float64\n",
      "Calories01             float64\n",
      "Calories02             float64\n",
      "                     ...      \n",
      "Calories57             float64\n",
      "Calories58             float64\n",
      "Calories59             float64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "Length: 64, dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteCaloriesWide_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteCaloriesWide_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "d387c685-41e4-4635-8fa5-2a2e282c0606",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 1325580\n",
      "           Id      ActivityMinute  Intensity  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00          0 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 00:01:00          0 2016-04-12  00:01:00\n",
      "2  1503960366 2016-04-12 00:02:00          0 2016-04-12  00:02:00\n",
      "3  1503960366 2016-04-12 00:03:00          0 2016-04-12  00:03:00\n",
      "4  1503960366 2016-04-12 00:04:00          0 2016-04-12  00:04:00\n",
      "5  1503960366 2016-04-12 00:05:00          0 2016-04-12  00:05:00\n",
      "6  1503960366 2016-04-12 00:06:00          0 2016-04-12  00:06:00\n",
      "7  1503960366 2016-04-12 00:07:00          0 2016-04-12  00:07:00\n",
      "8  1503960366 2016-04-12 00:08:00          0 2016-04-12  00:08:00\n",
      "9  1503960366 2016-04-12 00:09:00          0 2016-04-12  00:09:00\n",
      "Id                         int64\n",
      "ActivityMinute    datetime64[ns]\n",
      "Intensity                  int64\n",
      "Date_Only         datetime64[ns]\n",
      "Time_Only                 object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteIntensitiesNarrow_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityMinute'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityMinute'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteIntensitiesNarrow_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "bed670b2-81c9-4af6-996d-aa012a46eacb",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 21645\n",
      "           Id        ActivityHour  Intensity00  Intensity01  Intensity02  \\\n",
      "0  1503960366 2016-04-13 00:00:00            1            1            0   \n",
      "1  1503960366 2016-04-13 01:00:00            0            0            0   \n",
      "2  1503960366 2016-04-13 02:00:00            0            0            0   \n",
      "3  1503960366 2016-04-13 03:00:00            0            0            0   \n",
      "4  1503960366 2016-04-13 04:00:00            0            0            0   \n",
      "5  1503960366 2016-04-13 05:00:00            0            0            0   \n",
      "6  1503960366 2016-04-13 06:00:00            0            0            0   \n",
      "7  1503960366 2016-04-13 07:00:00            0            0            0   \n",
      "8  1503960366 2016-04-13 08:00:00            0            0            0   \n",
      "9  1503960366 2016-04-13 09:00:00            0            1            1   \n",
      "\n",
      "   Intensity03  Intensity04  Intensity05  Intensity06  Intensity07  ...  \\\n",
      "0            0            0            1            0            1  ...   \n",
      "1            0            0            0            0            0  ...   \n",
      "2            0            0            0            0            0  ...   \n",
      "3            0            0            0            0            0  ...   \n",
      "4            0            0            0            0            0  ...   \n",
      "5            0            0            0            0            0  ...   \n",
      "6            0            0            0            0            0  ...   \n",
      "7            0            0            0            0            0  ...   \n",
      "8            0            0            0            0            0  ...   \n",
      "9            1            1            1            1            1  ...   \n",
      "\n",
      "   Intensity52  Intensity53  Intensity54  Intensity55  Intensity56  \\\n",
      "0            1            0            1            1            0   \n",
      "1            0            0            0            0            0   \n",
      "2            0            0            0            0            0   \n",
      "3            0            0            0            0            0   \n",
      "4            0            0            0            0            0   \n",
      "5            0            0            0            0            0   \n",
      "6            0            0            0            0            0   \n",
      "7            0            0            0            0            0   \n",
      "8            0            0            0            0            1   \n",
      "9            0            0            0            0            0   \n",
      "\n",
      "   Intensity57  Intensity58  Intensity59  Date_Only  Time_Only  \n",
      "0            0            0            0 2016-04-13   00:00:00  \n",
      "1            0            0            0 2016-04-13   01:00:00  \n",
      "2            0            0            0 2016-04-13   02:00:00  \n",
      "3            0            0            0 2016-04-13   03:00:00  \n",
      "4            0            0            0 2016-04-13   04:00:00  \n",
      "5            0            0            0 2016-04-13   05:00:00  \n",
      "6            0            0            0 2016-04-13   06:00:00  \n",
      "7            0            0            1 2016-04-13   07:00:00  \n",
      "8            0            1            1 2016-04-13   08:00:00  \n",
      "9            0            0            1 2016-04-13   09:00:00  \n",
      "\n",
      "[10 rows x 64 columns]\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "Intensity00              int64\n",
      "Intensity01              int64\n",
      "Intensity02              int64\n",
      "                     ...      \n",
      "Intensity57              int64\n",
      "Intensity58              int64\n",
      "Intensity59              int64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "Length: 64, dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteIntensitiesWide_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteIntensitiesWide_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "a94fd539-821c-4696-b20a-9033fbbcd3df",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 1325580\n",
      "           Id      ActivityMinute  METs  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00    10 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 00:01:00    10 2016-04-12  00:01:00\n",
      "2  1503960366 2016-04-12 00:02:00    10 2016-04-12  00:02:00\n",
      "3  1503960366 2016-04-12 00:03:00    10 2016-04-12  00:03:00\n",
      "4  1503960366 2016-04-12 00:04:00    10 2016-04-12  00:04:00\n",
      "5  1503960366 2016-04-12 00:05:00    12 2016-04-12  00:05:00\n",
      "6  1503960366 2016-04-12 00:06:00    12 2016-04-12  00:06:00\n",
      "7  1503960366 2016-04-12 00:07:00    12 2016-04-12  00:07:00\n",
      "8  1503960366 2016-04-12 00:08:00    12 2016-04-12  00:08:00\n",
      "9  1503960366 2016-04-12 00:09:00    12 2016-04-12  00:09:00\n",
      "Id                         int64\n",
      "ActivityMinute    datetime64[ns]\n",
      "METs                       int64\n",
      "Date_Only         datetime64[ns]\n",
      "Time_Only                 object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteMETsNarrow_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityMinute'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityMinute'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteMETsNarrow_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "38972f76-a28e-431c-9a7c-c9ae5f1f5a31",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 188521\n",
      "           Id                date  value        logId  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 02:47:30      3  11380564589 2016-04-12  02:47:30\n",
      "1  1503960366 2016-04-12 02:48:30      2  11380564589 2016-04-12  02:48:30\n",
      "2  1503960366 2016-04-12 02:49:30      1  11380564589 2016-04-12  02:49:30\n",
      "3  1503960366 2016-04-12 02:50:30      1  11380564589 2016-04-12  02:50:30\n",
      "4  1503960366 2016-04-12 02:51:30      1  11380564589 2016-04-12  02:51:30\n",
      "5  1503960366 2016-04-12 02:52:30      1  11380564589 2016-04-12  02:52:30\n",
      "6  1503960366 2016-04-12 02:53:30      1  11380564589 2016-04-12  02:53:30\n",
      "7  1503960366 2016-04-12 02:54:30      2  11380564589 2016-04-12  02:54:30\n",
      "8  1503960366 2016-04-12 02:55:30      2  11380564589 2016-04-12  02:55:30\n",
      "9  1503960366 2016-04-12 02:56:30      2  11380564589 2016-04-12  02:56:30\n",
      "Id                    int64\n",
      "date         datetime64[ns]\n",
      "value                 int64\n",
      "logId                 int64\n",
      "Date_Only    datetime64[ns]\n",
      "Time_Only            object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteSleep_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['date'] = pd.to_datetime(df['date'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['date'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['date'].dt.time\n",
    "\n",
    "\n",
    "df['date'] = pd.to_datetime(df['date'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteSleep_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "810f96f1-38c7-4428-9f40-b53d041eb4ff",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 1325580\n",
      "           Id      ActivityMinute  Steps  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00      0 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 00:01:00      0 2016-04-12  00:01:00\n",
      "2  1503960366 2016-04-12 00:02:00      0 2016-04-12  00:02:00\n",
      "3  1503960366 2016-04-12 00:03:00      0 2016-04-12  00:03:00\n",
      "4  1503960366 2016-04-12 00:04:00      0 2016-04-12  00:04:00\n",
      "5  1503960366 2016-04-12 00:05:00      0 2016-04-12  00:05:00\n",
      "6  1503960366 2016-04-12 00:06:00      0 2016-04-12  00:06:00\n",
      "7  1503960366 2016-04-12 00:07:00      0 2016-04-12  00:07:00\n",
      "8  1503960366 2016-04-12 00:08:00      0 2016-04-12  00:08:00\n",
      "9  1503960366 2016-04-12 00:09:00      0 2016-04-12  00:09:00\n",
      "Id                         int64\n",
      "ActivityMinute    datetime64[ns]\n",
      "Steps                      int64\n",
      "Date_Only         datetime64[ns]\n",
      "Time_Only                 object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteStepsNarrow_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityMinute'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityMinute'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityMinute'] = pd.to_datetime(df['ActivityMinute'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteStepsNarrow_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "74f420c6-6937-4756-8816-299ec1b1a5cc",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 21645\n",
      "           Id        ActivityHour  Steps00  Steps01  Steps02  Steps03  \\\n",
      "0  1503960366 2016-04-13 00:00:00        4       16        0        0   \n",
      "1  1503960366 2016-04-13 01:00:00        0        0        0        0   \n",
      "2  1503960366 2016-04-13 02:00:00        0        0        0        0   \n",
      "3  1503960366 2016-04-13 03:00:00        0        0        0        0   \n",
      "4  1503960366 2016-04-13 04:00:00        0        0        0        0   \n",
      "5  1503960366 2016-04-13 05:00:00        0        0        0        0   \n",
      "6  1503960366 2016-04-13 06:00:00        0        0        0        0   \n",
      "7  1503960366 2016-04-13 07:00:00        0        0        0        0   \n",
      "8  1503960366 2016-04-13 08:00:00        0        0        0        0   \n",
      "9  1503960366 2016-04-13 09:00:00        0       14       10       31   \n",
      "\n",
      "   Steps04  Steps05  Steps06  Steps07  ...  Steps52  Steps53  Steps54  \\\n",
      "0        0        9        0       17  ...        8        0       20   \n",
      "1        0        0        0        0  ...        0        0        0   \n",
      "2        0        0        0        0  ...        0        0        0   \n",
      "3        0        0        0        0  ...        0        0        0   \n",
      "4        0        0        0        0  ...        0        0        0   \n",
      "5        0        0        0        0  ...        0        0        0   \n",
      "6        0        0        0        0  ...        0        0        0   \n",
      "7        0        0        0        0  ...        0        0        0   \n",
      "8        0        0        0        0  ...        0        0        0   \n",
      "9       37       17       25       12  ...        0        0        0   \n",
      "\n",
      "   Steps55  Steps56  Steps57  Steps58  Steps59  Date_Only  Time_Only  \n",
      "0        1        0        0        0        0 2016-04-13   00:00:00  \n",
      "1        0        0        0        0        0 2016-04-13   01:00:00  \n",
      "2        0        0        0        0        0 2016-04-13   02:00:00  \n",
      "3        0        0        0        0        0 2016-04-13   03:00:00  \n",
      "4        0        0        0        0        0 2016-04-13   04:00:00  \n",
      "5        0        0        0        0        0 2016-04-13   05:00:00  \n",
      "6        0        0        0        0        0 2016-04-13   06:00:00  \n",
      "7        0        0        0        0       16 2016-04-13   07:00:00  \n",
      "8        0       31        0       42        2 2016-04-13   08:00:00  \n",
      "9        0        0        0        0      105 2016-04-13   09:00:00  \n",
      "\n",
      "[10 rows x 64 columns]\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "Steps00                  int64\n",
      "Steps01                  int64\n",
      "Steps02                  int64\n",
      "                     ...      \n",
      "Steps57                  int64\n",
      "Steps58                  int64\n",
      "Steps59                  int64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "Length: 64, dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\minuteStepsWide_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\minuteStepsWide_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "c3b676fa-2540-4396-bb94-e5b115fb3faa",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 413\n",
      "           Id   SleepDay  TotalSleepRecords  TotalMinutesAsleep  \\\n",
      "0  1503960366 2016-04-12                  1                 327   \n",
      "1  1503960366 2016-04-13                  2                 384   \n",
      "2  1503960366 2016-04-15                  1                 412   \n",
      "3  1503960366 2016-04-16                  2                 340   \n",
      "4  1503960366 2016-04-17                  1                 700   \n",
      "5  1503960366 2016-04-19                  1                 304   \n",
      "6  1503960366 2016-04-20                  1                 360   \n",
      "7  1503960366 2016-04-21                  1                 325   \n",
      "8  1503960366 2016-04-23                  1                 361   \n",
      "9  1503960366 2016-04-24                  1                 430   \n",
      "\n",
      "   TotalTimeInBed  Date_Only Time_Only  \n",
      "0             346 2016-04-12  00:00:00  \n",
      "1             407 2016-04-13  00:00:00  \n",
      "2             442 2016-04-15  00:00:00  \n",
      "3             367 2016-04-16  00:00:00  \n",
      "4             712 2016-04-17  00:00:00  \n",
      "5             320 2016-04-19  00:00:00  \n",
      "6             377 2016-04-20  00:00:00  \n",
      "7             364 2016-04-21  00:00:00  \n",
      "8             384 2016-04-23  00:00:00  \n",
      "9             449 2016-04-24  00:00:00  \n",
      "Id                             int64\n",
      "SleepDay              datetime64[ns]\n",
      "TotalSleepRecords              int64\n",
      "TotalMinutesAsleep             int64\n",
      "TotalTimeInBed                 int64\n",
      "Date_Only             datetime64[ns]\n",
      "Time_Only                     object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\sleepDay_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['SleepDay'] = pd.to_datetime(df['SleepDay'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['SleepDay'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['SleepDay'].dt.time\n",
    "\n",
    "\n",
    "df['SleepDay'] = pd.to_datetime(df['SleepDay'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\sleepDay_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "c8dc8ade-2fbf-4a86-9fa2-d834b0be0adf",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 67\n",
      "           Id                Date    WeightKg  WeightPounds   Fat        BMI  \\\n",
      "0  1503960366 2016-05-02 23:59:59   52.599998    115.963147  22.0  22.650000   \n",
      "1  1503960366 2016-05-03 23:59:59   52.599998    115.963147   NaN  22.650000   \n",
      "2  1927972279 2016-04-13 01:08:52  133.500000    294.317120   NaN  47.540001   \n",
      "3  2873212765 2016-04-21 23:59:59   56.700001    125.002104   NaN  21.450001   \n",
      "4  2873212765 2016-05-12 23:59:59   57.299999    126.324875   NaN  21.690001   \n",
      "5  4319703577 2016-04-17 23:59:59   72.400002    159.614681  25.0  27.450001   \n",
      "6  4319703577 2016-05-04 23:59:59   72.300003    159.394222   NaN  27.379999   \n",
      "7  4558609924 2016-04-18 23:59:59   69.699997    153.662190   NaN  27.250000   \n",
      "8  4558609924 2016-04-25 23:59:59   70.300003    154.984977   NaN  27.459999   \n",
      "9  4558609924 2016-05-01 23:59:59   69.900002    154.103125   NaN  27.320000   \n",
      "\n",
      "   IsManualReport          LogId  Date_Only Time_Only  \n",
      "0            True  1462233599000 2016-05-02  23:59:59  \n",
      "1            True  1462319999000 2016-05-03  23:59:59  \n",
      "2           False  1460509732000 2016-04-13  01:08:52  \n",
      "3            True  1461283199000 2016-04-21  23:59:59  \n",
      "4            True  1463097599000 2016-05-12  23:59:59  \n",
      "5            True  1460937599000 2016-04-17  23:59:59  \n",
      "6            True  1462406399000 2016-05-04  23:59:59  \n",
      "7            True  1461023999000 2016-04-18  23:59:59  \n",
      "8            True  1461628799000 2016-04-25  23:59:59  \n",
      "9            True  1462147199000 2016-05-01  23:59:59  \n",
      "Id                         int64\n",
      "Date              datetime64[ns]\n",
      "WeightKg                 float64\n",
      "WeightPounds             float64\n",
      "Fat                      float64\n",
      "BMI                      float64\n",
      "IsManualReport              bool\n",
      "LogId                      int64\n",
      "Date_Only         datetime64[ns]\n",
      "Time_Only                 object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"C:\\Users\\Medha\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16 Editing\\weightLogInfo_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['Date'] = pd.to_datetime(df['Date'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['Date'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['Date'].dt.time\n",
    "\n",
    "\n",
    "df['Date'] = pd.to_datetime(df['Date'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\weightLogInfo_cleaned.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "fdf26059-1718-4ac4-9e03-ce49266e9b7c",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 22099\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Medha\\AppData\\Local\\Temp\\ipykernel_22892\\3145236544.py:5: UserWarning: Could not infer format, so each element will be parsed individually, falling back to `dateutil`. To ensure parsing is consistent and as-expected, please specify a format.\n",
      "  df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "           Id        ActivityHour  Calories  Date_Only Time_Only\n",
      "0  1503960366 2016-04-12 00:00:00        81 2016-04-12  00:00:00\n",
      "1  1503960366 2016-04-12 01:00:00        61 2016-04-12  01:00:00\n",
      "2  1503960366 2016-04-12 02:00:00        59 2016-04-12  02:00:00\n",
      "3  1503960366 2016-04-12 03:00:00        47 2016-04-12  03:00:00\n",
      "4  1503960366 2016-04-12 04:00:00        48 2016-04-12  04:00:00\n",
      "5  1503960366 2016-04-12 05:00:00        48 2016-04-12  05:00:00\n",
      "6  1503960366 2016-04-12 06:00:00        48 2016-04-12  06:00:00\n",
      "7  1503960366 2016-04-12 07:00:00        47 2016-04-12  07:00:00\n",
      "8  1503960366 2016-04-12 08:00:00        68 2016-04-12  08:00:00\n",
      "9  1503960366 2016-04-12 09:00:00       141 2016-04-12  09:00:00\n",
      "Id                       int64\n",
      "ActivityHour    datetime64[ns]\n",
      "Calories                 int64\n",
      "Date_Only       datetime64[ns]\n",
      "Time_Only               object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "df=pd.read_csv(r\"D:\\Bellabeat Project\\archive\\mturkfitbit_export_4.12.16-5.12.16\\Fitabase Data 4.12.16-5.12.16\\hourlyCalories_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'], errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['ActivityHour'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['ActivityHour'].dt.time\n",
    "\n",
    "\n",
    "df['ActivityHour'] = pd.to_datetime(df['ActivityHour'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\hourlyCalories.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "86b61212-9cac-44dd-a6f3-a0253f034031",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "File loaded. Total rows to process: 413\n",
      "           Id   SleepDay  TotalSleepRecords  TotalMinutesAsleep  \\\n",
      "0  1503960366 2016-04-12                  1                 327   \n",
      "1  1503960366 2016-04-13                  2                 384   \n",
      "2  1503960366 2016-04-15                  1                 412   \n",
      "3  1503960366 2016-04-16                  2                 340   \n",
      "4  1503960366 2016-04-17                  1                 700   \n",
      "5  1503960366 2016-04-19                  1                 304   \n",
      "6  1503960366 2016-04-20                  1                 360   \n",
      "7  1503960366 2016-04-21                  1                 325   \n",
      "8  1503960366 2016-04-23                  1                 361   \n",
      "9  1503960366 2016-04-24                  1                 430   \n",
      "\n",
      "   TotalTimeInBed  Date_Only Time_Only  \n",
      "0             346 2016-04-12  00:00:00  \n",
      "1             407 2016-04-13  00:00:00  \n",
      "2             442 2016-04-15  00:00:00  \n",
      "3             367 2016-04-16  00:00:00  \n",
      "4             712 2016-04-17  00:00:00  \n",
      "5             320 2016-04-19  00:00:00  \n",
      "6             377 2016-04-20  00:00:00  \n",
      "7             364 2016-04-21  00:00:00  \n",
      "8             384 2016-04-23  00:00:00  \n",
      "9             449 2016-04-24  00:00:00  \n",
      "Id                             int64\n",
      "SleepDay              datetime64[ns]\n",
      "TotalSleepRecords              int64\n",
      "TotalMinutesAsleep             int64\n",
      "TotalTimeInBed                 int64\n",
      "Date_Only             datetime64[ns]\n",
      "Time_Only                     object\n",
      "dtype: object\n"
     ]
    }
   ],
   "source": [
    "df=pd.read_csv(r\"D:\\Bellabeat Project\\archive\\mturkfitbit_export_4.12.16-5.12.16\\Fitabase Data 4.12.16-5.12.16\\sleepDay_merged.csv\")\n",
    "print(f\"File loaded. Total rows to process: {len(df)}\")\n",
    "\n",
    "df['SleepDay'] = pd.to_datetime(df['SleepDay'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')\n",
    "\n",
    "df['Date_Only'] = df['SleepDay'].dt.date\n",
    "\n",
    "df['Time_Only'] = df['SleepDay'].dt.time\n",
    "\n",
    "\n",
    "df['SleepDay'] = pd.to_datetime(df['SleepDay'])\n",
    "df['Date_Only'] = pd.to_datetime(df['Date_Only'])\n",
    "\n",
    "df.to_csv(r\"C:\\Users\\Medha\\Downloads\\sleepDay.csv\", index=False)\n",
    "\n",
    "\n",
    "print(df.head(10))\n",
    "print(df.dtypes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "99b3e2a8-5bdb-44f6-bbeb-959e644d9955",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.13.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
abeat.ipynb…]()


[Bellabeat.ipynb](https://github.com/user-attachments/files/29176867/Bellabeat.ipynb)




