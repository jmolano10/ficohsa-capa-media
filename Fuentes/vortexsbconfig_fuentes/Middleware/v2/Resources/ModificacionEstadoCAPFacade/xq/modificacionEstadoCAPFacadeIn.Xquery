<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:modificacionEstadoCAPRequest" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificacionEstadoCAPFacade/xq/modificacionEstadoCAPFacadeIn/";

declare function xf:modificacionEstadoCAPFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:modificacionEstadoCAPRequest) {
    <ns1:modificacionEstadoCAPRequest>
    {
    let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
            <ID_CAP>{ $messageListFM[1] }</ID_CAP>,
            <ESTADO>{ $messageListFM[2] }</ESTADO>,
            <OFICIAL_MODIFICACION>{ $messageListFM[3] }</OFICIAL_MODIFICACION>,
            <OFICIAL_AUTORIZADOR_MODIFICADOR>{ $messageListFM[4] }</OFICIAL_AUTORIZADOR_MODIFICADOR>,
            <AGENCIA>{ $messageListFM[5] }</AGENCIA>
        )
    }
    </ns1:modificacionEstadoCAPRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:modificacionEstadoCAPFacadeIn($procesaMensajeGenericoT24)]]></con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd"/>
    <con:dependency location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd"/>
</con:xqueryEntry>