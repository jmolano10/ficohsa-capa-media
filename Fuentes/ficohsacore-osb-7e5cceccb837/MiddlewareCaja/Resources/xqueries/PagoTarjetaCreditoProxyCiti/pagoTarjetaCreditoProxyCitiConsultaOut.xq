(:: pragma bea:global-element-parameter parameter="$operacionesTCDesdeOccidenteResponse" element="ns0:operacionesTCDesdeOccidenteResponse" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1247111820.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1500216410.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consulta_cuenta_ECSResponse" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTCDesdeOccidenteTypes";
declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/pagoTarjetaCreditoProxyCitiConsultaOut/";

declare function xf:pagoTarjetaCreditoProxyCitiConsultaOut($operacionesTCDesdeOccidenteResponse as element(ns0:operacionesTCDesdeOccidenteResponse),
    $responseHeader as element(ns1:ResponseHeader))
    as element(ns2:consulta_cuenta_ECSResponse) {
        <ns2:consulta_cuenta_ECSResponse>
            
            {            	
            	if (upper-case($responseHeader/successIndicator) = "SUCCESS") then(
            	
            		for $CARD_HOLDER_NAME in $operacionesTCDesdeOccidenteResponse/CARD_HOLDER_NAME
                return
                    <ns2:nombre>{ data($CARD_HOLDER_NAME) }</ns2:nombre>,
            	 	<ns2:sError>00</ns2:sError>
            	 	
           		)else(
           				<ns2:nombre></ns2:nombre>,
            	 		<ns2:sError>99</ns2:sError>
            	)
            } 
            
        </ns2:consulta_cuenta_ECSResponse>
};

declare variable $operacionesTCDesdeOccidenteResponse as element(ns0:operacionesTCDesdeOccidenteResponse) external;
declare variable $responseHeader as element(ns1:ResponseHeader) external;

xf:pagoTarjetaCreditoProxyCitiConsultaOut($operacionesTCDesdeOccidenteResponse,
    $responseHeader)