xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCustomerCreditCardTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCustomerCreditCardTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerCC";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerCC/GetCustomerCC_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getCustomerCreditCardRequest as element() (:: schema-element(ns1:getCustomerCreditCardRequest) ::) external;

declare function local:func($getCustomerCreditCardRequest as element() (:: schema-element(ns1:getCustomerCreditCardRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($getCustomerCreditCardRequest/ns1:GeneralInfo/com:SourceBank)
            then <ns2:PV_CODIGO_PAIS>{fn:data($getCustomerCreditCardRequest/ns1:GeneralInfo/com:SourceBank)}</ns2:PV_CODIGO_PAIS>
            else ()
        }
        <ns2:PV_SEARCH_CRITERIA>{fn:data($getCustomerCreditCardRequest/ns1:SearchCriteria)}</ns2:PV_SEARCH_CRITERIA>
        <ns2:PV_SEARCH_VALUE>{fn:data($getCustomerCreditCardRequest/ns1:SearchValue)}</ns2:PV_SEARCH_VALUE>
    </ns2:InputParameters>
};

local:func($getCustomerCreditCardRequest)