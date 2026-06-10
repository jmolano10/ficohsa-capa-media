<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionLote" element="ns0:consultaTransaccionLote" location="../xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransaccionLote" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaTransaccionLoteIn/";

declare function xf:consultaTransaccionLoteIn($consultaTransaccionLote as element(ns0:consultaTransaccionLote))
    as element(ns0:consultaTransaccionLote) {
        <ns0:consultaTransaccionLote>
            <CUSTOMER_ID>{ data($consultaTransaccionLote/CUSTOMER_ID) }</CUSTOMER_ID>
            <TXN_REFERENCE>{ data($consultaTransaccionLote/TXN_REFERENCE) }</TXN_REFERENCE>
        </ns0:consultaTransaccionLote>
};

declare variable $consultaTransaccionLote as element(ns0:consultaTransaccionLote) external;

xf:consultaTransaccionLoteIn($consultaTransaccionLote)]]></con:xquery>
    <con:dependency location="../xsd/pagosMasivosTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
</con:xqueryEntry>