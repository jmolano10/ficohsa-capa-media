(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/eliminarProveedores/xsd/eliminarProveedores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarProveedores";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresHNHeaderOut/";

declare function xf:eliminarProveedoresHNHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	let $successIndicator := $outputParameters/ns0:PV_CODIGOMENSAJE
            	let $message := $outputParameters/ns0:PV_DESCRIPCIONMENSAJE
            	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:eliminarProveedoresHNHeaderOut($outputParameters)