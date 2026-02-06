xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/ConsultaDetallesCuentaIn/";

declare function xf:ConsultaDetallesCuentaIn($ACCOUNT_NUMBER as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        <ns0:consultaDetallesCuenta>
            <ACCOUNT_NUMBER>{ $ACCOUNT_NUMBER }</ACCOUNT_NUMBER>
        </ns0:consultaDetallesCuenta>
};

declare variable $ACCOUNT_NUMBER as xs:string external;

xf:ConsultaDetallesCuentaIn($ACCOUNT_NUMBER)