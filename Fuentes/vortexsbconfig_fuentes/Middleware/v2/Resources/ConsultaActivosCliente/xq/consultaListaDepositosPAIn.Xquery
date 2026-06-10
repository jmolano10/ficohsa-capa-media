<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns0:consultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaListaDepositos/consultaListaDepositosIn/";

declare function xf:consultaListaDepositosIn($consultaActivosClienteRequest1 as element(ns0:consultaActivosClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:ASSET_TYPE>{ data($consultaActivosClienteRequest1/ASSET_TYPE) }</ns1:ASSET_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaActivosClienteRequest1 as element(ns0:consultaActivosClienteRequest) external;

xf:consultaListaDepositosIn($consultaActivosClienteRequest1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>