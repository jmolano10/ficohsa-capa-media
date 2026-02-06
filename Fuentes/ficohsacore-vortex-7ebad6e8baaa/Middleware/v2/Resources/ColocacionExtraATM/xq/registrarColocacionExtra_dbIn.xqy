xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$colocacionExtraATMRequest1" element="ns1:colocacionExtraATMRequest" location="../xsd/colocacionExtraATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ATM/RegistrarColocacion/Extra/xsd/registrarColocacionExtra_db_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarColocacionExtra_db";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/colocacionExtraATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ColocacionExtraATM/xq/registrarColocacionExtra_dbIn/";

declare function xf:registrarColocacionExtra_dbIn($colocacionExtraATMRequest1 as element(ns1:colocacionExtraATMRequest),
    $CustomerLegalId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_DNI>{ fn-bea:trim($CustomerLegalId) }</ns0:PV_DNI>
            <ns0:PV_ID_ATM>{ fn:data($colocacionExtraATMRequest1/ATM_ID) }</ns0:PV_ID_ATM>
            <ns0:PV_ID_TRACE>{ fn:data($colocacionExtraATMRequest1/TRACE_ID) }</ns0:PV_ID_TRACE>
            <ns0:PV_NOMBRE_ATM>{ fn:data($colocacionExtraATMRequest1/ATM_NAME) }</ns0:PV_NOMBRE_ATM>
        </ns0:InputParameters>
};

declare variable $colocacionExtraATMRequest1 as element(ns1:colocacionExtraATMRequest) external;
declare variable $CustomerLegalId as xs:string external;

xf:registrarColocacionExtra_dbIn($colocacionExtraATMRequest1,
    $CustomerLegalId)