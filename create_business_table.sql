create or replace table yelp_businesses (business_text variant)

COPY INTO yelp_businesses
FROM 's3://myawsyelp/Yelp/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = '<YOUR_AWS_KEY>'
    AWS_SECRET_KEY = '<YOUR_AWS_SECRET>'
)
FILE_FORMAT = (TYPE = JSON);

CREATE OR REPLACE TABLE tbl_yelp_businesses AS
SELECT business_text:business_id::string AS business_id,
business_text:name::string AS name,
business_text:city::string AS city,
business_text:state::string AS state,
business_text:review_count::string AS review_count,
business_text:stars::number AS Stars,
business_text:categories::string AS categories

FROM yelp_businesses 

SELECT * FROM tbl_yelp_businesses