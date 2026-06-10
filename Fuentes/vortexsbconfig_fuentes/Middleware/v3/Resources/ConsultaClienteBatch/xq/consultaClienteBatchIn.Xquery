<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest" element="ns0:consultaClienteRequest" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaClienteBatch/xsd/ConsultaClienteBatch_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaClienteBatch";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchIn/";

declare function xf:consultaClienteBatchIn($consultaClienteRequest as element(ns0:consultaClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        {
	        if (fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_TYPE/text()) = ("CODE","CUSTOMER_ID")) then (
	        	<ns1:PV_CUSTOMER_ID>{ data($consultaClienteRequest/ns0:CUSTOMER_ID_VALUE) }</ns1:PV_CUSTOMER_ID>
	        )else if (fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_TYPE/text()) = ("LEGAL_ID")) then (
	        	<ns1:PV_LEGAL_ID>{ data($consultaClienteRequest/ns0:CUSTOMER_ID_VALUE) }</ns1:PV_LEGAL_ID>
	        )else (
	        )
	     }
        </ns1:InputParameters>
};

declare variable $consultaClienteRequest as element(ns0:consultaClienteRequest) external;

xf:consultaClienteBatchIn($consultaClienteRequest)]]></con:xquery>
    <con:dependency location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ConsultaClienteBatch/xsd/ConsultaClienteBatch_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ConsultaClienteBatch/xsd/ConsultaClienteBatch_sp"/>
    </con:dependency>
</con:xqueryEntry>