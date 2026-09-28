(:: pragma bea:global-element-parameter parameter="$solicitudTC1" element="ns0:solicitudTC" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EmbosserAddRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTC/xq/EmbosserAddIn/";

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
declare function xf:EmbosserAddIn($org as xs:string,
	$account_number as xs:string,
	$card_number as xs:string,
	$card_action as xs:string,
	$embossed_name as xs:string,
	$expiration_date as xs:string,
	$customer_id as xs:string,
	$card_holder_type as xs:string,
	$generate_pin as xs:string,
	$process_type as xs:string)
    as element(ns1:EmbosserAddRequest) {
		<ns1:EmbosserAddRequest>
		    <ARXAPI-ORG>{ $org }</ARXAPI-ORG>
		    <ARXAPI-POST-TO-ACCT>{ $account_number }</ARXAPI-POST-TO-ACCT>
		    <ARXAPI-CARD-NBR>{ data($card_number) }</ARXAPI-CARD-NBR>
		    <ARXAPI-CARD-SEQ>1</ARXAPI-CARD-SEQ>
		    <ARXAPI-CARD-ACTION>{ transformarCardAction($card_action)}</ARXAPI-CARD-ACTION>
		    <ARXAPI-NBR-RQTD>01</ARXAPI-NBR-RQTD>
		    <ARXAPI-TYPE-OF-CARD>01</ARXAPI-TYPE-OF-CARD>
		    <ARXAPI-RQTD-CARD-TYPE>01</ARXAPI-RQTD-CARD-TYPE>
		    <ARXAPI-TYPE-CARD-MAILER>01</ARXAPI-TYPE-CARD-MAILER>
		    <ARXAPI-PLASTIC-ID>0</ARXAPI-PLASTIC-ID>
		    <ARXAPI-NAME1-TYPE-IND>0</ARXAPI-NAME1-TYPE-IND>
		    <ARXAPI-NAME2-TYPE-IND>0</ARXAPI-NAME2-TYPE-IND>
		    <ARXAPI-EMBOSSED-NAME-1>{ $embossed_name }</ARXAPI-EMBOSSED-NAME-1>
		    <ARXAPI-EMBOSSED-NAME-2/>
		    <ARXAPI-SECURECODE-ACTIVATE>0</ARXAPI-SECURECODE-ACTIVATE>
		    <ARXAPI-VISA-PLUS-IND>0</ARXAPI-VISA-PLUS-IND>
		    <ARXAPI-PIN-DELAY-DAYS>00</ARXAPI-PIN-DELAY-DAYS>
		    <ARXAPI-DATE-EXPIRE>{ $expiration_date }</ARXAPI-DATE-EXPIRE>
		    <ARXAPI-CUSTOMER-NBR>{ $customer_id }</ARXAPI-CUSTOMER-NBR>
		    <ARXAPI-EMBR-NAME-1/>
		    <ARXAPI-EMBR-NAME-2/>
		    <ARXAPI-PIN-OFFSET>0000000</ARXAPI-PIN-OFFSET>
		    <ARXAPI-POS-SERVICE-CODE>201</ARXAPI-POS-SERVICE-CODE>
		    <ARXAPI-CARDHOLDER-FLAG>
		    	{
		    		if ($card_holder_type = 'PRINCIPAL') then (
		    			1 
	    			)else if ($card_holder_type = 'ADDITIONAL') then(
	    				0
	    			)else() 	
	    		}
		    </ARXAPI-CARDHOLDER-FLAG>
		    <ARXAPI-ADDR-LINE-1/>
		    <ARXAPI-ADDR-LINE-2/>
		    <ARXAPI-CITY/>
		    <ARXAPI-ST-PR/>
		    <ARXAPI-PSTL-CD/>
		    <ARXAPI-LANG-CODE/>
		    <ARXAPI-VISA-MINI-IND>0</ARXAPI-VISA-MINI-IND>
		    <ARXAPI-PIN-SUPPRESSION>
		        {
		            if ($generate_pin = "YES") then(
		                0
		            )else if($generate_pin = "NO")then( 
		                1
		            )else()
		        }
		    </ARXAPI-PIN-SUPPRESSION>
		    <ARXAPI-BLOCK-CODE> </ARXAPI-BLOCK-CODE>
		    <ARXAPI-CURR-CRD-ACTN>Y</ARXAPI-CURR-CRD-ACTN>
		    <ARXAPI-AUTH-ATM-OTC-RTL-FREQ>0</ARXAPI-AUTH-ATM-OTC-RTL-FREQ>
		    <ARXAPI-AUTH-ATM-CASH-AMT>00000000000000000</ARXAPI-AUTH-ATM-CASH-AMT>
		    <ARXAPI-AUTH-ATM-CASH-NBR>000000000</ARXAPI-AUTH-ATM-CASH-NBR>
		    <ARXAPI-AUTH-ATM-CASH-SNGL-TXN>00000000000000000</ARXAPI-AUTH-ATM-CASH-SNGL-TXN>
		    <ARXAPI-AUTH-OTC-CASH-AMT>00000000000000000</ARXAPI-AUTH-OTC-CASH-AMT>
		    <ARXAPI-AUTH-OTC-CASH-NBR>000000000</ARXAPI-AUTH-OTC-CASH-NBR>
		    <ARXAPI-AUTH-OTC-CASH-SNGL-TXN>00000000000000000</ARXAPI-AUTH-OTC-CASH-SNGL-TXN>
		    <ARXAPI-AUTH-RTL-AMT>00000000000000000</ARXAPI-AUTH-RTL-AMT>
		    <ARXAPI-AUTH-RTL-NBR>000000000</ARXAPI-AUTH-RTL-NBR>
		    <ARXAPI-AUTH-RTL-SNGL-TXN>00000000000000000</ARXAPI-AUTH-RTL-SNGL-TXN>
		    <ARXAPI-AUTH-INTRNT-AMT>0000000000000</ARXAPI-AUTH-INTRNT-AMT>
		    <ARXAPI-AUTH-INTRNT-NBR>000000000</ARXAPI-AUTH-INTRNT-NBR>
		    <ARXAPI-AUTH-INTRNT-SNGL-TXN>0000000000000</ARXAPI-AUTH-INTRNT-SNGL-TXN>
		    <ARXAPI-USER-1/>
		    <ARXAPI-USER-2/>
		    <ARXAPI-USER-3/>
		    <ARXAPI-USER-4>0</ARXAPI-USER-4>
		    <ARXAPI-USER-5/>
		    <ARXAPI-USER-6/>
		    <ARXAPI-USER-7/>
		    <ARXAPI-USER-8/>
		    <ARXAPI-USER-DATE-1>0000000</ARXAPI-USER-DATE-1>
		    <ARXAPI-USER-DATE-2>0000000</ARXAPI-USER-DATE-2>
		    <ARXAPI-ADMIN-BRANCH>000000000</ARXAPI-ADMIN-BRANCH>
		    <ARXAPI-REISSUE-DELIV-OPTION>0</ARXAPI-REISSUE-DELIV-OPTION>
		    <ARXAPI-DATE-NEXT-EXPR>0000000</ARXAPI-DATE-NEXT-EXPR>
		    <ARXAPI-FIRST-ISS-BRANCH>000000000</ARXAPI-FIRST-ISS-BRANCH>
		    <ARXAPI-ISSUE-DELIV-OPTION>0</ARXAPI-ISSUE-DELIV-OPTION>
		    <ARXAPI-AUTH-CRITERIA-TBL/>
		    <ARXAPI-CARD-DELAY-DAYS>00</ARXAPI-CARD-DELAY-DAYS>
		    <ARXAPI-SPND-LIMIT-TBL/>
		    <ARXAPI-SPND-ARRAY>
		        <ARXAPI-SPND-ELEMENT>
		            <ARXAPI-SPND-LIMIT>0</ARXAPI-SPND-LIMIT>
		            <ARXAPI-SPND-TRANS>0</ARXAPI-SPND-TRANS>
		            <ARXAPI-SPND-FREQ>0</ARXAPI-SPND-FREQ>
		        </ARXAPI-SPND-ELEMENT>
		    </ARXAPI-SPND-ARRAY>
		    <ARXAPI-PROGRAM-ID>000000000</ARXAPI-PROGRAM-ID>
		    <ARXAPI-DVC-IND/>
		    <ARXAPI-SDP-PROCESS-TYPE>
		    	{ 
		    		if ($process_type = 'EMERGENCY') then (
		    			1 
	    			)else if($process_type = 'NORMAL')then(
	    				0
	    			)else()  
	    		}
			</ARXAPI-SDP-PROCESS-TYPE>
		    <ARXAPI-EMBLM-ID>00000</ARXAPI-EMBLM-ID>
		    <ARXAPI-CARD-ACTION-REASON>1</ARXAPI-CARD-ACTION-REASON>
		</ns1:EmbosserAddRequest>
};
declare variable $org as xs:string external;
declare variable $account_number as xs:string external;
declare variable $card_number as xs:string external;
declare variable $card_action as xs:string external;
declare variable $embossed_name as xs:string external;
declare variable $expiration_date as xs:string external;
declare variable $customer_id as xs:string external;
declare variable $card_holder_type as xs:string external;
declare variable $generate_pin as xs:string external;
declare variable $process_type as xs:string external;

xf:EmbosserAddIn($org,
	$account_number,
	$card_number,
	$card_action,
	$embossed_name,
	$expiration_date,
	$customer_id,
	$card_holder_type,
	$generate_pin,
	$process_type)