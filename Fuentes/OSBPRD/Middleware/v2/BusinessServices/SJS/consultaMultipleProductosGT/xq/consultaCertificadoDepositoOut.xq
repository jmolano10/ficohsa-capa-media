(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosGTResponse/ns0:ASSETS/ns0:ASSET" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCertificadoDeposito";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaCertificadoDepositoOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};


declare function xf:consultaCertificadoDepositoOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $TYPE as xs:string)
    as element() {
        <ns0:ASSET>
        	<ns0:ID>{ $ID }</ns0:ID>
            {
             	if(string($outputParameters/ns1:ERROR_CODE/text()) = "SUCCESS") then( 
                 	<ns0:PRODUCT_NAME>{ data($outputParameters/ns1:DEPOSIT_NAME) }</ns0:PRODUCT_NAME>,
                    <ns0:CURRENCY>{ data($outputParameters/ns1:CURRENCY) }</ns0:CURRENCY>,
                    <ns0:RESERVE_BALANCE>0.0</ns0:RESERVE_BALANCE>,
                    <ns0:LOCKED_BALANCE>0.0</ns0:LOCKED_BALANCE>,
                    <ns0:VISA_FLOATING_BALANCE>0.0</ns0:VISA_FLOATING_BALANCE>,
                    
                    let $interestAmount  :=  numIsNull($outputParameters/ns1:INTEREST_AMOUNT)
                    let $principalAmount :=  numIsNull($outputParameters/ns1:PRINCIPAL_AMOUNT)
                    return(
	                    <ns0:INTEREST_BALANCE>{ $interestAmount }</ns0:INTEREST_BALANCE>,
	                    <ns0:TOTAL_BALANCE>{ $principalAmount + $interestAmount }</ns0:TOTAL_BALANCE>,
	                    <ns0:AVAILABLE_BALANCE>{ $principalAmount }</ns0:AVAILABLE_BALANCE> 
                    ),
                         
                    <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>,              
                    <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                    <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                    <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
                    
                    
                 )else(
                    <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                    <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                    <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>,
                    <ns0:ERROR_MESSAGE>{ data($outputParameters/ns1:ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
                  )
               }
           </ns0:ASSET>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $TYPE as xs:string external;

xf:consultaCertificadoDepositoOut($outputParameters,
    $ID,
    $TYPE)