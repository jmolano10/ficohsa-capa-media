xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/creditCardApplicationTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardApplicationTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace xf = "http://tempuri.org/CreditCardProcesor/RequestorServices/ProxyServices/v1.0/CreditCardApplication/XQ/EmbosserAddL8VBNIIn/";

declare variable $org as xs:integer external;
declare variable $creditCardApplicationRequest as element() (:: schema-element(ns1:creditCardApplicationRequest) ::) external;

declare function xf:transformarCardAction($cardAction as xs:string)
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

declare function local:func($org as xs:integer, 
                            $creditCardApplicationRequest as element() (:: schema-element(ns1:creditCardApplicationRequest) ::)) 
                            as element() (:: schema-element(ns2:EmbosserAddL8VBRequest) ::) {
    <ns2:EmbosserAddL8VBRequest>
    <AZXAPI-ORG>{ data($org) }</AZXAPI-ORG>
            <AZXAPI-POST-TO-ACCT>{ data($creditCardApplicationRequest/ns1:AccountNumber) }</AZXAPI-POST-TO-ACCT>
            <AZXAPI-CARD-NBR>{ data($creditCardApplicationRequest/ns1:CardNumber) }</AZXAPI-CARD-NBR>
            <AZXAPI-CARD-SEQ>1</AZXAPI-CARD-SEQ>
            <AZXAPI-CARD-ACTION>{ xf:transformarCardAction($creditCardApplicationRequest/ns1:CardAction) }</AZXAPI-CARD-ACTION>
            <AZXAPI-NBR-RQTD>1</AZXAPI-NBR-RQTD>
            <AZXAPI-TYPE-OF-CARD>1</AZXAPI-TYPE-OF-CARD>
            <AZXAPI-RQTD-CARD-TYPE>
            {
            	let $cardHolderType := $creditCardApplicationRequest/ns1:CardHolderType
            	let $typeCard := $creditCardApplicationRequest/ns1:TypeCard
            	return
            	if (data($typeCard) != '') then (
                	string($typeCard/text())
              	) else if ($cardHolderType/text() = 'PRINCIPAL') then ('01')
              	  else if ($cardHolderType/text() = 'ADDITIONAL') then ('00')
              	  else ()
            }
            </AZXAPI-RQTD-CARD-TYPE>
            <AZXAPI-TYPE-CARD-MAILER>
            { 
                let $cardHolderType := $creditCardApplicationRequest/ns1:CardHolderType
            	let $typeCardMailer := $creditCardApplicationRequest/ns1:TypeCardMailer
            	return
            	if (data($typeCardMailer) != '') then (
                	string($typeCardMailer/text())
              	) else if ($cardHolderType/text() = 'PRINCIPAL') then ('01')
              	  else if ($cardHolderType/text() = 'ADDITIONAL') then ('00')
              	  else ()
             }
            </AZXAPI-TYPE-CARD-MAILER>
            <AZXAPI-PLASTIC-ID>0</AZXAPI-PLASTIC-ID>
            <AZXAPI-NAME1-TYPE-IND>0</AZXAPI-NAME1-TYPE-IND>
            <AZXAPI-NAME2-TYPE-IND>0</AZXAPI-NAME2-TYPE-IND>
            <AZXAPI-EMBOSSED-NAME-1>{ data($creditCardApplicationRequest/ns1:EmbossedName) }</AZXAPI-EMBOSSED-NAME-1>
            <AZXAPI-EMBOSSED-NAME-2>{ data($creditCardApplicationRequest/ns1:EmbossedName2) }</AZXAPI-EMBOSSED-NAME-2>
            <AZXAPI-SECURECODE-ACTIVATE>0</AZXAPI-SECURECODE-ACTIVATE>
            <AZXAPI-VISA-PLUS-IND>0</AZXAPI-VISA-PLUS-IND>
            <AZXAPI-PIN-DELAY-DAYS>0</AZXAPI-PIN-DELAY-DAYS>
            <AZXAPI-DATE-EXPIRE>{ data($creditCardApplicationRequest/ns1:ExpirationDate) }</AZXAPI-DATE-EXPIRE>
            <AZXAPI-CUSTOMER-NBR>{ data($creditCardApplicationRequest/ns1:CustomerId) }</AZXAPI-CUSTOMER-NBR>
            <AZXAPI-EMBR-NAME-1>{ fn:string('') }</AZXAPI-EMBR-NAME-1>
            <AZXAPI-EMBR-NAME-2>{ data($creditCardApplicationRequest/ns1:Name2) }</AZXAPI-EMBR-NAME-2>
            <AZXAPI-PIN-OFFSET>0</AZXAPI-PIN-OFFSET>
            <AZXAPI-POS-SERVICE-CODE>201</AZXAPI-POS-SERVICE-CODE>
            <AZXAPI-CARDHOLDER-FLAG>
                {
                    if ($creditCardApplicationRequest/ns1:CardHolderType/text() = 'PRINCIPAL') then
                    	(1)
                    else if ($creditCardApplicationRequest/ns1:CardHolderType/text() = 'ADDITIONAL') then
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
                    if ($creditCardApplicationRequest/ns1:GeneratePin/text() = "YES") then
                        (0)
                    else if ($creditCardApplicationRequest/ns1:GeneratePin/text() = "NO") then
                    	(1)
                    else ()
                }
			</AZXAPI-PIN-SUPPRESSION>
            <AZXAPI-BLOCK-CODE>{ data($creditCardApplicationRequest/ns1:BlockCode) }</AZXAPI-BLOCK-CODE>
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
            <AZXAPI-USER-1>{ data($creditCardApplicationRequest/ns1:PriorytiPass) }</AZXAPI-USER-1>
            <AZXAPI-USER-2>{ data($creditCardApplicationRequest/ns1:Channel) }</AZXAPI-USER-2>
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
                    if ($creditCardApplicationRequest/ns1:ProcessType/text() = 'EMERGENCY') then
                        (1)
                    else if ($creditCardApplicationRequest/ns1:ProcessType/text() = 'NORMAL') then
                    	(0)
                    else ()
                }
			</AZXAPI-SDP-PROCESS-TYPE>
            <AZXAPI-EMBLM-ID>
                {
                    if ($creditCardApplicationRequest/ns1:EmblemId/text() != "") then
                        ($creditCardApplicationRequest/ns1:EmblemId/text())
                    else (0)
                }
			</AZXAPI-EMBLM-ID>
            <AZXAPI-CARD-ACTION-REASON>
                {
                    if ($creditCardApplicationRequest/ns1:CardActionReasonCode/text() != "") then
                        ($creditCardApplicationRequest/ns1:CardActionReasonCode/text())
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
                    if ($creditCardApplicationRequest/ns1:SpendingLimitIndicator/text() != "") then
                        ($creditCardApplicationRequest/ns1:SpendingLimitIndicator/text())
                    else (0)
                }
			</AZXAPI-SPEND-LIMITS-STATUS>
            <AZXAPI-RETAIL-PERCENT-DAILY>
                {
                    if ($creditCardApplicationRequest/ns1:PercentageLimitOfDailyPurchase/text() != "") then
                        ($creditCardApplicationRequest/ns1:PercentageLimitOfDailyPurchase/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-DAILY>
            <AZXAPI-RETAIL-PERCENT-MTD>
                {
                    if ($creditCardApplicationRequest/ns1:PercentageMonthlyPurchaseLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:PercentageMonthlyPurchaseLimit/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-MTD>
            <AZXAPI-RETAIL-PERCENT-YTD>
                {
                    if ($creditCardApplicationRequest/ns1:AnnualPurchaseLimitPercentage/text() != "") then
                        ($creditCardApplicationRequest/ns1:AnnualPurchaseLimitPercentage/text())
                    else (0)
                }
            </AZXAPI-RETAIL-PERCENT-YTD>
            <AZXAPI-RETAIL-AMOUNT-DAILY>
                {
                    if ($creditCardApplicationRequest/ns1:DailyPurchaseLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:DailyPurchaseLimit/text())
                    else (0)
                }
            </AZXAPI-RETAIL-AMOUNT-DAILY>
            <AZXAPI-RETAIL-AMOUNT-MTD>
                {
                    if ($creditCardApplicationRequest/ns1:MonthlyPurchaseLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:MonthlyPurchaseLimit/text())
                    else (0)
                }
			</AZXAPI-RETAIL-AMOUNT-MTD>
            <AZXAPI-RETAIL-AMOUNT-YTD>
                {
                    if ($creditCardApplicationRequest/ns1:AnnualPurchaseLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:AnnualPurchaseLimit/text())
                    else (0)
                }
			</AZXAPI-RETAIL-AMOUNT-YTD>
            <AZXAPI-CASH-PERCENT-DAILY>
                {
                    if ($creditCardApplicationRequest/ns1:DailyWithdrawalLimitPercentage/text() != "") then
                        ($creditCardApplicationRequest/ns1:DailyWithdrawalLimitPercentage/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-DAILY>
            <AZXAPI-CASH-PERCENT-MTD>
                {
                    if ($creditCardApplicationRequest/ns1:MonthlyWithdrawalLimitPercentage/text() != "") then
                        ($creditCardApplicationRequest/ns1:MonthlyWithdrawalLimitPercentage/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-MTD>
            <AZXAPI-CASH-PERCENT-YTD>
                {
                    if ($creditCardApplicationRequest/ns1:AnnualRetirementLimitPercentage/text() != "") then
                        ($creditCardApplicationRequest/ns1:AnnualRetirementLimitPercentage/text())
                    else (0)
                }
			</AZXAPI-CASH-PERCENT-YTD>
            <AZXAPI-CASH-AMOUNT-DAILY>
                {
                    if ($creditCardApplicationRequest/ns1:DailyWithdrawalLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:DailyWithdrawalLimit/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-DAILY>
            <AZXAPI-CASH-AMOUNT-MTD>
                {
                    if ($creditCardApplicationRequest/ns1:MonthlyWithdrawalLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:MonthlyWithdrawalLimit/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-MTD>
            <AZXAPI-CASH-AMOUNT-YTD>
                {
                    if ($creditCardApplicationRequest/ns1:AnnualWithdrawalLimit/text() != "") then
                        ($creditCardApplicationRequest/ns1:AnnualWithdrawalLimit/text())
                    else (0)
                }
			</AZXAPI-CASH-AMOUNT-YTD>
    </ns2:EmbosserAddL8VBRequest>
};

local:func($org, $creditCardApplicationRequest)