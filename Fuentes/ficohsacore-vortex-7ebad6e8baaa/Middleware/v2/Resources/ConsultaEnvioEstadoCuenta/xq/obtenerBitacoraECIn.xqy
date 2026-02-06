xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEnvioEstadoCuenta" element="ns0:consultaEnvioEstadoCuenta" location="../xsd/consultaEnvioEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterData/obtenerBitacoraEC/xsd/obtenerBitacoraEC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBitacoraEC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEnvioEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEnvioEstadoCuenta/xq/obtenerBitacoraECIn/";

declare function xf:obtenerBitacoraECIn($consultaEnvioEstadoCuenta as element(ns0:consultaEnvioEstadoCuenta),$codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	
            <ns1:Identificador>{ fn-bea:pad-left(data($consultaEnvioEstadoCuenta/ACCOUNT_IDENTIFIER), 19, '0') }</ns1:Identificador>
            <ns1:Pais>{ $codigoPais }</ns1:Pais>
            <ns1:fechaInicio>{ data($consultaEnvioEstadoCuenta/START_DATE) }</ns1:fechaInicio>
            <ns1:fechaFin>{ data($consultaEnvioEstadoCuenta/END_DATE) }</ns1:fechaFin>
            
        </ns1:InputParameters>
};

declare variable $consultaEnvioEstadoCuenta as element(ns0:consultaEnvioEstadoCuenta) external;
declare variable $codigoPais as xs:string external;

xf:obtenerBitacoraECIn($consultaEnvioEstadoCuenta,$codigoPais)