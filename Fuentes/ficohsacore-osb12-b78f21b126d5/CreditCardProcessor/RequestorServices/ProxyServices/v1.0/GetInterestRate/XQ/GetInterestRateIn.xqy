xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetInterestRate";
(:: import schema at "../../../../../ProviderServices/XSD/GetInterestRate/GetInterestRate_sp.xsd" ::)

declare variable $Org as xs:string external;
declare variable $Logo as xs:string external;
declare variable $Pct as xs:string external;
declare variable $Country as xs:string external;

declare function local:func($Org as xs:string, 
                            $Logo as xs:string, 
                            $Pct as xs:string,
                            $Country as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:Pais>{fn:data($Country)}</ns1:Pais>
        <ns1:Org>{fn:data($Org)}</ns1:Org>
        <ns1:Logo>{fn:data($Logo)}</ns1:Logo>
        <ns1:PCT>{fn:data($Pct)}</ns1:PCT>
    </ns1:InputParameters>
};

local:func($Org, $Logo, $Pct, $Country)