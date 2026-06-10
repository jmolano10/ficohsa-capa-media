<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest1" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversaCuponATM" location="../xsd/reversaCuponATMTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversaCuponATMTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/reversarATMConCupon/";

declare function xf:reversarATMConCupon($procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:reversaCuponATM) {
        &lt;ns1:reversaCuponATM>
            &lt;RETRIEVAL_REFERENCE>{ $procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037/@* , $procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037/node() }&lt;/RETRIEVAL_REFERENCE>
        &lt;/ns1:reversaCuponATM>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:reversarATMConCupon($procesaMensajeGenericoSwitchFacadeRequest1)</con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/reversaCuponATMTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ReversaCuponATM/xsd/reversaCuponATMTypes"/>
    </con:dependency>
</con:xqueryEntry>