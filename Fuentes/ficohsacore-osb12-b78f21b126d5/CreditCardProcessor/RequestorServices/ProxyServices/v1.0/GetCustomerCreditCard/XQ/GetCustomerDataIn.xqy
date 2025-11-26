xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerData";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerData_sp.xsd" ::)

declare variable $searchCriteria as xs:string external;
declare variable $searchValue as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;

declare function local:func($searchCriteria as xs:string, 
                            $searchValue as xs:string, 
                            $org as xs:string, 
                            $codigoPais as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
            <ns1:Pais>{ data($codigoPais) }</ns1:Pais>
            {
            	if($org != "")then(
            		<ns1:Org>{ $org }</ns1:Org>
            	)else()
            }
            <ns1:Numero>{ fn-bea:pad-left($searchValue, 19, '0') }</ns1:Numero>
            <ns1:Tipo>{ $searchCriteria }</ns1:Tipo>
        </ns1:InputParameters>
};

local:func($searchCriteria, $searchValue, $org, $codigoPais)