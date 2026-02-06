xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/consultarNroContrato/xsd/ConsultaNroContrato_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaNroContrato";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultarNroContrato/xq/ConsultaNroContratoHeaderOut/";

declare function xf:ConsultaNroContratoHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
                {
                  let $successIndicator := fn:string($outputParameters1/ns0:PV_CODIGOMENSAJE)
            	  let $message := fn:string($outputParameters1/ns0:PV_DESCRIPCIONMENSAJE)
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

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaNroContratoHeaderOut($outputParameters1)