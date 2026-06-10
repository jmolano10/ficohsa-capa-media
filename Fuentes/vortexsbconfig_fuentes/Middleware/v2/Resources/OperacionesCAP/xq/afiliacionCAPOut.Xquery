<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/AfiliacionCAP/xsd/afiliacionCAP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:afiliacionCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/afiliacionCAP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/afiliacionCAPOut/";

declare function xf:afiliacionCAPOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:afiliacionCAPResponse) {
        &lt;ns0:afiliacionCAPResponse>
            {
                for $PN_ID_CAP in $outputParameters/ns1:PN_ID_CAP
                return
                    &lt;ID_CAP>{ data($PN_ID_CAP) }&lt;/ID_CAP>
            }
        &lt;/ns0:afiliacionCAPResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:afiliacionCAPOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/AfiliacionCAP/xsd/afiliacionCAP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/AfiliacionCAP/xsd/afiliacionCAP_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
</con:xqueryEntry>