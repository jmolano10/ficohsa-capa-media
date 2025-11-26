xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRemittanceFields";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittanceFields/GetRemittanceFields_sp.xsd" ::)

declare variable $remitterId as xs:string external;

declare function local:func($remitterId as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_IDCONVENIOT24>{fn:data($remitterId)}</ns1:PV_IDCONVENIOT24>
    </ns1:InputParameters>
};

local:func($remitterId)
