xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns0:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaSwiftFinanciera/xsd/consultaSwiftFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSwiftFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/consultaCodSwiftIn/";

declare function xf:consultaCodSwiftIn($validacionCuentaExterna as element(ns0:validacionCuentaExterna))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGO_FINANCIERA>{ data($validacionCuentaExterna/BANK_DETAILS/BANK/BANK_CODE) }</ns1:PN_CODIGO_FINANCIERA>
        </ns1:InputParameters>
};

declare variable $validacionCuentaExterna as element(ns0:validacionCuentaExterna) external;

xf:consultaCodSwiftIn($validacionCuentaExterna)