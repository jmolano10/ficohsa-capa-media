xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosGTResponse/ns0:ASSETS/ns0:ASSET" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaMaestraSaldoCuentaOut/";

declare function xf:numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaMaestraSaldoCuentaOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $TYPE as xs:string)
    as element() {
        <ns0:ASSET>
    	{   
    		<ns0:ID>{ $ID }</ns0:ID>,     		
        	if(string($outputParameters/ns1:PV_ERROR_CODE/text()) = "SUCCESS") then(
	            <ns0:PRODUCT_NAME>{ data($outputParameters/ns1:PV_ACCOUNT_NAME) }</ns0:PRODUCT_NAME>,
	            <ns0:CURRENCY>{ data( $outputParameters/ns1:PV_CURRENCY) }</ns0:CURRENCY>,
	            <ns0:RESERVE_BALANCE>{ xf:numIsNull($outputParameters/ns1:PV_CLEARING_BALANCE) }</ns0:RESERVE_BALANCE>,
	            <ns0:LOCKED_BALANCE>{ xf:numIsNull($outputParameters/ns1:PV_LOCKED_BALANCE) }</ns0:LOCKED_BALANCE>,
	            <ns0:VISA_FLOATING_BALANCE>{ xf:numIsNull($outputParameters/ns1:PV_VISA_FLOATING_BALANCE) }</ns0:VISA_FLOATING_BALANCE>,
	            <ns0:INTEREST_BALANCE>0.0</ns0:INTEREST_BALANCE>,
	            <ns0:TOTAL_BALANCE>{ xf:numIsNull($outputParameters/ns1:PV_TOTAL_BALANCE) }</ns0:TOTAL_BALANCE>,
	            <ns0:AVAILABLE_BALANCE>{ xf:numIsNull($outputParameters/ns1:PV_TOTAL_AVAILABLE_BALANCE) }</ns0:AVAILABLE_BALANCE>,
	            <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>,
	            <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
	            <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
	            <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:PV_ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
          )
            else
            (                    
                <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:PV_ERROR_CODE) }</ns0:SUCCESS_INDICATOR>,
                <ns0:ERROR_MESSAGE>{ data($outputParameters/ns1:PV_ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
            )
         }             
        </ns0:ASSET>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $TYPE as xs:string external;

xf:consultaMaestraSaldoCuentaOut($outputParameters,
    $ID,
    $TYPE)