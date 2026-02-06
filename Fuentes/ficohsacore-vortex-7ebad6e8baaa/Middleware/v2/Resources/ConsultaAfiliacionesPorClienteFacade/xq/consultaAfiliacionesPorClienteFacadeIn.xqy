xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAfiliacionesPorClienteRequest" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAfiliacionesPorClienteFacade/xq/consultaAfiliacionesPorClienteFacadeIn/";

declare function xf:consultaAfiliacionesPorClienteFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaAfiliacionesPorClienteRequest) {
        <ns1:consultaAfiliacionesPorClienteRequest>
        {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
            <ID_CLIENTE>{ $messageListFM[1] }</ID_CLIENTE>
            )
        }
        </ns1:consultaAfiliacionesPorClienteRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaAfiliacionesPorClienteFacadeIn($procesaMensajeGenericoT24)