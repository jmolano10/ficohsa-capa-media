xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/Cobis/ConsultaCliente/xsd/Consulta_Cliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Consulta_Cliente";

declare function xf:consultaClienteNIHeaderOut($outputParametersIN as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
       <ns1:ResponseHeader>
            {
            	let $successIndicator := fn:string($outputParametersIN/ns0:o_desc_error/text())
            	
            	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>ERROR</successIndicator>,
	            		<messages>{ $successIndicator }</messages>
	            	) 
            }
        </ns1:ResponseHeader>
};

declare variable $outputParametersIN as element(ns0:OutputParameters) external;

xf:consultaClienteNIHeaderOut($outputParametersIN)
