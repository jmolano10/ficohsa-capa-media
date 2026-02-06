xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_PORC_LEVENSTEIN";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuentaACH/xq/ConsultaPorcentLevensteinIn/";

declare function xf:ConsultaPorcentLevensteinIn($requestHeader1 as element(ns1:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:VA_USUARIO>{ data($requestHeader1/Authentication/UserName) }</ns0:VA_USUARIO>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;

xf:ConsultaPorcentLevensteinIn($requestHeader1)