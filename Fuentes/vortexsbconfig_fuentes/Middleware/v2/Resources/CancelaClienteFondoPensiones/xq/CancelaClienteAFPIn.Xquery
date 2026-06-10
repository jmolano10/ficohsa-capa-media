<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelaClienteFondoPensionesRequest" element="ns0:cancelaClienteFondoPensionesRequest" location="../xsd/cancelaClienteFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/CancelaClienteAFP/xsd/CancelaClienteAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CancelaClienteAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cancelaClienteFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaClienteFondoPensiones/xq/CancelaClienteAFPIn/";

declare function xf:CancelaClienteAFPIn($cancelaClienteFondoPensionesRequest as element(ns0:cancelaClienteFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_MONEDA>{ data($cancelaClienteFondoPensionesRequest/CURRENCY) }</ns1:PV_TIPO_MONEDA>
            <ns1:PV_CODIGO_DEUDOR>{ data($cancelaClienteFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
        </ns1:InputParameters>
};

declare variable $cancelaClienteFondoPensionesRequest as element(ns0:cancelaClienteFondoPensionesRequest) external;

xf:CancelaClienteAFPIn($cancelaClienteFondoPensionesRequest)]]></con:xquery>
    <con:dependency location="../xsd/cancelaClienteFondoPensionesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CancelaClienteFondoPensiones/xsd/cancelaClienteFondoPensionesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKHN/FondoPensiones/CancelaClienteAFP/xsd/CancelaClienteAFP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKHN/FondoPensiones/CancelaClienteAFP/xsd/CancelaClienteAFP_sp"/>
    </con:dependency>
</con:xqueryEntry>