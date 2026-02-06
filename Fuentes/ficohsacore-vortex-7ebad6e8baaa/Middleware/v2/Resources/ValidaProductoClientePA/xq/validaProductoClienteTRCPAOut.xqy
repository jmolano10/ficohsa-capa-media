xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ConsultarTarjetasCredito_v2Response" element="ns1:ConsultarTarjetasCredito_v2Response" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClientePA/xq/validaProductoClienteTRCPAOut/";

declare function xf:validaProductoClienteTRCPAOut($productNumber as xs:string,
    $ConsultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response))
    as element(ns0:validaProductoClienteResponse) {
        <ns0:validaProductoClienteResponse>
            {
	            for $structTarjeta in $ConsultarTarjetasCredito_v2Response/ns1:ConsultarTarjetasCredito_v2Result/ns1:Tarjetas/ns1:StrucTarjetasConsulta_v2
                let $numTarjeta := fn:string($structTarjeta/ns1:noTarjetaCredito/text())
                return
	                if($productNumber = $numTarjeta) then(
		                <PRODUCT_NAME>{ fn:string($structTarjeta/ns1:nombreTarjetaHabiente/text()) }</PRODUCT_NAME>,
		                <CURRENCY>USD</CURRENCY>
		            )else()      
            }
        </ns0:validaProductoClienteResponse>
};

declare variable $productNumber as xs:string external;
declare variable $ConsultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response) external;

xf:validaProductoClienteTRCPAOut($productNumber,
    $ConsultarTarjetasCredito_v2Response)