create database vso_dashboard;

use vso_dashboard;

create table moderation_logs (
	id int IDENTITY(1,1) PRIMARY KEY,
	date DATE NOT NULL,
	reviewer_id varchar(10) not null,
	content_category varchar(50) not null,
	shift varchar(20),
	region varchar(10),
	decision_outcome varchar(20),
	correct_decision bit,
	processing_time_mins decimal(5,2),
	sla_breached bit
	);

	select * from moderation_logs;


-- Daily Accuracy Rate::
--How accurate is moderation each day?
	select 
		date,
		count(*) as total_decisions,
		sum(cast (correct_decision as int)) as correct_decisions,
		sum(cast (correct_decision as int))*100/count(*) as accuracy_rate_percentage
	from 
		moderation_logs
	group by 
		date
	order by
		date;
	-- accuracy rate down in march


--Which content type is hardest to moderate accurately?
select
	FORMAT(date, 'yyyy-MM') as month_of,
	content_category,
	count(*) as total_cases,
	sum(cast(correct_decision as int))*100/count(*) as accuracy_perc,
	round(avg(processing_time_mins),2) as avg_procc_time,
	sum(cast(sla_breached as int)) as sla_breaches
from 
	moderation_logs
group by
	FORMAT(date, 'yyyy-MM'), content_category
order by
	month_of, accuracy_perc;


-- Reviewer Scorecard
--Individual reviewer performance (like an employee scorecard)
select
	reviewer_id,
	count(*) as total_cases,
	round(sum(cast(correct_decision as int)),2) *100/count(*) as accuracy_per,
	round(avg(processing_time_mins),2) as avg_proc_time,
	sum(cast(sla_breached as int)) as total_sla_breached,
	round(sum(cast(sla_breached as int))*100/count(*),2) as sla_breach_rate_perc
from 
	moderation_logs
group by 
	reviewer_id
order by 
	accuracy_per;



--Root Cause Detection
--When accuracy drops, which category/shift/region is causing it?
select top 30
	format( date, 'yyyy-MM') as month,
	content_category,
	shift,
	region,
	count(*) as cases,
	round(sum(cast(correct_decision as int))*100/count(*),2) as accuracy_per
from
	moderation_logs
where
	format( date, 'yyyy-MM') in ('2024-02', '2024-03')     --compare feb vs march
group by format( date, 'yyyy-MM'), content_category,shift,region
order by
	accuracy_per;



--Rolling 7-Day Average (Trend Monitoring)
--Smooth out daily noise to see real trends
select
	date,
	round(avg(correct_dec_per) over (order by date rows between 6 preceding  and current row),2) as rolling_7d_accuracy
from
	(select
		date,
		count(*) total_no,
		round(sum(cast(correct_decision as int))*100.0/ count(*),2) as correct_dec_per
	from 
		moderation_logs
	group by 
		date) as daily_accuracy
order by
	date