-- 10 Questions

-- Q1. Find the number of businesses in each category.
-- SELECT * FROM tbl_yelp_reviews limit 10
WITH cte AS (
SELECT business_id, TRIM(A.value) AS category
FROM tbl_yelp_businesses,
lateral split_to_table(categories,',') A
)
SELECT category, COUNT(*)
FROM cte
GROUP BY 1
ORDER BY 2 DESC




-- Q2. Find the top 10 users who have reviewed the most businesses in the "Restaurants" category.



SELECT r.user_id, count(DISTINCT r.business_id)
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
WHERE b.categories ilike '%Restaurants%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- Q3. Find the most popular categories of businesses (based on the number of reviews)

WITH cte AS (
SELECT business_id, TRIM(A.value) AS category
FROM tbl_yelp_businesses,
LATERAL split_to_table (categories, ',') A
)
SELECT category, count(*)
FROM cte 
JOIN tbl_yelp_reviews r ON r.business_id = cte.business_id
GROUP BY 1
ORDER BY 2 DESC

-- Find the top 3 most recent reviews for each business 

WITH cte AS (
SELECT r.*, b.name,
row_number() OVER (PARTITION BY r.business_id ORDER BY REVIEW_DATE DESC) AS rn
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b
ON r.business_id = b.business_id
)
SELECT * 
FROM cte 
WHERE rn <=3 

-- Find the month with the highest number of reviews

SELECT monthname(review_date) AS review_month, count(*) AS number_of_reviews
FROM tbl_yelp_reviews
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- FInd the % of 5 star reviews for each business
SELECT b.business_id,b.name, count(*) AS total_reviews,
SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) AS Five_star_review,
Five_star_review*100/total_reviews AS review_percent
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b 
ON b.business_id = r.business_id
GROUP BY 1,2

-- Find the top 5 most reviewed business in each city
WITH cte AS (
SELECT b.business_id, b.name, b.city, count(*) AS total_reviews
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON b.business_id = r.business_id
GROUP BY 1,2,3
)
SELECT *
FROM cte
qualify row_number() OVER (PARTITION BY city ORDER BY total_reviews DESC) <=5

-- Find the average rating of businesses that have atleast 100 reviews
SELECT b.business_id, b.name, count(*) AS total_reviews, AVG(review_stars) AS average_rating
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON b.business_id = r.business_id
GROUP BY 1,2
HAVING count(*) >=100

-- List the top 10 users who have written the most reviews along with the businesses they reviewed
WITH cte AS (
SELECT r.user_id, count(*)
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON b.business_id = r.business_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
)
SELECT user_id, business_id 
FROM tbl_yelp_reviews
WHERE user_id in (SELECT user_id FROM cte)

-- FIND top 10 businesses with highest positive sentiment views

SELECT b.business_id, b.name, count(*) AS total_reviews
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON b.business_id = r.business_id
WHERE sentiments = 'Positive'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10