<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/RegistroTransaccionesBALCAM/xsd/registroTransaccionesBalcam_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroTransaccionesBalcam";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroTransaccionesBALCAM/xq/registroTransaccionesBALCAMIn/";

declare function xf:registroTransaccionesBALCAMIn($transactions as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_SET_TRANSACCIONES>{ $transactions }&lt;/ns0:PV_SET_TRANSACCIONES>
        &lt;/ns0:InputParameters>
};

declare variable $transactions as xs:string external;

xf:registroTransaccionesBALCAMIn($transactions)</con:xquery>
    <con:dependency location="../../../BusinessServices/RegistroTransaccionesBALCAM/xsd/registroTransaccionesBalcam_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/RegistroTransaccionesBALCAM/xsd/registroTransaccionesBalcam_sp"/>
    </con:dependency>
</con:xqueryEntry>