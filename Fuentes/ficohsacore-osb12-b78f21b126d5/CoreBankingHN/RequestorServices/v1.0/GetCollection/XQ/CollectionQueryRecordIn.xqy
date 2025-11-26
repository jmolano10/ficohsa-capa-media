xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CollectionQueryRecord";
(:: import schema at "../../../../ProviderServices/XSD/CollectionQueryRecord/CollectionQueryRecord_sp.xsd" ::)

declare variable $user as xs:string external;
declare variable $Uuid as xs:string external;
declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;

declare function local:func($user as xs:string,
                            $Uuid as xs:string,
                            $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_UUID>{fn:data($Uuid)}</ns2:P_UUID>
        <ns2:P_CODIGO_CONVENIO>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns2:P_CODIGO_CONVENIO>
        <ns2:P_CODIGO_DEUDOR>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns2:P_CODIGO_DEUDOR>
        <ns2:P_CODIGO_OPERACION>1</ns2:P_CODIGO_OPERACION>
        <ns2:P_FECHA>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns2:P_FECHA>
        <ns2:P_USUARIO>{fn:data($user)}</ns2:P_USUARIO>
        <ns2:P_REQUEST>{ $GetCollectionRequest }</ns2:P_REQUEST>
    </ns2:InputParameters>
};

local:func($user, $Uuid, $GetCollectionRequest)