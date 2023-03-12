-- ANALYZING TOP TRAFFIC SOURCES
SELECT 
    website_sessions.utm_content,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM
    website_sessions
        LEFT JOIN
    orders ON orders.website_session_id = website_sessions.website_session_id
WHERE
    website_sessions.website_session_id BETWEEN 1000 AND 2000
GROUP BY 1
ORDER BY 2 DESC;

-- ASSIGMENT: FINDING TOP TRAFFIC SOURCES
/* We've been live for almost a month now and we've starting to generate sales. Can you help me understand where the bulk
of our website sessions are coming from, through yesterday?

I'd like to see a breakdown by UTM source, campaign, and referring domain if possible. */

SELECT 
    utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS number_of_sessions
FROM
    website_sessions
WHERE
    created_at < '2012-04-12'
GROUP BY 1 , 2 , 3
ORDER BY 4 DESC;

-- ASSIGMENT: TRAFFIC SOURCE CONEVRSION RATES
/* Sounds like gsearch nonbrand is our major traffic source, but we need to understand if those sessions are driving sales.

Could you please calculate the conversion rate (CVR) from session to order? Based on what we're paying for clicks, we'll
need a CVR of at least 4% to make the numbers work.

If we're much lower, we'll need to reduce bids. If we're higher, we can increase bids to drive more volume. */

SELECT 
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS session_to_order_conv_rate
FROM
    website_sessions ws
        LEFT JOIN
    orders o ON o.website_session_id = ws.website_session_id
WHERE
    ws.created_at < '2012-04-12'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand';

/* Looks like we're below the 4% threshold we need to make the economics work. Based on this analysis, we'll need
to dial down our serach bids a bit. We're over-spending based on the current conversion rate. */
