<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaChequesReserva1" element="ns0:consultaChequesReserva" location="../../../../Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaChequesReserva/xsd/consultaChequesReserva_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaChequesReserva";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaChequesReserva/xq/consultaChequesReservaIn/";

declare function xf:consultaChequesReservaIn($consultaChequesReserva1 as element(ns0:consultaChequesReserva))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:ACCOUNT_NUMBER>{ data($consultaChequesReserva1/ACCOUNT_NUMBER) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaChequesReserva1 as element(ns0:consultaChequesReserva) external;

xf:consultaChequesReservaIn($consultaChequesReserva1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaChequesReserva/xsd/consultaChequesReserva_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaChequesReserva/xsd/consultaChequesReserva_sp"/>
    </con:dependency>
</con:xqueryEntry>