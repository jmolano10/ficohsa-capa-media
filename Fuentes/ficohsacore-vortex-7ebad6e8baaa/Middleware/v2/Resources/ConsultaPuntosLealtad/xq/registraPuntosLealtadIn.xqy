xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPuntosLealtad" element="ns0:consultaPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraPuntosLealtad/xsd/registraPuntosLealtad_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPuntosLealtad";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/registraPuntosLealtadIn/";

declare function xf:registraPuntosLealtadIn($requestHeader as element(ns1:RequestHeader),
    $consultaPuntosLealtad as element(ns0:consultaPuntosLealtad),
    $legalId as xs:string,
    $customerName as xs:string,
    $balance as xs:decimal,
    $cashEquivalent as xs:decimal?,
    $cashCurrency as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns2:PV_CODIGO_PAIS>
            <ns2:PV_CUSTOMER_ID_TYPE>{ data($consultaPuntosLealtad/CUSTOMER_ID_TYPE) }</ns2:PV_CUSTOMER_ID_TYPE>
            <ns2:PV_CUSTOMER_ID_VALUE>{ data($consultaPuntosLealtad/CUSTOMER_ID_VALUE) }</ns2:PV_CUSTOMER_ID_VALUE>
            {
            	if($consultaPuntosLealtad/RETURN_CASH_EQUIVALENT/text() = "YES") then (
            		for $CARD_NUMBER in $consultaPuntosLealtad/CASH_REDEMPTION/CARD_NUMBER
            		return
            		if($CARD_NUMBER/text() != "") then (
            			<ns2:PV_CARD_NUMBER>{ data($CARD_NUMBER) }</ns2:PV_CARD_NUMBER>
            		) else (),
            		for $MERCHANT_ID in $consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_ID
            		return
            		if($MERCHANT_ID/text() != "") then (
            			<ns2:PV_MERCHANT_ID>{ data($MERCHANT_ID) }</ns2:PV_MERCHANT_ID>
            		) else (),
            		for $MERCHANT_TYPE in $consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_TYPE
            		return
            		if($MERCHANT_TYPE/text() != "") then (
            			<ns2:PV_MERCHANT_TYPE>{ data($MERCHANT_TYPE) }</ns2:PV_MERCHANT_TYPE>
            		) else (),
            		for $TERMINAL_ID in $consultaPuntosLealtad/CASH_REDEMPTION/TERMINAL_ID
            		return
            		if($TERMINAL_ID/text() != "") then (
            			<ns2:PV_TERMINAL_ID>{ data($TERMINAL_ID) }</ns2:PV_TERMINAL_ID>
            		) else ()
            	) else ()
            }
            <ns2:PT_PUNTOS_LEALTAD>
                <ns2:LEGAL_ID>{ $legalId }</ns2:LEGAL_ID>
                 {
                	let $CUSTOMER_NAME := substring(normalize-space($customerName), 1, 60)
                	return
                		 <ns2:CUSTOMER_NAME>{$CUSTOMER_NAME}</ns2:CUSTOMER_NAME>
                }                                
    				<ns2:BALANCE>{ $balance }</ns2:BALANCE>                     
                {
            		if($consultaPuntosLealtad/RETURN_CASH_EQUIVALENT/text() = "YES") then (
            			if(xs:string($cashEquivalent) != "") then (
            				<ns2:CASH_EQUIVALENT>{ $cashEquivalent }</ns2:CASH_EQUIVALENT>
            			)else(
							<ns2:CASH_EQUIVALENT>0</ns2:CASH_EQUIVALENT>            			
            			 ),            			
        				<ns2:CASH_CURRENCY>{ $cashCurrency }</ns2:CASH_CURRENCY>
            		) else ()
            	}
            </ns2:PT_PUNTOS_LEALTAD>
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $consultaPuntosLealtad as element(ns0:consultaPuntosLealtad) external;
declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $balance as xs:decimal external;
declare variable $cashEquivalent as xs:decimal? external;
declare variable $cashCurrency as xs:string external;

xf:registraPuntosLealtadIn($requestHeader,
    $consultaPuntosLealtad,
    $legalId,
    $customerName,
    $balance,
    $cashEquivalent,
    $cashCurrency)