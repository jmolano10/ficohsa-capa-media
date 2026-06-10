<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$tarjetasdecreditoporclienteResponse1" element="ns0:TarjetasdecreditoporclienteResponse" location="../../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldosTarjetaCredito" location="../../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosTCBodyIn/";

declare function xf:consultaSaldosTCBodyIn($tarjetasdecreditoporclienteResponse1 as element(ns0:TarjetasdecreditoporclienteResponse),
    $counter as xs:integer)
    as element(ns1:consultaSaldosTarjetaCredito) {
        &lt;ns1:consultaSaldosTarjetaCredito>
            &lt;CARD_NUMBER>{ data($tarjetasdecreditoporclienteResponse1/FICOLISTCLIENTCARDCPType[1]/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType[STATUS!="29 - TARJETA DADA DE BAJA" and CATEGORY!="Additional"][xs:integer($counter)]/CARDNO) }&lt;/CARD_NUMBER>
        &lt;/ns1:consultaSaldosTarjetaCredito>
};

declare variable $tarjetasdecreditoporclienteResponse1 as element(ns0:TarjetasdecreditoporclienteResponse) external;
declare variable $counter as xs:integer external;

xf:consultaSaldosTCBodyIn($tarjetasdecreditoporclienteResponse1,
    $counter)</con:xquery>
    <con:dependency location="../../Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
    <con:dependency location="../../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>