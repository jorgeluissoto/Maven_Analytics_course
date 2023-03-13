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

-- BID OPTIMIZATION & TREND ANALYSIS
SELECT 
    YEAR(created_at),
    WEEK(created_at),
    MIN(DATE(created_at)) AS week_start,
    COUNT(DISTINCT website_session_id) AS session
FROM
    website_sessions
WHERE
    website_session_id BETWEEN 100000 AND 115000
GROUP BY 1 , 2;

-- PIVOTING DATE WITH COUNT & CASE
SELECT 
    primary_product_id,
    COUNT(DISTINCT CASE
            WHEN items_purchased = 1 THEN order_id
            ELSE NULL
        END) AS count_single_item_orders,
    COUNT(DISTINCT CASE
            WHEN items_purchased = 2 THEN order_id
            ELSE NULL
        END) AS count_single_items_orders
FROM
    orders
WHERE
    order_id BETWEEN 31000 AND 32000
GROUP BY 1;

-- ASSIGNMENT: TRAFFIC SOURCE TRENDING
/* Based on your conversion rate analysis , we bid down gsearch nonbrand on 2012-04-15.alter
Can you pull gsearch nonbrand trended session volume, by week, to see if the bid changes have caused volume 
to drop at all? */
SELECT 
    MIN(DATE(created_at)) AS week_start,
    COUNT(DISTINCT website_session_id) AS sessions
FROM
    website_sessions
WHERE
    created_at < '2012-05-10'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);

-- You can see a decline in volume after 4/8  
 
-- ASSIGNMENT: BID OPTIMIZATION FOR PAID TRAFFIC
/*I was trying to use our site on my mobile device the other day, and the experince was not great.

Could you pull conversion rates from session to order, by device type?

If desktop performance is better than on mobile we may be able to bid up for desktop specifically to get more volume? */

SELECT 
    website_sessions.device_type,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM
    website_sessions
        LEFT JOIN
    orders ON orders.website_session_id = website_sessions.website_session_id
WHERE
    website_sessions.created_at < '2012-05-11'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY 1;

-- 3.7% conversion on desktop compared to 0.9% on mobile. Increase bids on desktop 
