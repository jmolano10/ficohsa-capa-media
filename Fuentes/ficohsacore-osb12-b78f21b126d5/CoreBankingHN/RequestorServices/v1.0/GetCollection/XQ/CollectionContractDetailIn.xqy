xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $username as xs:string, 
                            $password as xs:string, 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:CollectionContractDetailRequest) ::) {
    <ns2:CollectionContractDetailRequest>
        <ns2:Username>{fn:data($username)}</ns2:Username>
        <ns2:Password>{fn:data($password)}</ns2:Password>
        <ns2:ContractId>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns2:ContractId>
        <ns2:Uuid>{fn:data($uuid)}</ns2:Uuid>
    </ns2:CollectionContractDetailRequest>
};

local:func($GetCollectionRequest, $username, $password, $uuid)