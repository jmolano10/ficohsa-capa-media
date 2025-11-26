(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/consultaDetalleCuentaIn/";

declare function xf:consultaDetalleCuentaIn($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        <ns0:consultaDetallesCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
        </ns0:consultaDetallesCuenta>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetalleCuentaIn($accountNumber)
