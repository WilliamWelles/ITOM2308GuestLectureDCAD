
/********************** Jurisdiction Total Queries ************************************/
SELECT
	FORMAT(COUNT(*),0)                       AS PARCELS    
    , FORMAT(SUM(LAND_VAL),0)                AS LAND_VALUE
    , FORMAT(SUM(TOT_VAL- LAND_VAL),0)       AS IMP_VALUE
    , FORMAT(
		SUM(
			CASE 
				WHEN DIVISION_CD = 'BPP' 
                THEN TOT_VAL 
                END
			),0)                             AS BPP_VALUE
	, FORMAT(SUM(TOT_VAL),0)                 AS TOTAL_MARKET_VALUE
    , FORMAT(
		SUM(
        AAY.TOT_VAL - AAY.HMSTD_CAP_VAL
        ),0)                                 AS CAP_LOSS
	, FORMAT(SUM(AEV.ISD_APPLD_VAL),0)       AS EXEMPTIONS
    , FORMAT(SUM(ISD_TAXABLE_VAL),0)         AS TAXABLE_VALUE
FROM
	25account_apprl_year                     AS AAY
	LEFT JOIN 25acct_exempt_value           AS AEV
		ON AAY.ACCOUNT_NUM = AEV.ACCOUNT_NUM
WHERE
	1 = 1
    AND ISD_JURIS_DESC = 'HIGHLAND PARK ISD'


/************************ Exemption Queries **********************************************/

; SELECT
	AEV.EXEMPTION                      				 AS EXEMPTION
    , FORMAT(COUNT(*),0)               				 AS PARCELS
    , FORMAT(SUM(AAY.TOT_VAL),0)       				 AS MARKET_VALUE
    , FORMAT(
		SUM(
        AAY.TOT_VAL - AAY.HMSTD_CAP_VAL
        ),0)                                         AS CAP_LOSS
    , FORMAT(SUM(AEV.ISD_APPLD_VAL),0) 				 AS EXEMPT_AMMOUNT
    , FORMAT(
		SUM(
        EXEMPT_TOTAL.ALL_EXEMPT - AEV.ISD_APPLD_VAL
        ),0)                                         AS OTHER_EXEMPTIONS
    , FORMAT(SUM(AAY.ISD_TAXABLE_VAL),0) 			 AS TAXABLE_VALUE
    
FROM
	25account_apprl_year               AS AAY
    INNER JOIN 25acct_exempt_value     AS AEV
		ON AAY.APPRAISAL_YR            = AEV.APPRAISAL_YR
        AND AAY.ACCOUNT_NUM            = AEV.ACCOUNT_NUM
	INNER JOIN (
		SELECT
			ACCOUNT_NUM
			, SUM(ISD_APPLD_VAL)       AS ALL_EXEMPT
		FROM
			25acct_exempt_value
		GROUP BY
			ACCOUNT_NUM
    )                                  AS EXEMPT_TOTAL
		ON AAY.ACCOUNT_NUM             = EXEMPT_TOTAL.ACCOUNT_NUM
WHERE
	AAY.ISD_JURIS_DESC                 = 'HIGHLAND PARK ISD'
    AND AEV.ISD_APPLD_VAL              <> 0
GROUP BY
	AEV.EXEMPTION
