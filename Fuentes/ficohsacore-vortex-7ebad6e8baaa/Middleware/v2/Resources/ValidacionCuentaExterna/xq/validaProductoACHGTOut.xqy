xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns1:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaQueriesResponse" element="ns0:ValidaQueriesResponse" location="../../../BusinessServices/ACH/ValidaProductoACH/EnviadoGT/xsd/_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaExternaResponse" location="../xsd/validacionCuentaExternaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidaQueriesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/validaProductoACHGTOut/";

declare function xf:validaProductoACHGTOut($validacionCuentaExterna as element(ns1:validacionCuentaExterna),
    $validaQueriesResponse as element(ns0:ValidaQueriesResponse))
    as element(ns1:validacionCuentaExternaResponse) {
        <ns1:validacionCuentaExternaResponse>
            <ACCOUNT_NUMBER>{ data($validacionCuentaExterna/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ data($validaQueriesResponse/Payload/Name) }</ACCOUNT_NAME>
            <CURRENCY>{ data($validacionCuentaExterna/ACCOUNT_CURRENCY) }</CURRENCY>
            <ACCOUNT_STATUS>ACTIVE</ACCOUNT_STATUS>
            <PRODUCT_TYPE>{ data($validacionCuentaExterna/PRODUCT_TYPE) }</PRODUCT_TYPE>
            <KV_PAIRS>
                <PAIR>
                    <KEY>{ data($validacionCuentaExterna/BANK_DETAILS/BANK[1]/CODE_TYPE) }</KEY>
                    <VALUE>{ data($validacionCuentaExterna/BANK_DETAILS/BANK[1]/BANK_CODE) }</VALUE>
                </PAIR>
            </KV_PAIRS>
        </ns1:validacionCuentaExternaResponse>
};

declare variable $validacionCuentaExterna as element(ns1:validacionCuentaExterna) external;
declare variable $validaQueriesResponse as element(ns0:ValidaQueriesResponse) external;

xf:validaProductoACHGTOut($validacionCuentaExterna,
    $validaQueriesResponse)