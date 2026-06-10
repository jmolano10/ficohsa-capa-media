<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteTRCHNHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaCliente";

declare function xf:validaProductoClienteTRCHNHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
	        	if(data($outputParameters/ns1:CodigoError) = '-1') then(
		    			<successIndicator>Success</successIndicator>
		    	)else(
		    		<successIndicator>ERROR</successIndicator>,
		    		<messages>{ data($outputParameters/ns1:MensajeError) }</messages>
		    	)
	    	}
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClienteTRCHNHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElementsCB.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElementsCB"/>
    </con:dependency>
</con:xqueryEntry>