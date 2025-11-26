xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDetails/GetCustomerDetails_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getCustomerDetailsIn";

declare variable $customerId as xs:string external;
declare variable $queryType as xs:string external;

declare function ns1:getCustomerDetailsIn($customerId as xs:string, 
                                          $queryType as xs:string) 
                                          as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($queryType = "CustomerId") then
                <ns2:PV_CUSTOMER_ID>{fn:data($customerId)}</ns2:PV_CUSTOMER_ID>
            else    
                <ns2:PV_LEGAL_ID>{fn:data($customerId)}</ns2:PV_LEGAL_ID>
        }        
    </ns2:InputParameters>
};

ns1:getCustomerDetailsIn($customerId, $queryType)