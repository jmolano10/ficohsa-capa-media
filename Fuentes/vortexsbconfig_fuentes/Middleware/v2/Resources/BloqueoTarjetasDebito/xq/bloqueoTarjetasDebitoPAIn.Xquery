<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueoTarjetasDebito" element="ns1:bloqueoTarjetasDebito" location="../../../../Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/bloqueoTarjetaDebito/xsd/bloqueoTarjetaDebito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/bloqueoTarjetaDebito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueoTarjetasDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoTarjetasDebito/xq/bloqueoTarjetasDebitoPAIn/";

declare function xf:bloqueoTarjetasDebitoPAIn($bloqueoTarjetasDebito as element(ns1:bloqueoTarjetasDebito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_DEBIT_CARD_NUMBER>{ data($bloqueoTarjetasDebito/DEBIT_CARD_NUMBER) }</ns0:PV_DEBIT_CARD_NUMBER>
            <ns0:PV_BLOCK_MOTIVE>{ data($bloqueoTarjetasDebito/BLOCK_MOTIVE) }</ns0:PV_BLOCK_MOTIVE>
        </ns0:InputParameters>
};

declare variable $bloqueoTarjetasDebito as element(ns1:bloqueoTarjetasDebito) external;

xf:bloqueoTarjetasDebitoPAIn($bloqueoTarjetasDebito)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/bloqueoTarjetaDebito/xsd/bloqueoTarjetaDebito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/bloqueoTarjetaDebito/xsd/bloqueoTarjetaDebito_sp"/>
    </con:dependency>
</con:xqueryEntry>