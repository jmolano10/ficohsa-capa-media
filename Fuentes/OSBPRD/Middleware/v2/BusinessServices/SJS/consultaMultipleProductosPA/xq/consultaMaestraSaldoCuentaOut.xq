(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultiplesProductosPAResponse/ns0:ASSETS/ns0:ASSET" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaMaestraSaldoCuentaOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaMaestraSaldoCuentaOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $Type as xs:string)
    as element() 
{
    <ns0:ASSET>
        <ns0:ID>{ $ID }</ns0:ID>
            {
                let $successIndicator := upper-case(data($outputParameters/ns1:PV_ERROR_CODE))
                return
	            if($successIndicator = 'SUCCESS')then(
        			
        			for $PV_ACCOUNT_NAME in $outputParameters/ns1:PV_ACCOUNT_NAME
        			return
        				<ns0:PRODUCT_NAME>{ data($PV_ACCOUNT_NAME) }</ns0:PRODUCT_NAME>,
        		
                	for $PV_CURRENCY in $outputParameters/ns1:PV_CURRENCY
                	return
                		<ns0:CURRENCY>{ data($PV_CURRENCY) }</ns0:CURRENCY>,
                		
                    <ns0:RESERVE_BALANCE>{ numIsNull($outputParameters/ns1:PV_CLEARING_BALANCE) }</ns0:RESERVE_BALANCE>,
                    <ns0:LOCKED_BALANCE>{ numIsNull($outputParameters/ns1:PV_LOCKED_BALANCE) }</ns0:LOCKED_BALANCE>,
	                <ns0:VISA_FLOATING_BALANCE>{ numIsNull($outputParameters/ns1:PV_VISA_FLOATING_BALANCE) }</ns0:VISA_FLOATING_BALANCE>,
	                <ns0:INTEREST_BALANCE>0.0</ns0:INTEREST_BALANCE>,
	                <ns0:TOTAL_BALANCE>{ numIsNull($outputParameters/ns1:PV_TOTAL_BALANCE) }</ns0:TOTAL_BALANCE>,
	                <ns0:AVAILABLE_BALANCE>{ numIsNull($outputParameters/ns1:PV_TOTAL_AVAILABLE_BALANCE) }</ns0:AVAILABLE_BALANCE>,
	                <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>,
	                <ns0:TYPE>{ $Type }</ns0:TYPE>,
	                <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
	                <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:PV_ERROR_CODE) }</ns0:SUCCESS_INDICATOR>   
	            )else(
	                <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
	                <ns0:TYPE>{ $Type }</ns0:TYPE>,
	                <ns0:SUCCESS_INDICATOR>
	                { 
	                	if(data($outputParameters/ns1:PV_ERROR_CODE) != '')then(
	                		data($outputParameters/ns1:PV_ERROR_CODE)
	                	)else('ERROR')
	                }
	                </ns0:SUCCESS_INDICATOR>,
	                for $PV_ERROR_MESSAGE in $outputParameters/ns1:PV_ERROR_MESSAGE
	                return
	                	<ns0:ERROR_MESSAGE>{ data($PV_ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
	           )
        } 
    </ns0:ASSET>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $Type as xs:string external;

xf:consultaMaestraSaldoCuentaOut($outputParameters,
    $ID,
    $Type)