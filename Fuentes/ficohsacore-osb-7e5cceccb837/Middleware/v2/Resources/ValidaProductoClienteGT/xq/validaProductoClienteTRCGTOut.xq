(:: pragma bea:global-element-parameter parameter="$consultarTarjetasCredito_v2Response" element="ns1:ConsultarTarjetasCredito_v2Response" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteTRCGTOut/";

declare function xf:validaProductoClienteTRCGTOut($consultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response),
    $ProductNumber as xs:string)
    as element(ns0:validaProductoClienteResponse) {
	<ns0:validaProductoClienteResponse>
		{
		    for $noTarjetaCredito at $i in $consultarTarjetasCredito_v2Response/ns1:ConsultarTarjetasCredito_v2Result/ns1:Tarjetas/ns1:StrucTarjetasConsulta_v2/ns1:noTarjetaCredito
		    return
			    if ($ProductNumber = $noTarjetaCredito) then (
					<PRODUCT_NAME>{ data($consultarTarjetasCredito_v2Response/ns1:ConsultarTarjetasCredito_v2Result/ns1:Tarjetas/ns1:StrucTarjetasConsulta_v2[$i]/ns1:nombreTarjetaHabiente) }</PRODUCT_NAME>,
					<CURRENCY>GTQ</CURRENCY>
					
				) else ("")  
		}
	</ns0:validaProductoClienteResponse>
};

declare variable $consultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response) external;
declare variable $ProductNumber as xs:string external;

xf:validaProductoClienteTRCGTOut($consultarTarjetasCredito_v2Response,
    $ProductNumber)