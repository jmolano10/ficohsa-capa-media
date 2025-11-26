xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/QueryThirdPartyResponse";
(:: import schema at "../../../../ProviderServices/XSD/QueryThirdPartyResponse/QueryThirdPartyResponse_sp.xsd" ::)

declare variable $GetCollectionResponse as element() (:: schema-element(ns1:getCollectionResponse) ::) external;

declare function local:func($GetCollectionResponse as element() (:: schema-element(ns1:getCollectionResponse) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            for $DebtorName in $GetCollectionResponse/ns1:DebtorName
            return
              <ns2:SOLICITUD_ID>{ fn-bea:fail-over(fn:tokenize($DebtorName, "//")[1],"") }</ns2:SOLICITUD_ID>
        }
        {
            for $DebtorName in $GetCollectionResponse/ns1:DebtorName
            return
              <ns2:COD_OPERACION>{ fn-bea:fail-over(fn:tokenize($DebtorName, "//")[2],"") }</ns2:COD_OPERACION>
        }
    </ns2:InputParameters>
};

local:func($GetCollectionResponse)