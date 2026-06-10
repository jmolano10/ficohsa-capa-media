<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaLineasCreditoCliente" element="ns0:consultaLineasCreditoCliente" location="../../ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLineasCreditoCliente/xq/consultaLineasCreditoClienteHNIn1/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosLineasCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";

declare function xf:consultaLineasCreditoClienteHNIn1($consultaLineasCreditoCliente as element(ns0:consultaLineasCreditoCliente))
    as element(ns1:InputParameters) {
         <ns1:InputParameters>
         {
	    	let $QUERY_TYPE := $consultaLineasCreditoCliente/CUSTOMER_QUERY/TYPE
	    	let $QUERY_VALUE := $consultaLineasCreditoCliente/CUSTOMER_QUERY/VALUE
	    	return
		    	if($QUERY_TYPE = "CUSTOMER_ID")then(
		        	<ns1:P_CUSTOMER_ID>{ data($QUERY_VALUE) }</ns1:P_CUSTOMER_ID>
		        )else if($QUERY_TYPE = "CREDIT_LINE_ID")then(
		        	<ns1:P_CRED_LINE_ID>{ data($QUERY_VALUE) }</ns1:P_CRED_LINE_ID>
		        )else()
         }
        </ns1:InputParameters>
};

declare variable $consultaLineasCreditoCliente as element(ns0:consultaLineasCreditoCliente) external;

xf:consultaLineasCreditoClienteHNIn1($consultaLineasCreditoCliente)]]></con:xquery>
    <con:dependency location="../../ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>