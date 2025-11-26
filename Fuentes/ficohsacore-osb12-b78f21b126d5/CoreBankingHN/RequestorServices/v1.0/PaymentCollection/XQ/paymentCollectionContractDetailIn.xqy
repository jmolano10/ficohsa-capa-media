xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)

declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($uuid as xs:string, 
                            $username as xs:string, 
                            $password as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:CollectionContractDetailRequest) ::) {
    <ns2:CollectionContractDetailRequest>
        <ns2:Username>{fn:data($username)}</ns2:Username>
        <ns2:Password>{fn:data($password)}</ns2:Password>
        <ns2:ContractId>{fn:data($paymentCollectionRequest/ns1:ContractId)}</ns2:ContractId>
        <ns2:Uuid>{fn:data($uuid)}</ns2:Uuid>
    </ns2:CollectionContractDetailRequest>
};

local:func($uuid, $username, $password, $paymentCollectionRequest)