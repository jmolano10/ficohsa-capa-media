xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKPA/consultaCertificadoDeposito/xsd/consultaCertificadoDeposito_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultiplesProductosPAResponse/ns0:ASSETS/ns0:ASSET" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCertificadoDeposito";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaCertificadoDepositoOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaCertificadoDepositoOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $Type as xs:string)
    as element() 
{
    if ( upper-case(data($outputParameters/ns1:ERROR_CODE)) = 'SUCCESS') then (
	    <ns0:ASSET>
	        <ns0:ID>{ $ID }</ns0:ID>
	        {
	            for $DEPOSIT_NAME in $outputParameters/ns1:DEPOSIT_NAME
	            return
	        	<ns0:PRODUCT_NAME>{ data($DEPOSIT_NAME) }</ns0:PRODUCT_NAME>
	        }
	        {
	            for $CURRENCY in $outputParameters/ns1:CURRENCY
	            return
	        	<ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
	        }
	        <ns0:RESERVE_BALANCE>0.0</ns0:RESERVE_BALANCE>
            <ns0:LOCKED_BALANCE>0.0</ns0:LOCKED_BALANCE>
            <ns0:VISA_FLOATING_BALANCE>0.0</ns0:VISA_FLOATING_BALANCE>
	        <ns0:INTEREST_BALANCE>{ numIsNull($outputParameters/ns1:INTEREST_AMOUNT) }</ns0:INTEREST_BALANCE>
	        <ns0:TOTAL_BALANCE>
	        { 
	        	numIsNull($outputParameters/ns1:PRINCIPAL_AMOUNT) 
	        	+
	        	numIsNull($outputParameters/ns1:INTEREST_AMOUNT)
	        }
	        </ns0:TOTAL_BALANCE>
	        <ns0:AVAILABLE_BALANCE>{ numIsNull($outputParameters/ns1:PRINCIPAL_AMOUNT) }</ns0:AVAILABLE_BALANCE>
	        <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>
	        <ns0:TYPE>{ $Type }</ns0:TYPE>
	        <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>
	        <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
	    </ns0:ASSET>
    )
    else(
        <ns0:ASSET>
        	<ns0:ID>{ $ID }</ns0:ID>,
            <ns0:TYPE>{ $Type }</ns0:TYPE>,
            <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
            <ns0:SUCCESS_INDICATOR>{data($outputParameters/ns1:ERROR_CODE)}</ns0:SUCCESS_INDICATOR>,
            <ns0:ERROR_MESSAGE>{data($outputParameters/ns1:ERROR_MESSAGE)}</ns0:ERROR_MESSAGE>
        </ns0:ASSET>
    )
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $Type as xs:string external;

xf:consultaCertificadoDepositoOut($outputParameters,
    $ID,
    $Type)