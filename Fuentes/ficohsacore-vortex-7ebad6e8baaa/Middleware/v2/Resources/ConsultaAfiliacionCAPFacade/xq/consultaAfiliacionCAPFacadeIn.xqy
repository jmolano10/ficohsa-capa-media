xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAfiliacionCAPRequest" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAfiliacionCAPFacade/xq/consultaAfiliacionCAPFacadeIn/";

declare function xf:consultaAfiliacionCAPFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaAfiliacionCAPRequest) {
        <ns1:consultaAfiliacionCAPRequest>
        {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
            <CUENTA_AP>{ $messageListFM[1] }</CUENTA_AP>
            )
        }
        </ns1:consultaAfiliacionCAPRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaAfiliacionCAPFacadeIn($procesaMensajeGenericoT24)