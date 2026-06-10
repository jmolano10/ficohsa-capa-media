<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarProveedoresPagosMasivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedoresPagosMasivos/xq/consultaProveedoresPagosMasivosHNHeaderOut/";

declare function xf:consultaProveedoresPagosMasivosHNHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
	            let $successIndicator := fn:string($outputParameters/ns1:PV_CODIGOMENSAJE/text())
	        	let $message := fn:string($outputParameters/ns1:PV_DESCRIPCIONMENSAJE/text())
	        	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	)
	        }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaProveedoresPagosMasivosHNHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>