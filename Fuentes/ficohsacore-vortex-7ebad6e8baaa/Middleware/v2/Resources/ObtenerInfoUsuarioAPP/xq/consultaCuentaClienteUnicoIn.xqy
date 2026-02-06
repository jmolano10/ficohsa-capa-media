xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerInfoUsuarioAPP" element="ns1:obtenerInfoUsuarioAPP" location="../xsd/obtenerInfoUsuarioAPPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerInfoUsuarioAPPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaClienteUnico";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerInfoUsuarioAPP/xq/consultaCuentaClienteUnicoIn/";

declare function xf:consultaCuentaClienteUnicoIn($obtenerInfoUsuarioAPP as element(ns1:obtenerInfoUsuarioAPP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CodigoCliente>{ data($obtenerInfoUsuarioAPP/PROFILE) }</ns0:CodigoCliente>
        </ns0:InputParameters>
};

declare variable $obtenerInfoUsuarioAPP as element(ns1:obtenerInfoUsuarioAPP) external;

xf:consultaCuentaClienteUnicoIn($obtenerInfoUsuarioAPP)