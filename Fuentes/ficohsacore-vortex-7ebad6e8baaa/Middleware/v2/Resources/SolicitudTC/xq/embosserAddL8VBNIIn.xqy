xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicitudTCRequest" element="ns0:solicitudTC" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EmbosserAddL8VBRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTC/xq/embosserAddL8VBNIIn/";

declare function transformarCardAction($cardAction as xs:string)
	as xs:integer?{
		if ($cardAction = 'NEW_CARD') then(
			1
		)else if ($cardAction = 'NORMAL_REPLACEMENT') then(
		    3
		)else if ($cardAction = 'EMERGENCY_REPLACEMENT') then(
		    6
		)else if ($cardAction = 'RENOVATION') then (
		    7
		)else ()	    
};

declare function xf:embosserAddL8VBIn($org as xs:integer,
    $solicitudTCRequest as element(ns0:solicitudTC))
    as element(ns1:EmbosserAddL8VBRequest) {
        <ns1:EmbosserAddL8VBRequest>
         	<AZXAPI-ORG>{ data($org) }</AZXAPI-ORG>
            <AZXAPI-POST-TO-ACCT>{ data($solicitudTCRequest/ACCOUNT_NUMBER) }</AZXAPI-POST-TO-ACCT>
            <AZXAPI-CARD-NBR>{ data($solicitudTCRequest/CARD_NUMBER) }</AZXAPI-CARD-NBR>
            <AZXAPI-CARD-SEQ>1</AZXAPI-CARD-SEQ>
            <AZXAPI-CARD-ACTION>{ transformarCardAction($solicitudTCRequest/CARD_ACTION) }</AZXAPI-CARD-ACTION>
            <AZXAPI-NBR-RQTD>1</AZXAPI-NBR-RQTD>
            <AZXAPI-TYPE-OF-CARD>1</AZXAPI-TYPE-OF-CARD>
            <AZXAPI-RQTD-CARD-TYPE>
            {
            	let $cardHolderType := $solicitudTCRequest/CARD_HOLDER_TYPE
            	let $typeCard := $solicitudTCRequest/TYPE_CARD
            	return
            	if (data($typeCard) != '') then (
                	string($typeCard/text())
              	) elseif ($cardHolderType/text() = 'PRINCIPAL') then ('01')
              	  elseif ($cardHolderType/text() = 'ADDITIONAL') then ('00')
              	  else ()
            }
            </AZXAPI-RQTD-CARD-TYPE>
            <AZXAPI-TYPE-CARD-MAILER>
            { 
                let $cardHolderType := $solicitudTCRequest/CARD_HOLDER_TYPE
            	let $typeCardMailer := $solicitudTCRequest/TYPE_CARD_MAILER
            	return
            	if (data($typeCardMailer) != '') then (
                	string($typeCardMailer/text())
              	) elseif ($cardHolderType/text() = 'PRINCIPAL') then ('01')
              	  elseif ($cardHolderType/text() = 'ADDITIONAL') then ('00')
              	  else ()
             }
            </AZXAPI-TYPE-CARD-MAILER>
            <AZXAPI-PLASTIC-ID>0</AZXAPI-PLASTIC-ID>
            <AZXAPI-NAME1-TYPE-IND>0</AZXAPI-NAME1-TYPE-IND>
            <AZXAPI-NAME2-TYPE-IND>0</AZXAPI-NAME2-TYPE-IND>
            <AZXAPI-EMBOSSED-NAME-1>{ data($solicitudTCRequest/EMBOSSED_NAME) }</AZXAPI-EMBOSSED-NAME-1>
            <AZXAPI-EMBOSSED-NAME-2>{ data($solicitudTCRequest/EMBOSSED_NAME_2) }</AZXAPI-EMBOSSED-NAME-2>
            <AZXAPI-SECURECODE-ACTIVATE>0</AZXAPI-SECURECODE-ACTIVATE>
            <AZXAPI-VISA-PLUS-IND>0</AZXAPI-VISA-PLUS-IND>
            <AZXAPI-PIN-DELAY-DAYS>0</AZXAPI-PIN-DELAY-DAYS>
            <AZXAPI-DATE-EXPIRE>{ data($solicitudTCRequest/EXPIRATION_DATE) }</AZXAPI-DATE-EXPIRE>
            <AZXAPI-CUSTOMER-NBR>{ data($solicitudTCRequest/CUSTOMER_ID) }</AZXAPI-CUSTOMER-NBR>
            <AZXAPI-EMBR-NAME-1>{ fn:string('') }</AZXAPI-EMBR-NAME-1>
            <AZXAPI-EMBR-NAME-2>{ data($solicitudTCRequest/NAME_2) }</AZXAPI-EMBR-NAME-2>
            <AZXAPI-PIN-OFFSET>0</AZXAPI-PIN-OFFSET>
            <AZXAPI-POS-SERVICE-CODE>201</AZXAPI-POS-SERVICE-CODE>
            <AZXAPI-CARDHOLDER-FLAG>
                {
                    if ($solicitudTCRequest/CARD_HOLDER_TYPE/text() = 'PRINCIPAL') then
                    	(1)
                    else if ($solicitudTCRequest/CARD_HOLDER_TYPE/text() = 'ADDITIONAL') then
                    	(0)
                    else ()
                }
			</AZXAPI-CARDHOLDER-FLAG>
            <AZXAPI-ADDR-LINE-1>{ fn:string('') }</AZXAPI-ADDR-LINE-1>
            <AZXAPI-ADDR-LINE-2>{ fn:string('') }</AZXAPI-ADDR-LINE-2>
            <AZXAPI-CITY>{ fn:string('') }</AZXAPI-CITY>
            <AZXAPI-ST-PR>{ fn:string('') }</AZXAPI-ST-PR>
            <AZXAPI-PSTL-CD>{ fn:string('') }</AZXAPI-PSTL-CD>
            <AZXAPI-LANG-CODE>{ fn:string('') }</AZXAPI-LANG-CODE>
            <AZXAPI-VISA-MINI-IND>0</AZXAPI-VISA-MINI-IND>
            <AZXAPI-PIN-SUPPRESSION>
                {
                    if ($solicitudTCRequest/GENERATE_PIN/text() = "YES") then
                        (0)
                    else if ($solicitudTCRequest/GENERATE_PIN/text() = "NO") then
                    	(1)
                    else ()
                }
			</AZXAPI-PIN-SUPPRESSION>
            <AZXAPI-BLOCK-CODE>{ data($solicitudTCRequest/BLOCK_CODE) }</AZXAPI-BLOCK-CODE>
            <AZXAPI-CURR-CRD-ACTN>Y</AZXAPI-CURR-CRD-ACTN>
            <AZXAPI-AUTH-ATM-OTC-RTL-FREQ>0</AZXAPI-AUTH-ATM-OTC-RTL-FREQ>
            <AZXAPI-AUTH-ATM-CASH-AMT>0</AZXAPI-AUTH-ATM-CASH-AMT>
            <AZXAPI-AUTH-ATM-CASH-NBR>0</AZXAPI-AUTH-ATM-CASH-NBR>
            <AZXAPI-AUTH-ATM-CASH-SNGL-TXN>0</AZXAPI-AUTH-ATM-CASH-SNGL-TXN>
            <AZXAPI-AUTH-OTC-CASH-AMT>0</AZXAPI-AUTH-OTC-CASH-AMT>
            <AZXAPI-AUTH-OTC-CASH-NBR>0</AZXAPI-AUTH-OTC-CASH-NBR>
            <AZXAPI-AUTH-OTC-CASH-SNGL-TXN>0</AZXAPI-AUTH-OTC-CASH-SNGL-TXN>
            <AZXAPI-AUTH-RTL-AMT>0</AZXAPI-AUTH-RTL-AMT>
            <AZXAPI-AUTH-RTL-NBR>0</AZXAPI-AUTH-RTL-NBR>
            <AZXAPI-AUTH-RTL-SNGL-TXN>0</AZXAPI-AUTH-RTL-SNGL-TXN>
            <AZXAPI-AUTH-INTRNT-AMT>0</AZXAPI-AUTH-INTRNT-AMT>
            <AZXAPI-AUTH-INTRNT-NBR>0</AZXAPI-AUTH-INTRNT-NBR>
            <AZXAPI-AUTH-INTRNT-SNGL-TXN>0</AZXAPI-AUTH-INTRNT-SNGL-TXN>
            <AZXAPI-USER-1>{ data($solicitudTCRequest/PRIORYTI_PASS) }</AZXAPI-USER-1>
            <AZXAPI-USER-2>{ fn:string('') }</AZXAPI-USER-2>
            <AZXAPI-USER-3>{ fn:string('') }</AZXAPI-USER-3>
            <AZXAPI-USER-4>0</AZXAPI-USER-4>
            <AZXAPI-USER-5>{ fn:string('') }</AZXAPI-USER-5>
            <AZXAPI-USER-6>{ fn:string('') }</AZXAPI-USER-6>
            <AZXAPI-USER-7>{ fn:string('') }</AZXAPI-USER-7>
            <AZXAPI-USER-8>{ fn:string('') }</AZXAPI-USER-8>
            <AZXAPI-USER-DATE-1>0</AZXAPI-USER-DATE-1>
            <AZXAPI-USER-DATE-2>0</AZXAPI-USER-DATE-2>
            <AZXAPI-ADMIN-BRANCH>0</AZXAPI-ADMIN-BRANCH>
            <AZXAPI-REISSUE-DELIV-OPTION>0</AZXAPI-REISSUE-DELIV-OPTION>
            <AZXAPI-DATE-NEXT-EXPR>0</AZXAPI-DATE-NEXT-EXPR>
            <AZXAPI-FIRST-ISS-BRANCH>0</AZXAPI-FIRST-ISS-BRANCH>
            <AZXAPI-ISSUE-DELIV-OPTION>0</AZXAPI-ISSUE-DELIV-OPTION>
            <AZXAPI-AUTH-CRITERIA-TBL>{ fn:string('') }</AZXAPI-AUTH-CRITERIA-TBL>
            <AZXAPI-CARD-DELAY-DAYS>0</AZXAPI-CARD-DELAY-DAYS>
            <AZXAPI-SPND-LIMIT-TBL>{ fn:string('') }</AZXAPI-SPND-LIMIT-TBL>
            <AZXAPI-SPND-ARRAY>
                <AZXAPI-SPND-ELEMENT>
                    <AZXAPI-SPND-LIMIT>0</AZXAPI-SPND-LIMIT>
                    <AZXAPI-SPND-TRANS>0</AZXAPI-SPND-TRANS>
                    <AZXAPI-SPND-FREQ>0</AZXAPI-SPND-FREQ>
                </AZXAPI-SPND-ELEMENT>
            </AZXAPI-SPND-ARRAY>
            <AZXAPI-PROGRAM-ID>0</AZXAPI-PROGRAM-ID>
            <AZXAPI-DVC-IND>{ fn:string('') }</AZXAPI-DVC-IND>
            <AZXAPI-SDP-PROCESS-TYPE>
                {
                    if ($solicitudTCRequest/PROCESS_TYPE/text() = 'EMERGENCY') then
                        (1)
                    else if ($solicitudTCRequest/PROCESS_TYPE/text() = 'NORMAL') then
                    	(0)
                    else ()
                }
			</AZXAPI-SDP-PROCESS-TYPE>
            <AZXAPI-EMBLM-ID>
                {
                    if ($solicitudTCRequest/EMBLEM_ID/text() != "") then
                        ($solicitudTCRequest/EMBLEM_ID/text())
                    else (0)
                }
			</AZXAPI-EMBLM-ID>
            <AZXAPI-CARD-ACTION-REASON>
                {
                    if ($solicitudTCRequest/CARD_ACTION_REASON_CODE/text() != "") then
                        ($solicitudTCRequest/CARD_ACTION_REASON_CODE/text())
                    else (1)
                }
			</AZXAPI-CARD-ACTION-REASON>
			<AZXAPI-VBV-STATUS>{ fn:string('') }</AZXAPI-VBV-STATUS>
         	<AZXAPI-VBV-PAM>{ fn:string('') }</AZXAPI-VBV-PAM>	         	
         	<AZXAPI-FALC-MARK>{ fn:string('') }</AZXAPI-FALC-MARK>
            <AZXAPI-FALC-MARK-ST-DATE xsi:nil="true"/>
            <AZXAPI-FALC-MARK-END-DATE xsi:nil="true"/>
            <AZXAPI-SPEND-LIMITS-STATUS>
                {
                    if ($solicitudTCRequest/SPENDING_LIMIT_INDICATOR/text() != "") then
                        ($solicitudTCRequest/SPENDING_LIMIT_INDICATOR/text())
                    else (0)
                }
			</AZXAPI-SPEND-LIMITS-STATUS>
            <AZXAPI-RETAIL-PERCENT-DAILY>
                {
                    if ($solicitudTCRequest/PERCENTAGE_LIMIT_OF_DAILY_PURCHASE/text() != "") then
                        ($solicitudTCRequest/PERCENTAGE_LIMIT_OF_DAILY_PURCHASE/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-DAILY>
            <AZXAPI-RETAIL-PERCENT-MTD>
                {
                    if ($solicitudTCRequest/PERCENTAGE_MONTHLY_PURCHASE_LIMIT/text() != "") then
                        ($solicitudTCRequest/PERCENTAGE_MONTHLY_PURCHASE_LIMIT/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-MTD>
            <AZXAPI-RETAIL-PERCENT-YTD>
                {
                    if ($solicitudTCRequest/ANNUAL_PURCHASE_LIMIT_PERCENTAGE/text() != "") then
                        ($solicitudTCRequest/ANNUAL_PURCHASE_LIMIT_PERCENTAGE/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-YTD>
            <AZXAPI-RETAIL-AMOUNT-DAILY>
                {
                    if ($solicitudTCRequest/DAILY_PURCHASE_LIMIT/text() != "") then
                        ($solicitudTCRequest/DAILY_PURCHASE_LIMIT/text())
                    else (0)
                }
            </AZXAPI-RETAIL-AMOUNT-DAILY>
            <AZXAPI-RETAIL-AMOUNT-MTD>
                {
                    if ($solicitudTCRequest/MONTHLY_PURCHASE_LIMIT/text() != "") then
                        ($solicitudTCRequest/MONTHLY_PURCHASE_LIMIT/text())
                    else (0)
                }
			</AZXAPI-RETAIL-AMOUNT-MTD>
            <AZXAPI-RETAIL-AMOUNT-YTD>
                {
                    if ($solicitudTCRequest/ANNUAL_PURCHASE_LIMIT/text() != "") then
                        ($solicitudTCRequest/ANNUAL_PURCHASE_LIMIT/text())
                    else (0)
                }
			</AZXAPI-RETAIL-AMOUNT-YTD>
            <AZXAPI-CASH-PERCENT-DAILY>
                {
                    if ($solicitudTCRequest/DAILY_WITHDRAWAL_LIMIT_PERCENTAGER/text() != "") then
                        ($solicitudTCRequest/DAILY_WITHDRAWAL_LIMIT_PERCENTAGE/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-DAILY>
            <AZXAPI-CASH-PERCENT-MTD>
                {
                    if ($solicitudTCRequest/MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE/text() != "") then
                        ($solicitudTCRequest/MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-MTD>
            <AZXAPI-CASH-PERCENT-YTD>
                {
                    if ($solicitudTCRequest/ANNUAL_RETIREMENT_LIMIT_PERCENTAGE/text() != "") then
                        ($solicitudTCRequest/ANNUAL_RETIREMENT_LIMIT_PERCENTAGE/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-YTD>
            <AZXAPI-CASH-AMOUNT-DAILY>
                {
                    if ($solicitudTCRequest/DAILY_WITHDRAWAL_LIMIT/text() != "") then
                        ($solicitudTCRequest/DAILY_WITHDRAWAL_LIMIT/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-DAILY>
            <AZXAPI-CASH-AMOUNT-MTD>
                {
                    if ($solicitudTCRequest/MONTHLY_WITHDRAWAL_LIMIT/text() != "") then
                        ($solicitudTCRequest/MONTHLY_WITHDRAWAL_LIMIT/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-MTD>
            <AZXAPI-CASH-AMOUNT-YTD>
                {
                    if ($solicitudTCRequest/ANNUAL_WITHDRAWAL_LIMIT/text() != "") then
                        ($solicitudTCRequest/ANNUAL_WITHDRAWAL_LIMIT/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-YTD>
        </ns1:EmbosserAddL8VBRequest>
};

declare variable $org as xs:integer external;
declare variable $solicitudTCRequest as element(ns0:solicitudTC) external;

xf:embosserAddL8VBIn($org,
    $solicitudTCRequest)