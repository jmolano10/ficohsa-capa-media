(:: pragma bea:global-element-parameter parameter="$ingresaVentaSeguros" element="ns2:ingresaVentaSeguros" location="../xsd/ingresaVentaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consumoNORResponse" element="ns1:ConsumoNORResponse" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ReservarNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/reversaConsumoHNIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:reversaConsumoHNIn($ingresaVentaSeguros as element(ns2:ingresaVentaSeguros),
    $requestHeader as element(ns0:RequestHeader),
    $consumoNORResponse as element(ns1:ConsumoNORResponse),
    $descripcion as xs:string,
    $secuencia as xs:string)
    as element(ns1:ReservarNOR) {
        <ns1:ReservarNOR>
            <ns1:noTarjetaCredito>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_PRODUCT_NUMBER) }</ns1:noTarjetaCredito>
            <ns1:montoConsumo>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_AMOUNT) }</ns1:montoConsumo>
            <ns1:monedaConsumo>
                {
                    let $PAYMENT_CURRENCY  := (data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_CURRENCY))  
                    return
                        if ($PAYMENT_CURRENCY = "HNL") then
                            (340)
                        else 
                            if ($PAYMENT_CURRENCY = "USD") then
                                (840)
                            else 
                                0
                }
			</ns1:monedaConsumo>
            <ns1:descripcionConsumo>{ $descripcion }</ns1:descripcionConsumo>
            <ns1:canalConsumo>
                {
                    fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
			</ns1:canalConsumo>
            <ns1:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $secuencia }</ns1:idRefConsumo>
            {
                for $EXPIRATION_DATE in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            {
                for $mensajeConfirmacion in $consumoNORResponse/ns1:ConsumoNORResult/ns1:mensajeConfirmacion
                return
                    <ns1:codigoConsumo>{ data($mensajeConfirmacion) }</ns1:codigoConsumo>
            }
        </ns1:ReservarNOR>
};

declare variable $ingresaVentaSeguros as element(ns2:ingresaVentaSeguros) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consumoNORResponse as element(ns1:ConsumoNORResponse) external;
declare variable $descripcion as xs:string external;
declare variable $secuencia as xs:string external;

xf:reversaConsumoHNIn($ingresaVentaSeguros,
    $requestHeader,
    $consumoNORResponse,
    $descripcion,
    $secuencia)