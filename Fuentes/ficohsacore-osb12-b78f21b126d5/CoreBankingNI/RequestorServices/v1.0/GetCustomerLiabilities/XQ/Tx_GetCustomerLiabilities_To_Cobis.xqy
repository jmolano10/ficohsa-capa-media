xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerLiabilities_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerLiabilities_BS_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/middleware.services/Tx_GetCustomerLiabilities_To_Cobis";

declare variable $customerId as xs:integer external;
declare variable $liabilityType as xs:string external;

declare function ns1:Tx_GetCustomerLiabilities_To_Cobis($customerId as xs:integer, 
                                                        $liabilityType as xs:string) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:i_CUSTOMER_ID>{fn:data($customerId)}</ns3:i_CUSTOMER_ID>
        {
        if (fn:data($liabilityType) = 'CreditCards')
        then <ns3:i_LIABILITY_TYPE>TRC</ns3:i_LIABILITY_TYPE>
        else (if (fn:data($liabilityType) = 'Loans') 
        then <ns3:i_LIABILITY_TYPE>PTM</ns3:i_LIABILITY_TYPE> 
        else <ns3:i_LIABILITY_TYPE>ALL</ns3:i_LIABILITY_TYPE> )
        }
      
      </ns3:InputParameters>
};

ns1:Tx_GetCustomerLiabilities_To_Cobis($customerId, $liabilityType)