xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$accountAddResponse" element="ns1:AccountAddResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creacionCuentaFinanciamientoResponse" location="../xsd/creacionCuentaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creacionCuentaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionCuentaFinanciamiento/xq/creacionCuentaFinanciamientoOut/";

declare function xf:creacionCuentaFinanciamientoOut($accountAddResponse as element(ns1:AccountAddResponse))
    as element(ns0:creacionCuentaFinanciamientoResponse) {
        <ns0:creacionCuentaFinanciamientoResponse>
            <ACCOUNT_NUMBER>{ data($accountAddResponse/ARXAAO-ACCOUNT-NBR) }</ACCOUNT_NUMBER>
        </ns0:creacionCuentaFinanciamientoResponse>
};

declare variable $accountAddResponse as element(ns1:AccountAddResponse) external;

xf:creacionCuentaFinanciamientoOut($accountAddResponse)