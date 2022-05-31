/* We've been live for almost a month now and we're starting to generate sales
Can you help me understand where the bulk of our website sessions are coming from, through yesterday (April 11, 2012)
I'd like to see a breakdown by UTM source, campaign, and referring domain */

select utm_source, utm_campaign, http_referer, count(distinct website_session_id) as sessions from website_sessions 
where created_at < '2012-04-12' 
group by utm_source, utm_campaign, http_referer
order by sessions DESC;

/* assignment 2 */
Select
	count(distinct w.website_session_id) as sessions,
	count(distinct o.order_id) as orders,
    count(distinct o.order_id)/count(distinct w.website_session_id) as session_to_order_conv_rate
FROM website_sessions w
left join orders o
	on w.website_session_id = o.website_session_id
where w.created_at < '2012-04-14'
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand';


/* pivoting data using count and case*/

select order_id,
primary_product_id,
items_purchased,
created_at
from orders
where order_id between 31000 and 32000;

select
	Primary_product_id,
    count(Distinct CASE
			when items_purchased = 1 THEN order_id
            ELSE null END) as orders_w_1_item,
    count(Distinct CASE
			when items_purchased = 2 THEN order_id
            ELSE null END) as orders_w_2_item,       
	count(DISTINCT order_id) as total_orders
from orders
WHERE order_id between 31000 and 32000
group by 1;


select
    MIN(DATE(created_at)) as week_start_date,
	count(distinct website_session_id) as sessions
from
website_sessions
WHERE created_at < '2012-05-10'
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand'
GROUP BY week(created_at), year(created_at);


Select
	ws.device_type,
    count(distinct ws.website_session_id) as sessions,
    count(distinct o.order_id) as orders,
    count(distinct o.order_id) / count(distinct ws.website_session_id) as session_to_order_conv_rate
FROM
	website_sessions ws
LEFT JOIN
	orders o
ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-05-11'
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand'
GROUP BY device_type
ORDER BY 1 DESC;


select
    MIN(DATE(created_at)) as week_start_date,
	count(DISTINCT CASE
    WHEN device_type = "mobile" 
    then website_session_id
        else null 
	end)  as mob_sessions,
    	count(DISTINCT CASE
    WHEN device_type = "desktop" 
    then website_session_id
        else null 
	end)  as dtop_sessions
from website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-06-06'
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand'
GROUP BY week(created_at)
ORDER BY 1 ASC
;
