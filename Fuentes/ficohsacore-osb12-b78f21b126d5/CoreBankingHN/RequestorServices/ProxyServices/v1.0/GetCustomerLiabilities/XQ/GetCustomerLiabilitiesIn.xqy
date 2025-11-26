xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
(:: import schema at "../../../../../../LegacyCoreBankingHN/ProviderServices/XSD/GetCustomerLiabilities/ConsultaListaPrestamos.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/GetCustomerLiabilitiesIn";

declare variable $customerId as xs:string external;
declare variable $liabilityType as xs:string external;

declare function ns1:GetCustomerLiabilitiesIn($customerId as xs:string, 
                                              $liabilityType as xs:string) 
                                              as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CUSTOMER_ID>{fn:data($customerId)}</ns2:CUSTOMER_ID>
        <ns2:LIABILITY_TYPE>{fn:data($liabilityType)}</ns2:LIABILITY_TYPE>
    </ns2:InputParameters>
};

ns1:GetCustomerLiabilitiesIn($customerId, $liabilityType)