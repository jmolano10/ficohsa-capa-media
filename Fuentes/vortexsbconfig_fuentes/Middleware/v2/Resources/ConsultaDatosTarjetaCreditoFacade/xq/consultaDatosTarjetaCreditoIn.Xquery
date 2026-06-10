<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCreditoFacade/xq/consultaDatosTarjetaCreditoIn/";

declare function xf:consultaDatosTarjetaCreditoIn($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaDatosTarjetaCredito) {
        &lt;ns1:consultaDatosTarjetaCredito>
            &lt;CARD_NUMBER>{ data($procesaMensajeGenericoT241/MESSAGE) }&lt;/CARD_NUMBER>
        &lt;/ns1:consultaDatosTarjetaCredito>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaDatosTarjetaCreditoIn($procesaMensajeGenericoT241)</con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
    <con:dependency location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>