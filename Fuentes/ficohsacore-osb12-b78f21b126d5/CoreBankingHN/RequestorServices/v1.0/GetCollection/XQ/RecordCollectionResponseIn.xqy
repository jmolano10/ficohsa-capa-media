xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RecordCollectionResponse";
(:: import schema at "../../../../ProviderServices/XSD/RecordCollectionResponse/RecordCollectionResponse_sp.xsd" ::)

declare variable $errorCode as text() external;
declare variable $validationMessage as text() external;
declare variable $Uuid as text() external;
declare variable $contractId as text() external;
declare variable $debtorCode as text() external;
declare variable $userName as text() external;
declare variable $GetCollectionResponse as element() (:: schema-element(ns1:getCollectionResponse) ::) external;

declare function local:func($errorCode as text(), 
                            $validationMessage as text(), 
                            $Uuid as text(), 
                            $contractId as text(), 
                            $debtorCode as text(), 
                            $userName as text(), 
                            $GetCollectionResponse as element() (:: schema-element(ns1:getCollectionResponse) ::)) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_UUID>{fn:data($Uuid)}</ns2:P_UUID>
        <ns2:P_CODIGO_CONVENIO>{fn:data($contractId)}</ns2:P_CODIGO_CONVENIO>
        <ns2:P_CODIGO_DEUDOR>{fn:data($debtorCode)}</ns2:P_CODIGO_DEUDOR>
        <ns2:P_CODIGO_OPERACION>1</ns2:P_CODIGO_OPERACION>
        <ns2:P_FECHA>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns2:P_FECHA>
        <ns2:P_USUARIO>{fn:data($userName)}</ns2:P_USUARIO>
        <ns2:P_REQ_UUID>{fn:data($Uuid)}</ns2:P_REQ_UUID>
        <ns2:P_COD_ERROR_CORE>{fn:data($errorCode)}</ns2:P_COD_ERROR_CORE>
        <ns2:P_MSG_ERROR_CORE>{fn:data($validationMessage)}</ns2:P_MSG_ERROR_CORE>
        <ns2:P_RESPONSE>{$GetCollectionResponse}</ns2:P_RESPONSE>
    </ns2:InputParameters>
};

local:func($errorCode, $validationMessage, $Uuid, $contractId, $debtorCode, $userName, $GetCollectionResponse)