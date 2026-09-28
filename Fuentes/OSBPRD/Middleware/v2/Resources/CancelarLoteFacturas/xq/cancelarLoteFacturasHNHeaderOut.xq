(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/cancelarLoteFacturas/xsd/cancelarLoteFacturas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelarLoteFacturas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLoteFacturas/xq/cancelarLoteFacturasHeaderOut/";

declare function xf:cancelarLoteFacturasHeaderOut($outputParameters as element(ns1:OutputParameters))
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

xf:cancelarLoteFacturasHeaderOut($outputParameters)