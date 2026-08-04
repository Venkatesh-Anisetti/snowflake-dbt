{{
    config( materialized = "view",
            database = "ecom_db",
            schema = "marts"
            )
}}

SELECT
    CUSTOMER_ID,
    LOGIN_DATE,
    LAST_LOGIN,
    DATEDIFF(DAYS, LAST_LOGIN, LOGIN_DATE) AS DAYS_BTW_
FROM (
    SELECT  CUSTOMER_ID,
            LOGIN_DATE,
            LAG(LOGIN_DATE) OVER(PARTITION BY CUSTOMER_ID ORDER BY LOGIN_DATE) AS LAST_LOGIN,
    FROM {{source("raw","customer_login")}}
    )