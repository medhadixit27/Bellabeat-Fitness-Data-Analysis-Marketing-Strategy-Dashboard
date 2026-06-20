# Bellabeat-Fitness-Data-Analysis-Marketing-Strategy-Dashboard

Situation:
Bellabeat, a high-tech wellness company for women, sought to understand how consumers use existing smart fitness devices in order to inform marketing strategy for one of their own product lines (Leaf, Time, or Spring). As a junior analyst on the marketing analytics team, I was tasked with analyzing third-party smart device usage data (FitBit Fitness Tracker Data, public dataset via Kaggle/Mobius) to surface behavioral trends that could be applied to Bellabeat's customer base and translated into actionable marketing recommendations.

Task:
The objective was threefold-

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


Tools Used
Python (Pandas), MySQL, Power BI (DAX, Power Query, Data Modeling), Tableau, Excel


# Dashboard Preview- 
