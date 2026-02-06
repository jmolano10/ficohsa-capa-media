xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../BusinessServices/ABKGT/InhabilitacionCuenta/xsd/InhabilitacionGT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:inhabilitacionCuentaResponse" location="../xsd/inhabilitacionCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inhabilitacionCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/InhabilitacionGT";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/AbanksGT/InhabilitacionCuenta/xq/prueba3/";

declare function xf:inhabilitacionCuentaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:inhabilitacionCuentaResponse) {
        <ns0:inhabilitacionCuentaResponse>
            <ns0:responseCode>{ data($outputParameters1/ns1:PV_RESPUESTA) }</ns0:responseCode>
            <ns0:responseDescription>{ data($outputParameters1/ns1:PV_ERROR) }</ns0:responseDescription>
        </ns0:inhabilitacionCuentaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:inhabilitacionCuentaOut($outputParameters1)