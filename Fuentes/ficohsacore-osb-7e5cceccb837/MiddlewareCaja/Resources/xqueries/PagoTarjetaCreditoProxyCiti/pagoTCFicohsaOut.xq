(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../../../Middleware/Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultarSaldos1" element="ns1:ConsultarSaldos" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../xsds/General/obtenerSecuencia/obtenerSecuencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ecsResponse" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSecuencia";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoFicohsa/pagoTCFicohsaOut2/";

declare function xf:pagoTCFicohsaOut2($responseHeader1 as element(ns2:ResponseHeader),
    $outputParameters1 as element(ns0:OutputParameters),
    $cardHolderName as xs:string)
    as element(ns1:ecsResponse) {
        <ns1:ecsResponse>
            {
            	let $successIndicator := fn:string($responseHeader1/successIndicator/text())
            	return
            		if ($successIndicator = "Success") then (
	                    <ns1:out_referencia>{ fn:string($outputParameters1/ns0:PV_SECUENCIA/text()) }</ns1:out_referencia>,
	                    <ns1:out_autorizacion>{ fn:string($outputParameters1/ns0:PV_SECUENCIA/text()) }</ns1:out_autorizacion>,
    	                <ns1:out_nombre>{ $cardHolderName }</ns1:out_nombre>,
						<ns1:sError>00</ns1:sError>
					) else (
						<ns1:out_referencia>0</ns1:out_referencia>,
	                    <ns1:out_autorizacion>0</ns1:out_autorizacion>,
    	                <ns1:out_nombre/>,
						<ns1:sError>99</ns1:sError>
						
					)
            }            
        </ns1:ecsResponse>
};

declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $cardHolderName as xs:string external;

xf:pagoTCFicohsaOut2($responseHeader1,
    $outputParameters1,
    $cardHolderName)