xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuentaMasivos" location="../../../../Resources/ConsultaDetallesCuentaMasivos/xsd/consultaDetallesCuentaMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetallesCuentaMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetallesCuentaMasivosIn/";

declare function xf:consultaDetallesCuentaMasivosIn($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuentaMasivos) {
        <ns0:consultaDetallesCuentaMasivos>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
        </ns0:consultaDetallesCuentaMasivos>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetallesCuentaMasivosIn($accountNumber)