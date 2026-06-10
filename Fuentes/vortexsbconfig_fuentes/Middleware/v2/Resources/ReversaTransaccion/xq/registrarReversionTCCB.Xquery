<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion1" element="ns1:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/xsd/registrarReversionTCCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReversionTCCB";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaTransaccion/xq/registrarReversionTCCB/";

declare function xf:registrarReversionTCCB($reversarTransaccion1 as element(ns1:reversarTransaccion))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_TRANSACTION_ID>{ data($reversarTransaccion1/TRANSACTION_ID) }&lt;/ns0:PV_TRANSACTION_ID>
        &lt;/ns0:InputParameters>
};

declare variable $reversarTransaccion1 as element(ns1:reversarTransaccion) external;

xf:registrarReversionTCCB($reversarTransaccion1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/xsd/registrarReversionTCCB_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/xsd/registrarReversionTCCB_sp"/>
    </con:dependency>
</con:xqueryEntry>