xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inhabilitacionCuentaRequest1" element="ns0:inhabilitacionCuentaRequest" location="../xsd/inhabilitacionCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/ABKGT/InhabilitacionCuenta/xsd/InhabilitacionGT_sp.xsd" ::)


declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inhabilitacionCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/InhabilitacionGT";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/AbanksGT/InhabilitacionCuenta/xq/InhabilitacionCuentaIn/";

declare function xf:InhabilitacionCuentaIn($inhabilitacionCuentaRequest1 as element(ns0:inhabilitacionCuentaRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTA>{ data($inhabilitacionCuentaRequest1/ns0:ACCOUNT) }</ns1:PV_CUENTA>
        </ns1:InputParameters>
};

declare variable $inhabilitacionCuentaRequest1 as element(ns0:inhabilitacionCuentaRequest) external;

xf:InhabilitacionCuentaIn($inhabilitacionCuentaRequest1)