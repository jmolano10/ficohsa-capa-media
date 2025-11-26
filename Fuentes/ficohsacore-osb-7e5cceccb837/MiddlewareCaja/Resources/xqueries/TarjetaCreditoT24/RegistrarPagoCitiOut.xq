(:: pragma  parameter="$responseParameters" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:registrarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/test2/";

declare function xf:test2($responseParameters as element(*))
    as element(ns0:registrarPagoResponse) {
        <ns0:registrarPagoResponse>
            {            
	            for $ITEM at $i in $responseParameters
				return	            
	            <ns0:registrarPagoResult>            	            					                
	                	<ns0:estatusConfirmacion>{ data($ITEM/errorCode) }</ns0:estatusConfirmacion>                	                					
	                	<ns0:mensajeConfirmacion>{ data($ITEM/errorMessage) }</ns0:mensajeConfirmacion>                	                                        
	            </ns0:registrarPagoResult>
            }
        </ns0:registrarPagoResponse>
};

declare variable $responseParameters as element(*) external;

xf:test2($responseParameters)