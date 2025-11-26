(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelaFinanciamiento" location="../../CancelaFinanciamiento/xsd/cancelaFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CancelaFinanciamientoFacade/xq/cancelaFinanciamientoIn/";

declare function xf:cancelaFinanciamientoIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:cancelaFinanciamiento) {
        <ns1:cancelaFinanciamiento>
        {
        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	        return(
		        <ORG>{ $messageListFM[1] }</ORG>,
	            <ACCOUNT_NUMBER>{ $messageListFM[2] }</ACCOUNT_NUMBER>,
	            <PLAN_NUMBER>{ $messageListFM[3] }</PLAN_NUMBER>,
	            <SECUENCE_NUMBER>{ $messageListFM[4] }</SECUENCE_NUMBER>,
	            <REFERENCE_NUMBER>{ $messageListFM[5] }</REFERENCE_NUMBER>,
	            <CANCELLATION_DATE>{ $messageListFM[6] }</CANCELLATION_DATE>,
	            <AMOUNT>{ $messageListFM[7] }</AMOUNT>,
	            <TYPE>{ $messageListFM[8] }</TYPE>
	        )
        }
        </ns1:cancelaFinanciamiento>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:cancelaFinanciamientoIn($procesaMensajeGenericoT24)