xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarTarjetasCredito_v2Response" element="ns1:ConsultarTarjetasCredito_v2Response" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaTarjetasCreditoPorClienteResponse" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaTarjetasCreditoPorClienteGTOut/";

declare function xf:consultaTarjetasCreditoPorClienteGTOut($consultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response))
    as element(ns0:consultaTarjetasCreditoPorClienteResponse) {
        <ns0:consultaTarjetasCreditoPorClienteResponse>
            <CREDIT_CARDS>
                {
                    for $StrucTarjetasConsulta_v2 in $consultarTarjetasCredito_v2Response/ns1:ConsultarTarjetasCredito_v2Result/ns1:Tarjetas/ns1:StrucTarjetasConsulta_v2
                    return
                        <CREDIT_CARD_INFORMATION>
                            {
                                for $noTarjetaCredito in $StrucTarjetasConsulta_v2/ns1:noTarjetaCredito
                                return
                                    <CREDIT_CARD_NUMBER>{ data($noTarjetaCredito) }</CREDIT_CARD_NUMBER>
                            }
                            {
                                for $numeroCuenta in $StrucTarjetasConsulta_v2/ns1:numeroCuenta
                                return
                                    <ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
                            }
                            {
                                for $nombreTarjetaHabiente in $StrucTarjetasConsulta_v2/ns1:nombreTarjetaHabiente
                                return
                                    <CARD_HOLDER_NAME>{ data($nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                            }
                            {
                                for $categoriaTarjeta in $StrucTarjetasConsulta_v2/ns1:categoriaTarjeta
                                return
                                    <CARD_TYPE>{ data($categoriaTarjeta) }</CARD_TYPE>
                            }
                            {
                                for $estatusTarjeta in $StrucTarjetasConsulta_v2/ns1:estatusTarjeta
                                return
                                    <STATUS>{ data($estatusTarjeta) }</STATUS>
                            }
                            {
                                for $producto in $StrucTarjetasConsulta_v2/ns1:producto
                                return
                                    <PRODUCT_TYPE>{ data($producto) }</PRODUCT_TYPE>
                            }
                            {
                                for $grupoAfinidad in $StrucTarjetasConsulta_v2/ns1:grupoAfinidad
                                return
                                    <AFINITY_GROUP>{ data($grupoAfinidad) }</AFINITY_GROUP>
                            }
                        </CREDIT_CARD_INFORMATION>
                }
            </CREDIT_CARDS>
        </ns0:consultaTarjetasCreditoPorClienteResponse>
};

declare variable $consultarTarjetasCredito_v2Response as element(ns1:ConsultarTarjetasCredito_v2Response) external;

xf:consultaTarjetasCreditoPorClienteGTOut($consultarTarjetasCredito_v2Response)