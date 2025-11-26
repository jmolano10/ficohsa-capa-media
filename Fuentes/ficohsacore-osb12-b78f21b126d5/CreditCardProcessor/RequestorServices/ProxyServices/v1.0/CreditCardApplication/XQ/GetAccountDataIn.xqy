xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLiabilities/conDatoCuentaHN_sp.xsd" ::)

declare variable $countryCode as xs:string external;
declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

declare function local:func($countryCode as xs:string, 
                            $org as xs:string, 
                            $accountNumber as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
                <ns1:InputParameters>
            <ns1:Pais>{ $countryCode }</ns1:Pais>
            {
            	if($org != "")then(
            		<ns1:Org>{ $org }</ns1:Org>
            	)else()
            }
            <ns1:NumCuenta>{ fn-bea:pad-left($accountNumber, 19, '0') }</ns1:NumCuenta>
        </ns1:InputParameters>
};

local:func($countryCode, $org, $accountNumber)