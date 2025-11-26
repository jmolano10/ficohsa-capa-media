xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerLists";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersLists.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CustomerListsPetition_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLists/CustomerListsPetition_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $request as element() (:: schema-element(ns1:customerListPetitionRequest) ::) external;

declare function xq:Tx_GetCustomerLists_To_Abanks($request as element() (:: schema-element(ns1:customerListPetitionRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($request/ns1:GeneralInfo/com:ApplicationId)
            then <ns2:PV_APLICATION_ID>{fn:data($request/ns1:GeneralInfo/com:ApplicationId)}</ns2:PV_APLICATION_ID>
            else ()
        }
        {
            if ($request/ns1:remittance)
            then <ns2:PV_REMESA>{fn:data($request/ns1:remittance)}</ns2:PV_REMESA>
            else ()
        }
        {
            if ($request/ns1:name)
            then <ns2:PV_NOMBRE>{fn:data($request/ns1:name)}</ns2:PV_NOMBRE>
            else ()
        }
        {
            if ($request/ns1:beneficiary)
            then <ns2:PV_BENEFICIARIO>{fn:data($request/ns1:beneficiary)}</ns2:PV_BENEFICIARIO>
            else ()
        }
    </ns2:InputParameters>
};

xq:Tx_GetCustomerLists_To_Abanks($request)