xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEnvioEstadoCuenta1" element="ns1:consultaEnvioEstadoCuenta" location="../xsd/consultaEnvioEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Strongview/obtenerbfemBitacoraEC/xsd/obtenerbfemBitacoraEC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEnvioEstadoCuentaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerbfemBitacoraEC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEnvioEstadoCuenta/xq/obtenerbfemBitacoraECIn/";

declare function xf:obtenerbfemBitacoraECIn($countryCode as xs:string,
    $consultaEnvioEstadoCuenta1 as element(ns1:consultaEnvioEstadoCuenta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Identificador>{ data($consultaEnvioEstadoCuenta1/ACCOUNT_IDENTIFIER) }</ns0:Identificador>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            <ns0:fechaInicio>{ data($consultaEnvioEstadoCuenta1/START_DATE) }</ns0:fechaInicio>
            <ns0:fechaFin>{ data($consultaEnvioEstadoCuenta1/END_DATE) }</ns0:fechaFin>
        </ns0:InputParameters>
};

declare variable $countryCode as xs:string external;
declare variable $consultaEnvioEstadoCuenta1 as element(ns1:consultaEnvioEstadoCuenta) external;

xf:obtenerbfemBitacoraECIn($countryCode,
    $consultaEnvioEstadoCuenta1)