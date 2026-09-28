(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns2:consultaPasivosClienteRequest" location="../xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaPasivosClienteSolicitud" location="../../../BusinessServices/CTS/pasivos/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://service.srvaplcobispasivos.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteNIIn/";

declare function xf:consultaPasivosClienteNIIn($consultaPasivosClienteRequest1 as element(ns2:consultaPasivosClienteRequest),
	$validIdCliente as xs:string)
	
    as element(ns1:opConsultaPasivosClienteSolicitud) {
        <ns1:opConsultaPasivosClienteSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cliente>
                <ns0:codCliente>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns0:codCliente>
                <ns0:valIdCliente>{ $validIdCliente }</ns0:valIdCliente>
            </ns0:cliente>
            <ns0:producto>
                <ns0:codTipoProducto>
                { 
                	let $tipoProducto := data($consultaPasivosClienteRequest1/LIABILITY_TYPE)
                	return
                		if($tipoProducto = 'PTC') then(
                			'TRC'
                		) else (
                			$tipoProducto
                		)                 
                }
                </ns0:codTipoProducto>
            </ns0:producto>
        </ns1:opConsultaPasivosClienteSolicitud>
};

declare variable $consultaPasivosClienteRequest1 as element(ns2:consultaPasivosClienteRequest) external;
declare variable $validIdCliente as xs:string external;

xf:consultaPasivosClienteNIIn($consultaPasivosClienteRequest1, $validIdCliente)