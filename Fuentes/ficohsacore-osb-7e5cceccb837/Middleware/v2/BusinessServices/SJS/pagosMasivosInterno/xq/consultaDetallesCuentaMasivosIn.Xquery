<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>(:: pragma bea:global-element-return element="ns0:consultaDetallesCuentaMasivos" location="../../../../Resources/ConsultaDetallesCuentaMasivos/xsd/consultaDetallesCuentaMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetallesCuentaMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetallesCuentaMasivosIn/";

declare function xf:consultaDetallesCuentaMasivosIn($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuentaMasivos) {
        &lt;ns0:consultaDetallesCuentaMasivos>
            &lt;ACCOUNT_NUMBER>{ $accountNumber }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaDetallesCuentaMasivos>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetallesCuentaMasivosIn($accountNumber)</con:xquery>
    <con:dependency location="../../../../Resources/ConsultaDetallesCuentaMasivos/xsd/consultaDetallesCuentaMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuentaMasivos/xsd/consultaDetallesCuentaMasivosTypes"/>
    </con:dependency>
</con:xqueryEntry>