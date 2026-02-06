xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaIntrasPorCuenta" location="../../ConsultaIntrasPorCuenta/xsd/consultaIntrasPorCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaIntrasPorCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaIntrasPorCuentaFacade/xq/consultaIntrasPorCuentaIn/";

declare function xf:consultaIntrasPorCuentaIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaIntrasPorCuenta) {
        <ns1:consultaIntrasPorCuenta>
        {
        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return(
	            <SEARCH_VALUE>{ $messageListFM[1] }</SEARCH_VALUE>,
	            <SEARCH_CRITERIA>{ $messageListFM[2] }</SEARCH_CRITERIA>
            )
        }
        </ns1:consultaIntrasPorCuenta>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaIntrasPorCuentaIn($procesaMensajeGenericoT24)