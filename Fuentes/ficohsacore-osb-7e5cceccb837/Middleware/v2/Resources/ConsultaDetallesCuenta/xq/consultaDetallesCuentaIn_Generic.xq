(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetallesCuentaIn_Generic/";

declare function xf:consultaDetallesCuentaIn_Generic($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        <ns0:consultaDetallesCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
        </ns0:consultaDetallesCuenta>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetallesCuentaIn_Generic($accountNumber)
