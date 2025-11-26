(:: pragma bea:global-element-parameter parameter="$validaURLCliente" element="ns1:validaURLCliente" location="../../ValidaURLCliente/xsd/validaURLClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/validaCliente/xsd/validaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaURLClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaURLClienteRG/xq/validaClienteIn/";

declare function xf:validaClienteIn($validaURLCliente as element(ns1:validaURLCliente))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_DOCUMENT_TYPE>{ data($validaURLCliente/DOCUMENT_TYPE) }</ns0:PV_DOCUMENT_TYPE>
            <ns0:PV_DOCUMENT_NUMBER>{ data($validaURLCliente/DOCUMENT_NUMBER) }</ns0:PV_DOCUMENT_NUMBER>
            <ns0:PV_HASH_LINK>{ data($validaURLCliente/URL_ID) }</ns0:PV_HASH_LINK>
        </ns0:InputParameters>
};

declare variable $validaURLCliente as element(ns1:validaURLCliente) external;

xf:validaClienteIn($validaURLCliente)
