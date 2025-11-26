(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/valoresDeGuiaPago/xsd/valoresDeGuiaPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/valoresDeGuiaPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValoresDeGuiaPagoDEI/xq/valoresDeGuiaPagoDEIHeaderOut/";

declare function xf:valoresDeGuiaPagoDEIHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>          
            {
            	
	            let $successIndicator := fn:string($outputParameters/ns0:PV_CODIGOMENSAJE/text())
            	let $message := fn:string($outputParameters/ns0:PV_DESCRIPCIONMENSAJE/text())
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
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:valoresDeGuiaPagoDEIHeaderOut($outputParameters)