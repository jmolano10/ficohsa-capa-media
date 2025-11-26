(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaDebitoResponse" location="../xsd/ConsultaDatosTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDatosTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoNIOUT/";

declare function xf:ConsultaDatosTarjetaDebitoNIOUT($CodigoCliente as xs:string,
    $NombreTarjeta as xs:string,
    $TipoTarjeta as xs:string,
    $EstadoTarjeta as xs:string,
    $Cuenta as xs:string,
    $MonedaCuenta as xs:string,
    $cuentaSecundaria as xs:string,
    $codigoMonedaSecundaria as xs:string)
    as element(ns0:consultaDatosTarjetaDebitoResponse) {
        <ns0:consultaDatosTarjetaDebitoResponse>
            <CUSTOMER_ID>{ $CodigoCliente }</CUSTOMER_ID>
            <CARD_NAME>{ $NombreTarjeta }</CARD_NAME>
            <CATEGORY_CARD>{ $TipoTarjeta }</CATEGORY_CARD>
            <STATUS_CARD>{ $EstadoTarjeta }</STATUS_CARD>
            <ACCOUNTS>
                <MAIN_ACCOUNTS>
                   {
                   if (fn:data($Cuenta) != '') then
                    <MAIN_ACCOUNT>
                        <ACCOUNT>{ $Cuenta }</ACCOUNT>
                        <ACCOUNT_CURRENCY>{ $MonedaCuenta }</ACCOUNT_CURRENCY>
                    </MAIN_ACCOUNT>
                    else()
                    }
                </MAIN_ACCOUNTS>
                <SECUNDARY_ACCOUNTS>
                    {
                    if (fn:data($cuentaSecundaria)  !=  '') then
                    <SECUNDARY_ACCOUNT>
                        <ACCOUNT>{ $cuentaSecundaria }</ACCOUNT>
                        <ACCOUNT_CURRENCY>{ $codigoMonedaSecundaria }</ACCOUNT_CURRENCY>
                    </SECUNDARY_ACCOUNT>
                    else()
                    }
                </SECUNDARY_ACCOUNTS>
            </ACCOUNTS>
        </ns0:consultaDatosTarjetaDebitoResponse>
};

declare variable $CodigoCliente as xs:string external;
declare variable $NombreTarjeta as xs:string external;
declare variable $TipoTarjeta as xs:string external;
declare variable $EstadoTarjeta as xs:string external;
declare variable $Cuenta as xs:string external;
declare variable $MonedaCuenta as xs:string external;
declare variable $cuentaSecundaria as xs:string external;
declare variable $codigoMonedaSecundaria as xs:string external;

xf:ConsultaDatosTarjetaDebitoNIOUT($CodigoCliente,
    $NombreTarjeta,
    $TipoTarjeta,
    $EstadoTarjeta,
    $Cuenta,
    $MonedaCuenta,
    $cuentaSecundaria,
    $codigoMonedaSecundaria)
