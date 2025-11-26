xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesLocalId";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesLocalId/getRemittancesLocalId_sp.xsd" ::)

declare variable $remittanceId as xs:string external;

declare function local:func($remittanceId as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_REMESA>{fn:data($remittanceId)}</ns1:PV_REMESA>
    </ns1:InputParameters>
};

local:func($remittanceId)
