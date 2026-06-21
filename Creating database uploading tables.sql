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
    
