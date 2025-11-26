xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CollectionQueryRecord";
(:: import schema at "../../../../ProviderServices/XSD/CollectionQueryRecord/CollectionQueryRecord_sp.xsd" ::)

declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($uuid as xs:string, 
                            $user as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
    <ns2:P_UUID>{fn:data($uuid)}</ns2:P_UUID>
        <ns2:P_CODIGO_CONVENIO>{fn:data($paymentCollectionRequest/ns1:ContractId)}</ns2:P_CODIGO_CONVENIO>
        <ns2:P_CODIGO_DEUDOR>{fn:data($paymentCollectionRequest/ns1:DebtorCode)}</ns2:P_CODIGO_DEUDOR>
        <ns2:P_CODIGO_OPERACION>1</ns2:P_CODIGO_OPERACION>
        <ns2:P_FECHA>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns2:P_FECHA>
        <ns2:P_USUARIO>{fn:data($user)}</ns2:P_USUARIO>
        <ns2:P_REQUEST>{ $paymentCollectionRequest }</ns2:P_REQUEST>
    </ns2:InputParameters>
};

local:func($uuid, $user, $paymentCollectionRequest)