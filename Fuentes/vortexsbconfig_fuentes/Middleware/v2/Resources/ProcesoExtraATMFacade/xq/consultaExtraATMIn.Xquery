<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaExtraATMRequest" location="../../ConsultaExtraATM/xsd/consultaExtraATMTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtraATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesoExtraATMFacade/xq/consultaExtraATMIn/";

declare function xf:consultaExtraATMIn($debitCardNumber as xs:string)
    as element(ns1:consultaExtraATMRequest) {
        <ns1:consultaExtraATMRequest>
            <PRODUCT_TYPE>DEBIT_CARD</PRODUCT_TYPE>
            <PRODUCT_VALUE>{ $debitCardNumber }</PRODUCT_VALUE>
        </ns1:consultaExtraATMRequest>
};

declare variable $debitCardNumber as xs:string external;

xf:consultaExtraATMIn($debitCardNumber)]]></con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaExtraATM/xsd/consultaExtraATMTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaExtraATM/xsd/consultaExtraATMTypes"/>
    </con:dependency>
</con:xqueryEntry>