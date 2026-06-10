<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaFirmaDigital" location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaFirmaDigitalFacade/xq/ValidaFirmaDigitalFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesPagosGlobalesTypes";

declare function xf:ValidaFirmaDigitalFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:validaFirmaDigital) {
        <ns1:validaFirmaDigital>
      {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return
         (
          <LAU_APPLICATION_ID>{$messageListFM[1]}</LAU_APPLICATION_ID>,
          <LAU_CALLTIME>{$messageListFM[2]}</LAU_CALLTIME>,
          <LAU_REQUEST_NONCE>{$messageListFM[3]}</LAU_REQUEST_NONCE>,
          <LAU_RESPONSE_NONCE>{$messageListFM[4]}</LAU_RESPONSE_NONCE>,
          <LAU_VERSION>{$messageListFM[5]}</LAU_VERSION>,
          <LAU_SIGNATURE>{$messageListFM[6]}</LAU_SIGNATURE>,
          <MESSAGE>{$messageListFM[7]}</MESSAGE>
        )                   
      }
    </ns1:validaFirmaDigital>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:ValidaFirmaDigitalFacadeIn($procesaMensajeGenericoT24)]]></con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
    <con:dependency location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes"/>
    </con:dependency>
</con:xqueryEntry>