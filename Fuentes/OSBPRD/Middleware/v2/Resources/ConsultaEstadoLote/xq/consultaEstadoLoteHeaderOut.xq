xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultaEstadoLote/xsd/consultarEstadoLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteHeaderOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarEstadoLote";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:consultaEstadoLoteHeaderOut($outputParameters as element(ns1:OutputParameters))
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

xf:consultaEstadoLoteHeaderOut($outputParameters)