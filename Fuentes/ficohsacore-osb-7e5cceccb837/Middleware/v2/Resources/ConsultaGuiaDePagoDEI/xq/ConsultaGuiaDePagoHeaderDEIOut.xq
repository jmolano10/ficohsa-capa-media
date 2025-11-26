(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaGuiaDePago/xsd/ConsultaGuiaDePago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGuiaDePago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGuiaDePago/xq/ConsultaGuiaDePagoHeaderOut/";

declare function xf:ConsultaGuiaDePagoHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            { 
                let $successIndicator := fn:string($outputParameters/ns1:PV_CODIGOMENSAJE/text())
            	let $message := fn:string($outputParameters/ns1:PV_DESCRIPCIONMENSAJE/text())
            	return 
            	
              	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else if( $successIndicator  = "ERROR") then(
	            		 <messageId>-1</messageId>,
	            		<successIndicator>ERROR</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) else(
	            	   <messageId>{ $successIndicator }</messageId>,
	            		<successIndicator>ERROR</successIndicator>,
	            		<messages>{ $message }</messages>
	            	)
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaGuiaDePagoHeaderOut($outputParameters)