<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaListasCliente1" element="ns0:consultaListasCliente" location="../xsd/consultaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DataWarehouse/ConsultaListasCliente/xsd/ConsultaListasClienteNI_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaListasClienteNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/consultaListasClienteNIIn/";

declare function xf:consultaListasClienteNIIn($customerId as xs:string)
    as element(ns1:InputParameters) {
        let $customerId1 := $customerId
        return
			&lt;ns1:InputParameters>
                &lt;ns1:IDENTIDAD>{ data($customerId1) }&lt;/ns1:IDENTIDAD>
            &lt;/ns1:InputParameters>
};

declare variable $customerId as xs:string external;

xf:consultaListasClienteNIIn($customerId)</con:xquery>
    <con:dependency location="../xsd/consultaListasClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/consultaListasClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DataWarehouse/ConsultaListasCliente/xsd/ConsultaListasClienteNI_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DataWarehouse/ConsultaListasCliente/xsd/ConsultaListasClienteNI_sp"/>
    </con:dependency>
</con:xqueryEntry>