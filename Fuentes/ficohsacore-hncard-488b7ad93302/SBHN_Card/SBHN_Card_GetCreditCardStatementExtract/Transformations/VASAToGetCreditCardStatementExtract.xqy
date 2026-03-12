xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../Resources/ConsultarReportes_1.wsdl" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)
declare variable $statusService as xs:string external;
declare variable $globalId as xs:string external;


declare variable $getSerializedResponse as element() (:: schema-element(ns1:ObtenerSerializadoResponse) ::) external;

declare function local:funcVASAToGetCreditCardStatementExtract($getSerializedResponse as element() (:: schema-element(ns1:ObtenerSerializadoResponse) ::),
                            $statusService as xs:string,
                            $globalId as xs:string
                            ) as element() (:: schema-element(ns2:getCreditCardStatementExtractResponse) ::) {
    <ns2:getCreditCardStatementExtractResponse>
    <StatusInfo>
           <Status>{fn:data($statusService)}</Status>
           <TransactionId></TransactionId>
           <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ValueDate>           
           <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</DateTime>
           <GlobalId>{fn:data($globalId)}</GlobalId>
       </StatusInfo>
        <CardNumber>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:NumeroTarjeta)}</CardNumber>
        <AccountNumber>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:NumeroCuenta)}</AccountNumber>
        <Month>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:Periodo)}</Month>
        <Year>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:Periodo)}</Year>
        <FileExtract>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:File)}</FileExtract>
        <FileExtension>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/ns1:Extension)}</FileExtension>
        <FileLink></FileLink>
    </ns2:getCreditCardStatementExtractResponse>
};

local:funcVASAToGetCreditCardStatementExtract($getSerializedResponse, $statusService, $globalId)