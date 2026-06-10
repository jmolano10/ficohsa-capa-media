<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/VASA/obtenerUrlEstadosCuenta/xsd/ObtenerUrl_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaEstadoCuentaTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerUrl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/ObtenerUrlHNOUT/";

declare function xf:ObtenerUrlHNOUT($outputParameters as element(ns1:OutputParameters),
    $tipoArchivo as xs:string)
    as element(ns0:generaEstadoCuentaTCResponse) {
        <ns0:generaEstadoCuentaTCResponse>
            {
                for $P_NUMERO_CUENTA in $outputParameters/ns1:P_NUMERO_CUENTA
                return
                    <CARD_NUMBER>{ data($P_NUMERO_CUENTA) }</CARD_NUMBER>
            }
            {
                for $P_NUMERO_TARJETA in $outputParameters/ns1:P_NUMERO_TARJETA
                return
                    <ACCOUNT_NUMBER>{ data($P_NUMERO_TARJETA) }</ACCOUNT_NUMBER>
            }
            {
                for $P_MES in $outputParameters/ns1:P_MES
                return
                    <MONTH>{ data($P_MES) }</MONTH>
            }
            {
                for $P_ANIO in $outputParameters/ns1:P_ANIO
                return
                    <YEAR>{ data($P_ANIO) }</YEAR>
            }
            <FILE_EXTENSION>{ $tipoArchivo }</FILE_EXTENSION>
            {
                for $P_URL in $outputParameters/ns1:P_URL
                return
                    <FILE_LINK>{ data($P_URL) }</FILE_LINK>
            }
        </ns0:generaEstadoCuentaTCResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $tipoArchivo as xs:string external;

xf:ObtenerUrlHNOUT($outputParameters,
    $tipoArchivo)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VASA/obtenerUrlEstadosCuenta/xsd/ObtenerUrl_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VASA/obtenerUrlEstadosCuenta/xsd/ObtenerUrl_sp"/>
    </con:dependency>
    <con:dependency location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>