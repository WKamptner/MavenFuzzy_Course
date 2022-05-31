USE mavenfuzzyfactory;

select * from website_pageviews where website_session_id = 1059;

select * from website_sessions where website_session_id = 1059;

Select * from orders where website_session_id = 1059;


SELECT a.utm_content,
	count(DISTINCT a.website_session_id) AS sessions,
	count(DISTINCT b.order_id)/count(Distinct a.website_session_id) as session_to_order_conv_rt /*number of orders over number of website sessions*/
    
FROM website_sessions a
	LEFT JOIN orders b
		ON a.website_session_id = b.website_session_id
        
WHERE a.website_session_id between 1000 AND 2000

	GROUP BY utm_content
	ORDER BY sessions DESC;
/* null - 18
b_ad_2 = 2
g_ad_1 - 975
g_ad_2 - 6 */