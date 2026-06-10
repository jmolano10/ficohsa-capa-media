<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/creaPrestamo/xsd/creaPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaPrestamoResponse" location="../../OperacionesPrestamo/xsd/operacionesPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creaPrestamo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesPrestamo/xq/creaPrestamoOut/";

declare function xf:creaPrestamoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:creaPrestamoResponse) {
        <ns0:creaPrestamoResponse>
            <LOAN_NUMBER>{ data($outputParameters/ns1:PV_NUMERO_PRESTAMO) }</LOAN_NUMBER>
            <LOAN_CONTRACT>{ data($outputParameters/ns1:PN_NUMERO_CONTRATO) }</LOAN_CONTRACT>
            <GUARANTEE_NUMBER>{ data($outputParameters/ns1:PN_NUMERO_GARANTIA) }</GUARANTEE_NUMBER>
        </ns0:creaPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:creaPrestamoOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABK/creaPrestamo/xsd/creaPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/creaPrestamo/xsd/creaPrestamo_sp"/>
    </con:dependency>
    <con:dependency location="../../OperacionesPrestamo/xsd/operacionesPrestamoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesPrestamo/xsd/operacionesPrestamoTypes"/>
    </con:dependency>
</con:xqueryEntry>