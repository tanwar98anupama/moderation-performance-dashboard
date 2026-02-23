# Video Safety Operations - Moderation Performance Dashboard

## Project Overview
An end-to-end moderation analytics system simulating a Trust & Safety 
operations reporting pipeline. Built to mirror real VSO team workflows 
including metric design, root cause analysis, and performance dashboards.

## Problem Statement
Moderation accuracy dropped in March 2024. This project diagnoses the 
root cause and presents actionable recommendations via an interactive dashboard.

## Key Finding
Hate Speech accuracy collapsed to 57-61% across all shifts in March 
while all other categories maintained 85-90%. Root cause identified as 
a category-level policy gap, not a staffing issue.

## Tech Stack
- Python (pandas, matplotlib, seaborn) - Data generation & root cause analysis
- SQL Server (SSMS) - Data storage & analyst queries
- Tableau Public - Interactive dashboard

## Project Structure
```
moderation_dashboard/
│
├── data/                  # Generated CSV files
├── sql/                   # All SQL queries
├── notebooks/             # Jupyter notebooks
└── tableau/               # Tableau workbook
```

## SQL Queries Built
- Daily accuracy rate monitoring
- Monthly scorecard by content category  
- Reviewer-level performance scorecard
- Root cause detection (Feb vs March comparison)
- Rolling 7-day accuracy trend

## Dashboard
[View Live Dashboard on Tableau Public](https://public.tableau.com/app/profile/anupama.v.rathod/viz/VSOModerationDashboard/VSOPerformanceDashboard)

## Key Insights
- Hate Speech was the sole driver of March accuracy drop
- All shifts equally affected — ruling out staffing as root cause
- Recommended: Policy refresher training + dedicated Hate Speech KPI tracking



