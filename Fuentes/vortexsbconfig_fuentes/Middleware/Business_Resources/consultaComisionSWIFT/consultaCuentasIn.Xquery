<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaActivosClienteRequest" location="../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaComisionSWIFT/consultaCuentasIn/";

declare function xf:consultaCuentasIn($customerId as xs:string)
    as element(ns0:consultaActivosClienteRequest) {
        <ns0:consultaActivosClienteRequest>
            <CUSTOMER_ID>{ $customerId }</CUSTOMER_ID>
            <ASSET_TYPE>CTA</ASSET_TYPE>
        </ns0:consultaActivosClienteRequest>
};

declare variable $customerId as xs:string external;

xf:consultaCuentasIn($customerId)]]></con:xquery>
    <con:dependency location="../consultasCliente/Resources/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes"/>
    </con:dependency>
</con:xqueryEntry>