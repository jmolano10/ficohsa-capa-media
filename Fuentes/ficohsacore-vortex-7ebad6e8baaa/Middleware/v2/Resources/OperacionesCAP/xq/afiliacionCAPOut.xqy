xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/AfiliacionCAP/xsd/afiliacionCAP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:afiliacionCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/afiliacionCAP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/afiliacionCAPOut/";

declare function xf:afiliacionCAPOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:afiliacionCAPResponse) {
        <ns0:afiliacionCAPResponse>
            {
                for $PN_ID_CAP in $outputParameters/ns1:PN_ID_CAP
                return
                    <ID_CAP>{ data($PN_ID_CAP) }</ID_CAP>
            }
        </ns0:afiliacionCAPResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:afiliacionCAPOut($outputParameters)