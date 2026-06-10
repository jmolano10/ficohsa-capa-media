<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$accountAddResponse" element="ns1:AccountAddResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creacionCuentaFinanciamientoResponse" location="../xsd/creacionCuentaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creacionCuentaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionCuentaFinanciamiento/xq/creacionCuentaFinanciamientoOut/";

declare function xf:creacionCuentaFinanciamientoOut($accountAddResponse as element(ns1:AccountAddResponse))
    as element(ns0:creacionCuentaFinanciamientoResponse) {
        &lt;ns0:creacionCuentaFinanciamientoResponse>
            &lt;ACCOUNT_NUMBER>{ data($accountAddResponse/ARXAAO-ACCOUNT-NBR) }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:creacionCuentaFinanciamientoResponse>
};

declare variable $accountAddResponse as element(ns1:AccountAddResponse) external;

xf:creacionCuentaFinanciamientoOut($accountAddResponse)</con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
    <con:dependency location="../xsd/creacionCuentaFinanciamientoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CreacionCuentaFinanciamiento/xsd/creacionCuentaFinanciamientoTypes"/>
    </con:dependency>
</con:xqueryEntry>