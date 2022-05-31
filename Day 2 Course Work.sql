USE mazenfuzzyfactory;



CREATE temporary TABLE first_pageview
select 
	website_session_id,
    MIN(website_pageview_id) as min_pv_id
from website_pageviews
WHERE website_pageview_id < 1000
group by website_session_id
;


select
website_pageviews.pageview_url as landing_page,
COUNT(distinct first_pageview.website_session_id) as sessions
 from first_pageview
	LEFT JOIN website_pageviews
		on first_pageview.min_pv_id = website_pageviews.website_pageview_id
GROUP BY 1;

select pageview_url,
count(distinct website_session_id) as sessions
 from website_pageviews
 where created_at < '2012-06-09'
 group by 1
 order by 2 DESC;
 


CREATE temporary table first_pv_per_session
select 
	website_session_id,
    min(website_pageview_id) as first_pv
from website_pageviews
where created_at < '2012-06-12'
group by 1;


select website_pageviews.pageview_url as landing_page_url,
count(distinct first_pv_per_session.website_session_id) as sessions
from first_pv_per_session
left join website_pageviews
	on first_pv_per_session.first_pv = website_pageviews.website_pageview_id
group by 1;


-- Get list of session id's that land on the /home page
-- Get list of session_id's that move on to another page
-- calculate the rate of those going to the next page

-- list of session id's that land on the home page
CREATE TEMPORARY TABLE landing_page
select * from website_pageviews
WHERE
created_at < '2012-06-14'
AND pageview_url = '/home';


Create temporary table good_clicks
select distinct a.website_session_id
 from website_pageviews a
LEFT JOIN landing_page b
on a.website_pageview_id = b.website_pageview_id
where
a.created_at < '2012-06-14'
and b.website_pageview_id is NULL;

select * from landing_page;
select * from good_clicks;

select 
count(distinct a.website_session_id) as sessions,

sum(case WHEN b.website_session_id is null
then 1
else 0
END) as bounced_sessions,

sum(case WHEN b.website_session_id is null
then 1
else 0
END) / count(distinct a.website_session_id) as bounce_rate

 from landing_page a
left join good_clicks b
on a.website_session_id = b.website_session_id
where
created_at < '2012-06-14'
;
