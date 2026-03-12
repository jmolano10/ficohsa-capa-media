xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConnectionAdquirVasa";
(:: import schema at "../Schemas/ConnectionAdquirVasa_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)

declare variable $VASAOutput as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $TipoArchivo as xs:string external;
declare variable $GlobalId as xs:string external;
declare variable $StatusService as xs:string external;

declare function local:funcGetUriVasaToGetCreditCardStatementExtract($VASAOutput as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                                     $TipoArchivo as xs:string, 
                                                                     $GlobalId as xs:string, 
                                                                     $StatusService as xs:string) 
                                                                     as element() (:: schema-element(ns2:getCreditCardStatementExtractResponse) ::) {
    <ns2:getCreditCardStatementExtractResponse>
        <StatusInfo>
            <Status>{fn:data($StatusService)}</Status>
            <TransactionId></TransactionId>
           <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ValueDate>           
           <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
        <CardNumber>{fn:data($VASAOutput/ns1:P_NUMERO_TARJETA)}</CardNumber>
        <AccountNumber>{fn:data($VASAOutput/ns1:P_NUMERO_CUENTA)}</AccountNumber>
        <Month>{fn:data($VASAOutput/ns1:P_MES)}</Month>
        <Year>{fn:data($VASAOutput/ns1:P_ANIO)}</Year>
        <FileExtension>{fn:data($TipoArchivo)}</FileExtension>
        <FileLink>{fn:data($VASAOutput/ns1:P_URL)}</FileLink>
       
    </ns2:getCreditCardStatementExtractResponse>
};

local:funcGetUriVasaToGetCreditCardStatementExtract($VASAOutput, $TipoArchivo, $GlobalId, $StatusService)