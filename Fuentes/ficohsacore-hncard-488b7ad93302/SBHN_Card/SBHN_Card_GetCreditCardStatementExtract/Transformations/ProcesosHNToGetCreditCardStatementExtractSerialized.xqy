xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)
declare namespace bf. = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare variable $statusService as xs:string external;
declare variable $globalId as xs:string external;

declare variable $getSerializedResponse as element() (:: schema-element(ns1:ObtenerSerializadoResponse) ::) external;

declare function local:funcProcesosHNToGetCreditCardStatementExtractSerialized($getSerializedResponse as element() (:: schema-element(ns1:ObtenerSerializadoResponse) ::),
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
       <CardNumber>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:NumeroTarjeta)}</CardNumber>
        <AccountNumber>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:NumeroCuenta)}</AccountNumber>
        <Month>{fn:substring(fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:Periodo),5,2)}</Month>
        <Year>{ fn:substring(fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:Periodo),1,4)}</Year>
        <FileExtract>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:File)}</FileExtract>
        <FileExtension>{fn:data($getSerializedResponse/ns1:ObtenerSerializadoResult/bf.:Extension)}</FileExtension>
        <FileLink></FileLink>
    </ns2:getCreditCardStatementExtractResponse>
};

local:funcProcesosHNToGetCreditCardStatementExtractSerialized($getSerializedResponse, $statusService, $globalId)