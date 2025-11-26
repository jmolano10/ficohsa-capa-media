xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateAutomaticCollection_BS";
(:: import schema at "../../../../ProviderServices/XSD/CreateAutomaticCollection/CreateAutomaticCollection_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getAccountsResponse as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::) external;
declare variable $createAutomaticCollections as element() (:: schema-element(ns2:automaticCollectionsRequest) ::) external;

declare function xq:Tx_CreateAutomaticCollection_To_ABANKS($getAccountsResponse as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::), 
                                                           $createAutomaticCollections as element() (:: schema-element(ns2:automaticCollectionsRequest) ::)) 
                                                           as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER)
            then <ns3:PV_CUSTOMER_ID>{fn:data($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER)}</ns3:PV_CUSTOMER_ID>
            else ()
        }
        {
            if ($createAutomaticCollections/ns2:AccountNumber)
            then <ns3:PV_ACCOUNT_NUMBER>{fn:data($createAutomaticCollections/ns2:AccountNumber)}</ns3:PV_ACCOUNT_NUMBER>
            else ()
        }
        {
            if ($createAutomaticCollections/ns2:CollectionCode)
            then <ns3:PV_COLLECTION_CONTRACT>{fn:data($createAutomaticCollections/ns2:CollectionCode)}</ns3:PV_COLLECTION_CONTRACT>
            else ()
        }
        {
            if ($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)
            then <ns3:PV_CURRENCY>{fn:data($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)}</ns3:PV_CURRENCY>
            else ()
        }
        {
            if ($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)
            then <ns3:PV_ACCOUNT_NAME>{fn:data($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)}</ns3:PV_ACCOUNT_NAME>
            else ()
        }
        {
            if (fn:data($getAccountsResponse/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER)='Y')
            then <ns3:PV_ACCOUNT_STATUS>INACTIVE</ns3:PV_ACCOUNT_STATUS>
            else
            <ns3:PV_ACCOUNT_STATUS>ACTIVE</ns3:PV_ACCOUNT_STATUS>
        }
        {
            if ($createAutomaticCollections/ns2:GeneralInfo/com:ApplicationUser)
            then <ns3:PV_USER_ID>{fn:data($createAutomaticCollections/ns2:GeneralInfo/com:ApplicationUser)}</ns3:PV_USER_ID>
            else ()
        }
        {
            if ($createAutomaticCollections/ns2:GeneralInfo/com:BranchId)
            then <ns3:PV_BRANCH_CODE>{fn:data($createAutomaticCollections/ns2:GeneralInfo/com:BranchId)}</ns3:PV_BRANCH_CODE>
            else ()
        }
    </ns3:InputParameters>
};

xq:Tx_CreateAutomaticCollection_To_ABANKS($getAccountsResponse, $createAutomaticCollections)
