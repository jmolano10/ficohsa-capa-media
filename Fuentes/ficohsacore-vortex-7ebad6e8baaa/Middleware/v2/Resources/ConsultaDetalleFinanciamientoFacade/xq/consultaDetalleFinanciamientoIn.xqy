xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleFinanciamiento" location="../../ConsultaDetalleFinanciamiento/xsd/consultaDetalleFinanciamientoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamientoFacade/xq/consultaDetalleFinanciamientoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";

declare function xf:consultaDetalleFinanciamientoIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaDetalleFinanciamiento) {
        <ns1:consultaDetalleFinanciamiento>
        {
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return (
        		<ORG>{ $messageList[1] }</ORG>,
        		<ACCOUNT_NUMBER>{ $messageList[2] }</ACCOUNT_NUMBER>,
        		<PLAN_NUMBER>{ $messageList[3] }</PLAN_NUMBER>,
        		<SECUENCE_NUMBER>{ $messageList[4] }</SECUENCE_NUMBER>,
        		<CANCELLATION_DATE>{ $messageList[5] }</CANCELLATION_DATE>,
        		if($messageList[6] != "") then (
        			<PAYMENT_AMOUNT>{ $messageList[6] }</PAYMENT_AMOUNT>
        		) else (),
        		if($messageList[7] != "") then (
        			<PAYMENT_TYPE>{ $messageList[7] }</PAYMENT_TYPE>
        		) else ()
        	)
        }
        </ns1:consultaDetalleFinanciamiento>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaDetalleFinanciamientoIn($procesaMensajeGenericoT24)