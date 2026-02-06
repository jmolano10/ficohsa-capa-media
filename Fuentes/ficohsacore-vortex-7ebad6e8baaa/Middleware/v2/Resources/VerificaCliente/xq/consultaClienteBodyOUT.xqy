xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaClienteResponse1" element="ns1:consultaClienteResponse" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:verificaClienteResponse" location="../xsd/verificaClientesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaCliente/xq/consultaClienteHeaderOUT/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/verificaClientesTypes";

declare function xf:consultaClienteHeaderOUT($consultaClienteResponse1 as element(ns1:consultaClienteResponse))
    as element(ns0:verificaClienteResponse) {
        <ns0:verificaClienteResponse/>
};

declare variable $consultaClienteResponse1 as element(ns1:consultaClienteResponse) external;

xf:consultaClienteHeaderOUT($consultaClienteResponse1)