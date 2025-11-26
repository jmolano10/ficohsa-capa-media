(:: pragma bea:global-element-parameter parameter="$operacionesTCDesdeOccidenteResponse" element="ns0:operacionesTCDesdeOccidenteResponse" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1247111820.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1500216410.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ecsResponse" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTCDesdeOccidenteTypes";
declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/pagoTarjetaCreditoProxyCitiEcsOut/";

declare function xf:pagoTarjetaCreditoProxyCitiEcsOut($operacionesTCDesdeOccidenteResponse as element(ns0:operacionesTCDesdeOccidenteResponse),
    $responseHeader as element(ns1:ResponseHeader))
    as element(ns2:ecsResponse) {
        <ns2:ecsResponse>
            
            {            	
            	if (upper-case($responseHeader/successIndicator) = "SUCCESS") then(
            		
            		<ns2:out_referencia>{ data($responseHeader/transactionId) }</ns2:out_referencia>,
         
                	for $transactionId in $responseHeader/transactionId
                	return
                    	<ns2:out_autorizacion>{ data($transactionId) }</ns2:out_autorizacion>,
            
            
                	for $CARD_HOLDER_NAME in $operacionesTCDesdeOccidenteResponse/CARD_HOLDER_NAME
                	return
                    	<ns2:out_nombre>{ data($CARD_HOLDER_NAME) }</ns2:out_nombre>,
            
            	 		<ns2:sError>00</ns2:sError>
           		)else(
           				<ns2:out_referencia></ns2:out_referencia>,
           				<ns2:out_autorizacion></ns2:out_autorizacion>,
           				<ns2:out_nombre></ns2:out_nombre>,
            	 		<ns2:sError>99</ns2:sError>
            	)
            }        
        </ns2:ecsResponse>
};

declare variable $operacionesTCDesdeOccidenteResponse as element(ns0:operacionesTCDesdeOccidenteResponse) external;
declare variable $responseHeader as element(ns1:ResponseHeader) external;

xf:pagoTarjetaCreditoProxyCitiEcsOut($operacionesTCDesdeOccidenteResponse,
    $responseHeader)