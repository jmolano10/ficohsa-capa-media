xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../../Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosHNResponse/ns1:ASSETS/ns1:ASSET" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaFICOPENOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaFICOPENOut($outputParameters as element(ns0:OutputParameters),
    $TYPE as xs:string,
    $PRODUCTID as xs:string)
    as element() {
        <ns1:ASSET>
        {
            if(upper-case(string($outputParameters/ns0:ERROR_CODE/text()))!= "SUCCESS")then
            (
                for $ACCOUNT_NUMBER in $outputParameters/ns0:ACCOUNT_NUMBER
                return
                    <ns1:ID>{ $PRODUCTID }</ns1:ID>,
                    <ns1:TYPE>{ $TYPE }</ns1:TYPE>,
                    <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
                    <ns1:SUCCESS_INDICATOR>{ upper-case($outputParameters/ns0:ERROR_CODE/text()) }</ns1:SUCCESS_INDICATOR>,
                    <ns1:ERROR_MESSAGE>{ string-join($outputParameters/ns0:ERROR_MESSAGE/text()," ") }</ns1:ERROR_MESSAGE>
            )
            else(
                if( count($outputParameters/ns0:ACCOUNT_NUMBER) > 0)then(
                    <ns1:ID>{ data($outputParameters/ns0:ACCOUNT_NUMBER) }</ns1:ID>,
                    <ns1:PRODUCT_NAME>{ data($outputParameters/ns0:CUSTOMER_NAME) }</ns1:PRODUCT_NAME>,
                    <ns1:CURRENCY>
                    {
                        let $currency := data($outputParameters/ns0:ACCOUNT_CURRENCY)
                        return
                        if ($currency = "1") then (
                        "HNL"
                        ) else if ($currency ="2") then (
                        "USD"
                        ) else if ($currency ="3") then (
                        "EUR"
                        ) else (
                        ""
                        )
                    } 
                    </ns1:CURRENCY>,
                    <ns1:RESERVE_BALANCE>0.0</ns1:RESERVE_BALANCE>,
                	<ns1:LOCKED_BALANCE>0.0</ns1:LOCKED_BALANCE>,
                	<ns1:VISA_FLOATING_BALANCE>0.0</ns1:VISA_FLOATING_BALANCE>,
                    <ns1:INTEREST_BALANCE>0.0</ns1:INTEREST_BALANCE>,                   
                    <ns1:TOTAL_BALANCE>{data($outputParameters/ns0:TOTAL_CURRENT_BALANCE/text()) }</ns1:TOTAL_BALANCE>,
                    <ns1:AVAILABLE_BALANCE>{ data($outputParameters/ns0:TOTAL_CURRENT_BALANCE/text()) }</ns1:AVAILABLE_BALANCE>,                    
                        
                    if(fn:string($outputParameters/ns0:START_DATE_RESP/text()) != '') then(
                        <ns1:OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($outputParameters/ns0:START_DATE_RESP)) }</ns1:OPENING_DATE>
                    ) else(
                    	<ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>
                    ),                   
                    <ns1:TYPE>{ $TYPE }</ns1:TYPE>,
                    <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
                    <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>
                    
                )else(
                    <ns1:ID>{ $PRODUCTID }</ns1:ID>,
                    <ns1:TYPE>{ $TYPE }</ns1:TYPE>,
                    <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
                    <ns1:SUCCESS_INDICATOR>NO RECORDS</ns1:SUCCESS_INDICATOR>,
                    <ns1:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns1:ERROR_MESSAGE>
                )
            )
        }
        </ns1:ASSET>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $TYPE as xs:string external;
declare variable $PRODUCTID as xs:string external;

xf:consultaFICOPENOut($outputParameters,
    $TYPE,
    $PRODUCTID)