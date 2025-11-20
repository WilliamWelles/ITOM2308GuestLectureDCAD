/********************************************************************
*																	*
*	Title: Average Single Family Residence Comparison 2023 - 2024	*
*																	*
*	Description: Two Common Table Expressions (CTE) are created. 	*
*		One for the current year 2024 (CUR_YR) and one for the 		*
*		prior year 2023 (PY_YR). Each of these CTE are a union      *
*       of taxable values for each jurisdiction type (City, ISD, 	*
*       County, College, hospital, and special district. Each CTE	*
*       calculates the parcel count, market value, taxable value, 	*
*       and average market and taxable values for the CUR_YR and 	*
*		PY_YR. The two CTE are combined in the final SELECT query	*
*		which can be saved as a .csv or used in a direct query in 	*
*		power query to create a formatted final report.				*
*																	*
********************************************************************/

WITH CUR_YR AS ( -- create the current year CTE

	/********Current Year City Taxable***************/
	SELECT 
		CITY_JURIS_DESC         AS JURIS
		, COUNT(*)              AS PARCELS
		, SUM(TOT_VAL)          AS MKT_VAL
		, AVG(TOT_VAL)          AS AVERAGE_MKT_VAL
		, SUM(CITY_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(CITY_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year    AS AAY 
	WHERE
		AAY.SPTD_CODE           = 'A11'
		AND AAY.DIVISION_CD     = 'RES'
	GROUP BY 
		CITY_JURIS_DESC
		
	UNION

	/********Current Year School District (ISD) Taxable***************/
	SELECT
		ISD_JURIS_DESC         AS JURIS
		, COUNT(*)             AS PARCELS
		, SUM(TOT_VAL)         AS MKT_VAL
		, AVG(TOT_VAL)         AS AVERAGE_MKT_VAL
		, SUM(ISD_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(ISD_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year   AS AAY 
	WHERE
		AAY.SPTD_CODE          = 'A11'
		AND AAY.DIVISION_CD    = 'RES'
	GROUP BY 
		ISD_JURIS_DESC

	UNION

	/********Current Year Special District Taxable***************/
	SELECT
		SPECIAL_DIST_JURIS_DESC         AS JURIS
		, COUNT(*)                      AS PARCELS
		, SUM(TOT_VAL)                  AS MKT_VAL
		, AVG(TOT_VAL)                  AS AVERAGE_MKT_VAL
		, SUM(SPECIAL_DIST_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(SPECIAL_DIST_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year            AS AAY 
	WHERE
		AAY.SPTD_CODE                   = 'A11'
		AND AAY.DIVISION_CD             = 'RES'
	GROUP BY 
		SPECIAL_DIST_JURIS_DESC
		
	UNION

	/********Current Year County Taxable***************/
	SELECT
		COUNTY_JURIS_DESC         AS JURIS
		, COUNT(*)                AS PARCELS
		, SUM(TOT_VAL)            AS MKT_VAL
		, AVG(TOT_VAL)            AS AVERAGE_MKT_VAL
		, SUM(COUNTY_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(COUNTY_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year      AS AAY 
	WHERE
		AAY.SPTD_CODE             = 'A11'
		AND AAY.DIVISION_CD       = 'RES'
	GROUP BY 
		COUNTY_JURIS_DESC

	UNION

	/********Current Year College Taxable***************/
	SELECT
		COLLEGE_JURIS_DESC         AS JURIS
		, COUNT(*)                 AS PARCELS
		, SUM(TOT_VAL)             AS MKT_VAL
		, AVG(TOT_VAL)             AS AVERAGE_MKT_VAL
		, SUM(COLLEGE_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(COLLEGE_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year       AS AAY 
	WHERE
		AAY.SPTD_CODE              = 'A11'
		AND AAY.DIVISION_CD        = 'RES'
	GROUP BY 
		COLLEGE_JURIS_DESC
		
	UNION

	/********Current Year Hospital Taxable***************/
	SELECT
		HOSPITAL_JURIS_DESC         AS JURIS
		, COUNT(*)                  AS PARCELS
		, SUM(TOT_VAL)              AS MKT_VAL
		, AVG(TOT_VAL)              AS AVERAGE_MKT_VAL
		, SUM(HOSPITAL_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(HOSPITAL_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		24account_apprl_year        AS AAY 
	WHERE
		AAY.SPTD_CODE               = 'A11'
		AND AAY.DIVISION_CD         = 'RES'
	GROUP BY 
		HOSPITAL_JURIS_DESC
),

PY_YR AS ( -- Create prior year CTE

	/********Prior Year City Taxable***************/
	SELECT
		CITY_JURIS_DESC         AS JURIS
		, COUNT(*)              AS PARCELS
		, SUM(TOT_VAL)          AS MKT_VAL
		, AVG(TOT_VAL)          AS AVERAGE_MKT_VAL
		, SUM(CITY_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(CITY_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year    AS AAY 
	WHERE
		AAY.SPTD_CODE           = 'A11'
		AND AAY.DIVISION_CD     = 'RES'
	GROUP BY 
		CITY_JURIS_DESC
		
	UNION

	/********Prior Year School District (ISD) Taxable***************/
	SELECT
		ISD_JURIS_DESC         AS JURIS
		, COUNT(*)             AS PARCELS
		, SUM(TOT_VAL)         AS MKT_VAL
		, AVG(TOT_VAL)         AS AVERAGE_MKT_VAL
		, SUM(ISD_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(ISD_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year   AS AAY 
	WHERE
		AAY.SPTD_CODE          = 'A11'
		AND AAY.DIVISION_CD    = 'RES'
	GROUP BY 
		ISD_JURIS_DESC

	UNION

	/********Prior Year Special District Taxable***************/
	SELECT
		SPECIAL_DIST_JURIS_DESC         AS JURIS
		, COUNT(*)                      AS PARCELS
		, SUM(TOT_VAL)                  AS MKT_VAL
		, AVG(TOT_VAL)                  AS AVERAGE_MKT_VAL
		, SUM(SPECIAL_DIST_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(SPECIAL_DIST_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year            AS AAY 
	WHERE
		AAY.SPTD_CODE                   = 'A11'
		AND AAY.DIVISION_CD             = 'RES'
	GROUP BY 
		SPECIAL_DIST_JURIS_DESC
		
	UNION

	/********Prior Year County Taxable***************/
	SELECT
		COUNTY_JURIS_DESC         AS JURIS
		, COUNT(*)                AS PARCELS
		, SUM(TOT_VAL)            AS MKT_VAL
		, AVG(TOT_VAL)            AS AVERAGE_MKT_VAL
		, SUM(COUNTY_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(COUNTY_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year      AS AAY 
	WHERE
		AAY.SPTD_CODE             = 'A11'
		AND AAY.DIVISION_CD       = 'RES'
	GROUP BY 
		COUNTY_JURIS_DESC

	UNION

	/********Prior Year College Taxable***************/
	SELECT
		COLLEGE_JURIS_DESC         AS JURIS
		, COUNT(*)                 AS PARCELS
		, SUM(TOT_VAL)             AS MKT_VAL
		, AVG(TOT_VAL)             AS AVERAGE_MKT_VAL
		, SUM(COLLEGE_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(COLLEGE_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year       AS AAY 
	WHERE
		AAY.SPTD_CODE              = 'A11'
		AND AAY.DIVISION_CD        = 'RES'
	GROUP BY 
		COLLEGE_JURIS_DESC
		
	UNION

	/********Prior Year Hospital Taxable***************/
	SELECT
		HOSPITAL_JURIS_DESC         AS JURIS
		, COUNT(*)                  AS PARCELS
		, SUM(TOT_VAL)              AS MKT_VAL
		, AVG(TOT_VAL)              AS AVERAGE_MKT_VAL
		, SUM(HOSPITAL_TAXABLE_VAL) AS TAXABLE_VALUE
		, AVG(HOSPITAL_TAXABLE_VAL) AS AVG_TAXABLE_VALUE
	FROM
		23account_apprl_year        AS AAY 
	WHERE
		AAY.SPTD_CODE               = 'A11'
		AND AAY.DIVISION_CD         = 'RES'
	GROUP BY 
		HOSPITAL_JURIS_DESC
)

/********Final Query Joining Current and Prior Year CTEs***************/
SELECT
	CY.JURIS                    			AS JURISDICTION
    , CY.PARCELS                			AS PARCELS
    , CY.MKT_VAL                			AS CURRENT_MKT
    , PY.MKT_VAL               		 		AS PRIOR_MARKET
    , (CY.MKT_VAL - PY.MKT_VAL) 
		/ NULLIF(PY.MKT_VAL,0)  			AS MARKET_CHANGE_PCT
    , CY.AVERAGE_MKT_VAL        			AS CURRENT_AVERAGE_MKT
    , PY.AVERAGE_MKT_VAL        			AS PRIOR_AVERAGE_MKT
    , CY.TAXABLE_VALUE          			AS CURRENT_TAXABLE_VALUE
    , PY.TAXABLE_VALUE          			AS PRIOR_TAXABLE_VALUE
    , (CY.TAXABLE_VALUE - PY.TAXABLE_VALUE) 
		/ NULLIF(PY.TAXABLE_VALUE,0)  		AS TAXABLE_CHANGE_PCT
    , CY.AVG_TAXABLE_VALUE      			AS CURRENT_AVG_TAXABLE_VALUE
    , PY.AVG_TAXABLE_VALUE      			AS PRIOR_AVG_TAXABLE_VALUE
FROM
	CUR_YR                      			AS CY 
    INNER JOIN PY_YR            			AS PY
    ON CY.JURIS                 			= PY.JURIS
ORDER BY
	CY.JURIS
