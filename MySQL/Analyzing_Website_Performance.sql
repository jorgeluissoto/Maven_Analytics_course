-- ANALYZING WEBSITE PERFORMANCE

/* Analyzing Top Website Pages & Entry Pages */

-- Top Content Overall 
SELECT 
    pageview_url, COUNT(DISTINCT website_pageview_id) AS pvs
FROM
    website_pageviews
WHERE
    website_pageview_id < 1000
GROUP BY 1
ORDER BY pvs DESC;

-- Creating Temporary Tables
-- Find the first page a user landed on 
CREATE TEMPORARY TABLE first_pageview
SELECT 
    website_session_id,
    MIN(website_pageview_id) AS min_pv_id
FROM
    website_pageviews
WHERE
    website_pageview_id < 1000
GROUP BY 1;

-- Use your Temp Table in a Join Statement 
SELECT 
    website_pageviews.pageview_url AS landing_page,
    COUNT(DISTINCT first_pageview.website_session_id) AS sessions_hitting_this_lander
FROM
    first_pageview
        LEFT JOIN
    website_pageviews ON first_pageview.min_pv_id = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url;

-- ASSIGNMENT: Finding Top Website Pages
/*  Could you help me get my head around the site by pulling the most_viewed website pages, ranked by session volume? */

SELECT 
    pageview_url,
    COUNT(DISTINCT website_pageview_id) AS sessions
FROM
    website_pageviews
WHERE
    created_at < '2012-06-09'
GROUP BY 1
ORDER BY 2 DESC;

/* It definitely seems like the homepage, the product page, and the Mr.Fuzzy page get the bulk of our traffic. I would 
like to understand traffic pattern more */

-- ASSIGNMENT: FINDING TOP ENTRY PAGES
/* Would you be able to pull a list of the top entry pages? I want to confirm where our users are hitting the site.

If you could pull all entry pages and rank them on entry volume, that would be great */

-- Step1: find the first pageview for each session
-- Step 2: find the url the customer saw on that first pageview
CREATE TEMPORARY TABLE second_pageview
SELECT 
    website_session_id,
    MIN(website_pageview_id) AS min_pv_id
FROM
    website_pageviews
WHERE
    created_at < '2012-06-12'
GROUP BY 1;

SELECT *
FROM second_pageview;

SELECT 
    website_pageviews.pageview_url AS landing_page,
    COUNT(DISTINCT second_pageview.website_session_id) AS sessions_hitting_this_landing_page
FROM
    second_pageview
        LEFT JOIN
    website_pageviews ON second_pageview.min_pv_id = website_pageviews.website_pageview_id
WHERE
    created_at < '2012-06-12'
GROUP BY website_pageviews.pageview_url;
-- Focus on the home page and improving it 

-- ANALYZING BOUNCE RATES & LANDING PAGE TESTING
-- BUSINESS CONTEXT: we want to see landing page performance for a certain time period

-- STEP 1: find the first website_pageview_id for relevant session
-- STEP 2: identify the landing page of each session
-- STEP 3: counting pageviews for each session, to indentify "bounces"
-- STEP 4: summarizing total sessions and bounced sessions, by landing page

-- finding the minimum website pageview id associatd with each session we care about
SELECT 
    wp.website_session_id,
    MIN(wp.website_pageview_id) AS min_pageview_id
FROM
    website_pageviews wp
        INNER JOIN
    website_sessions ws ON ws.website_session_id = wp.website_session_id
        AND ws.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY wp.website_session_id;

-- same query as above, but this time we are storing the dataset as a temporary table
CREATE TEMPORARY TABLE first_pageviews_demo
SELECT 
    wp.website_session_id,
    MIN(wp.website_pageview_id) AS min_pageview_id
FROM
    website_pageviews wp
        INNER JOIN
    website_sessions ws ON ws.website_session_id = wp.website_session_id
        AND ws.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY wp.website_session_id;

-- next, we'll bring in the landing page to each session    
CREATE TEMPORARY TABLE sessions_w_landing_page_demo_2
SELECT fpd.website_session_id, wp.pageview_url AS landing_page
FROM first_pageviews_demo fpd
	LEFT JOIN website_pageviews wp
		ON wp.website_pageview_id = fpd.min_pageview_id;
        
SELECT * FROM sessions_w_landing_page_demo_2;
-- next, we make a table to include a count of pageviews per session

-- first, I'll show you all of the sessions. Then we will limit to bounced session and create a temp table

CREATE TEMPORARY TABLE bounced_sessions_only
SELECT 
    slpd.website_session_id,
    slpd.landing_page,
    COUNT(wp.website_pageview_id) AS count_of_pages_viewed
FROM
    sessions_w_landing_page_demo_2 slpd
        LEFT JOIN
    website_pageviews wp ON wp.website_session_id = slpd.website_session_id
GROUP BY slpd.website_session_id , slpd.landing_page
HAVING COUNT(wp.website_pageview_id) = 1;

-- we will do this first, then we will summarize with a count after:
SELECT 
    slpd.landing_page,
    slpd.website_session_id,
    bso.website_session_id AS bounced_website_session_id
FROM
    sessions_w_landing_page_demo_2 slpd
        LEFT JOIN
    bounced_sessions_only bso ON slpd.website_session_id = bso.website_session_id
ORDER BY slpd.website_session_id;

-- final output
	-- we will use the same query we previoouly ran, and run a count of records
    -- we will group by landing page, and then we'll add a bounce rate column
SELECT 
    slpd.landing_page,
    COUNT(DISTINCT slpd.website_session_id) AS sessions,
    COUNT(DISTINCT bso.website_session_id) AS bounced_session,
    COUNT(DISTINCT bso.website_session_id)/ COUNT(DISTINCT slpd.website_session_id) AS bounce_rate
FROM
    sessions_w_landing_page_demo_2 slpd
        LEFT JOIN
    bounced_sessions_only bso ON slpd.website_session_id = bso.website_session_id
GROUP BY slpd.landing_page;
