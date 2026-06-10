<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:registrarDevolucionCobroTSP" location="../../RegistrarDevolucionCobroTSP/xsd/registrarDevolucionCobroTSPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarDevolucionCobroTSPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/devolucionCobroTSPIn/";

declare function xf:devolucionCobroTSPIn($transactionId as xs:string)
    as element(ns0:registrarDevolucionCobroTSP) {
        &lt;ns0:registrarDevolucionCobroTSP>
            &lt;TRANSACTION_ID>{ $transactionId }&lt;/TRANSACTION_ID>
        &lt;/ns0:registrarDevolucionCobroTSP>
};

declare variable $transactionId as xs:string external;

xf:devolucionCobroTSPIn($transactionId)</con:xquery>
    <con:dependency location="../../RegistrarDevolucionCobroTSP/xsd/registrarDevolucionCobroTSPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RegistrarDevolucionCobroTSP/xsd/registrarDevolucionCobroTSPTypes"/>
    </con:dependency>
</con:xqueryEntry>