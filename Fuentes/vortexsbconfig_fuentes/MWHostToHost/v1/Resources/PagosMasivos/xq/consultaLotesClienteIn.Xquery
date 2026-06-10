<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesCliente" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaLotesClienteIn/";

declare function xf:consultaLotesClienteIn($consultaLotesCliente as element(ns0:consultaLotesCliente))
    as element(ns0:consultaLotesCliente) {
        <ns0:consultaLotesCliente>
            <CUSTOMER_ID>{ data($consultaLotesCliente/CUSTOMER_ID) }</CUSTOMER_ID>
            <BEGIN_DATE>{ data($consultaLotesCliente/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($consultaLotesCliente/END_DATE) }</END_DATE>
        </ns0:consultaLotesCliente>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;

xf:consultaLotesClienteIn($consultaLotesCliente)]]></con:xquery>
    <con:dependency location="../xsd/pagosMasivosTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
</con:xqueryEntry>