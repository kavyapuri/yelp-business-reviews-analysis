create or replace table yelp_reviews (review_text variant)

COPY INTO yelp_reviews
FROM 's3://myawsyelp/Yelp/'
CREDENTIALS = (
    AWS_KEY_ID = '<YOUR_AWS_KEY>'
    AWS_SECRET_KEY = '<YOUR_AWS_SECRET>'
)
FILE_FORMAT = (TYPE = JSON);

CREATE OR REPLACE TABLE tbl_yelp_reviews AS 
SELECT review_text:business_id::string AS business_id,
review_text:date::date AS review_date,
review_text:user_id::string AS user_id,
review_text:stars::number AS review_stars,
review_text:text::string AS review_text,
analyze_sentiment(review_text) AS Sentiments
FROM yelp_reviews 

SELECT * FROM tbl_yelp_reviews limit 10
SELECT * FROM tbl_yelp_businesses limit 10