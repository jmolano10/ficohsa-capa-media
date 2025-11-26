(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest" element="ns1:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaClienteInfoSolicitud" location="../../../../v2/BusinessServices/CTS/cliente/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIIn/";

declare function xf:consultaClienteNIIn($consultaClienteRequest as element(ns1:consultaClienteRequest))
    as element(ns2:opConsultaClienteInfoSolicitud) {
        <ns2:opConsultaClienteInfoSolicitud>
            <ns0:cliente>
            	{
	            	if (fn:string(data($consultaClienteRequest/ns1:CUSTOMER_ID_TYPE)) = ("CODE","CUSTOMER_ID")) then (
	            		<ns0:codCliente>{ data($consultaClienteRequest/ns1:CUSTOMER_ID_VALUE) }</ns0:codCliente>
	            	) else (
	            		<ns0:tipoIdCliente>{ data($consultaClienteRequest/ns1:CUSTOMER_ID_TYPE) }</ns0:tipoIdCliente>,
                		<ns0:valIdCliente>{ data($consultaClienteRequest/ns1:CUSTOMER_ID_VALUE) }</ns0:valIdCliente>
	            	)
	            }                
            </ns0:cliente>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
        </ns2:opConsultaClienteInfoSolicitud>
};

declare variable $consultaClienteRequest as element(ns1:consultaClienteRequest) external;

xf:consultaClienteNIIn($consultaClienteRequest)