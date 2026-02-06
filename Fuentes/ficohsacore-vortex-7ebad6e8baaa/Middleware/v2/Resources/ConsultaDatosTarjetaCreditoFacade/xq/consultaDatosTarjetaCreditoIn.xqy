xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCreditoFacade/xq/consultaDatosTarjetaCreditoIn/";

declare function xf:consultaDatosTarjetaCreditoIn($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaDatosTarjetaCredito) {
        <ns1:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ data($procesaMensajeGenericoT241/MESSAGE) }</CARD_NUMBER>
        </ns1:consultaDatosTarjetaCredito>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaDatosTarjetaCreditoIn($procesaMensajeGenericoT241)