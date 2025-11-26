xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetValidSubApplication";
(:: import schema at "../../../../ProviderServices/XSD/GetValidSubApplication/GetValidSubApplication_sp.xsd" ::)

declare variable $SubApplication as xs:string external;

declare function local:func($SubApplication as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:VA_SUBAPLICACION>{fn:data($SubApplication)}</ns1:VA_SUBAPLICACION>
    </ns1:InputParameters>
};

local:func($SubApplication)