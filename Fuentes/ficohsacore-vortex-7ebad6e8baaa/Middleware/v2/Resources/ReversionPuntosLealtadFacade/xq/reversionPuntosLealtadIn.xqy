xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversionPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtadFacade/xq/reversionPuntosLealtadIn/";

declare function xf:reversionPuntosLealtadIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:reversionPuntosLealtad) {
        <ns0:reversionPuntosLealtad>
            {
            	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        		return(
		            <CUSTOMER_ID_TYPE>{ data($messageListFM[1]) }</CUSTOMER_ID_TYPE>,
		            <CUSTOMER_ID_VALUE>{ data($messageListFM[2]) }</CUSTOMER_ID_VALUE>,
		            <CREDIT_DESCRIPTION>{ data($messageListFM[3]) }</CREDIT_DESCRIPTION>,
					<REDEMPTION_ID>{ data($messageListFM[4]) }</REDEMPTION_ID>,
		            <USER_ID>{ data($messageListFM[5]) }</USER_ID>
		        )
            }
        </ns0:reversionPuntosLealtad>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:reversionPuntosLealtadIn($procesaMensajeGenericoT24)