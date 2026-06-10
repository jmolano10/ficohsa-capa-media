<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerInfoUsuarioAPP/xq/consultaCuentaClienteUnicoHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaClienteUnico";

declare function xf:consultaCuentaClienteUnicoHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>
        	{
        		if($outputParameters/ns0:RowSet/ns0:Row/ns0:Column[@name="pv_code_error"]) then (
            		fn:string($outputParameters/ns0:RowSet/ns0:Row/ns0:Column[@name="pv_code_error"])         		
            	) else (
            		"Success" 
            	)
            }
            </successIndicator>
            <messages>{ data($outputParameters/ns0:RowSet/ns0:Row/ns0:Column[@name="pv_error_description"]) }</messages>
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaCuentaClienteUnicoHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>