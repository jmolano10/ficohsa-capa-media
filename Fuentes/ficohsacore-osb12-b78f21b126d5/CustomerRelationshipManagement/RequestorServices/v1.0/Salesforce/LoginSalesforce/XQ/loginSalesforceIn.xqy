xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="urn:enterprise.soap.sforce.com";
(:: import schema at "../../../../../ProviderServices/v1.0/WSDL/SalesforceRGNEnterprise/SalesforceRGN_BS.wsdl" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/loginSalesforceIn";

declare variable $username as xs:string external;
declare variable $password as xs:string external;

declare function ns1:loginSalesforceIn($username as xs:string, 
                                       $password as xs:string) 
                                       as element() (:: schema-element(ns2:login) ::) {
    <ns2:login>
        <ns2:username>{fn:data($username)}</ns2:username>
        <ns2:password>{fn:data($password)}</ns2:password>
    </ns2:login>
};

ns1:loginSalesforceIn($username, $password)
