xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRemittancesFields";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesFields/GetRemittancesFields_sp.xsd" ::)

declare variable $Contract as xs:decimal external;

declare function local:func($Contract as xs:decimal) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PN_ID_CONVENIO>{fn:data($Contract)}</ns1:PN_ID_CONVENIO>
    </ns1:InputParameters>
};

local:func($Contract)
