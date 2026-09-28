(:: pragma bea:global-element-parameter parameter="$consultaPuntosLealtad" element="ns0:consultaPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaPuntosLealtad/xsd/consultaPuntosLealtad_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPuntosLealtad";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/consultaPuntosLealtadIn/";

declare function xf:consultaPuntosLealtadIn($consultaPuntosLealtad as element(ns0:consultaPuntosLealtad),
    $requestHeader as element(ns1:RequestHeader))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns2:PV_CODIGO_PAIS>
            <ns2:PV_CUSTOMER_ID_TYPE>{ data($consultaPuntosLealtad/CUSTOMER_ID_TYPE) }</ns2:PV_CUSTOMER_ID_TYPE>
            <ns2:PV_CUSTOMER_ID_VALUE>{ data($consultaPuntosLealtad/CUSTOMER_ID_VALUE) }</ns2:PV_CUSTOMER_ID_VALUE>
            <ns2:PV_CASH_EQUIVALENT>{ data($consultaPuntosLealtad/RETURN_CASH_EQUIVALENT) }</ns2:PV_CASH_EQUIVALENT>
            {
            	for $CARD_NUMBER in $consultaPuntosLealtad/CASH_REDEMPTION/CARD_NUMBER
            	return
            	if(string($CARD_NUMBER/text()) != "") then (
            		<ns2:PV_CARD_NUMBER>{ data($CARD_NUMBER) }</ns2:PV_CARD_NUMBER>
            	) else ()
            }
            {
            	for $MERCHANT_ID in $consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_ID
            	return
            	if(string($MERCHANT_ID/text()) != "") then (
            		<ns2:PV_MERCHANT_ID>{ data($MERCHANT_ID) }</ns2:PV_MERCHANT_ID>
            	) else()
            }
            {
            	for $MERCHANT_TYPE in $consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_TYPE
            	return
            	if(string($MERCHANT_TYPE/text()) != "") then (
            		<ns2:PV_MERCHANT_TYPE>{ data($MERCHANT_TYPE) }</ns2:PV_MERCHANT_TYPE>
            	) else ()
            }
            {
            	for $TERMINAL_ID in $consultaPuntosLealtad/CASH_REDEMPTION/TERMINAL_ID
            	return
            	if(string($TERMINAL_ID/text()) != "") then (
            		<ns2:PV_TERMINAL_ID>{ data($TERMINAL_ID) }</ns2:PV_TERMINAL_ID>
            	) else ()
            }
        </ns2:InputParameters>
};

declare variable $consultaPuntosLealtad as element(ns0:consultaPuntosLealtad) external;
declare variable $requestHeader as element(ns1:RequestHeader) external;

xf:consultaPuntosLealtadIn($consultaPuntosLealtad,
    $requestHeader)