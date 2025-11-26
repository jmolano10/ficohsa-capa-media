xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $legalId as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $uuid as xs:string external;

declare function ns1:ConsultaListasClienteSjIn($legalId as xs:string, 
                                               $username as xs:string, 
                                               $password as xs:string,
                                               $sourceBank as xs:string,
                                               $destinationBank as xs:string,
                                               $uuid as xs:string) 
                                               as element() (:: schema-element(ns2:getCustomerListsHN_SJRequest) ::) {
    <ns2:getCustomerListsHN_SJRequest>
        <ns2:USERNAME>{ fn:data($username) }</ns2:USERNAME>
        <ns2:PASSWORD>{ fn:data($password) }</ns2:PASSWORD>
        <ns2:CUSTOMER_LEGAL_ID>{fn:data($legalId)}</ns2:CUSTOMER_LEGAL_ID>
        <ns2:SOURCE_BANK>{fn:data($sourceBank)}</ns2:SOURCE_BANK>
        <ns2:DESTINATION_BANK>{fn:data($destinationBank)}</ns2:DESTINATION_BANK>
        <ns2:UUID>{fn:data($uuid)}</ns2:UUID>
    </ns2:getCustomerListsHN_SJRequest>
};

ns1:ConsultaListasClienteSjIn($legalId, $username, $password, $sourceBank, $destinationBank, $uuid)