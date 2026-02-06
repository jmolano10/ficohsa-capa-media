xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-parameter parameter="$generarHash" element="ns1:generarHash" location="../xsd/operacionesCriptograficasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generateHashRequest" location="../../../BusinessServices/operacionesCriptograficas/wsdl/cryptographicOperations.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/cryptographicOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/generateHashIn/";

declare function xf:generateHashIn($generarHash as element(ns1:generarHash))
    as element(ns0:generateHashRequest) {
        <ns0:generateHashRequest>
            <algorithm>{ data($generarHash/ns1:ALGORITHM) }</algorithm>
            <plainData>{ data($generarHash/ns1:PLAIN_DATA) }</plainData>
        </ns0:generateHashRequest>
};

declare variable $generarHash as element(ns1:generarHash) external;

xf:generateHashIn($generarHash)