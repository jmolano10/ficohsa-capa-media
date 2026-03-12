xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)

declare namespace bf. = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";

declare variable $getHeaderV2Response as element() (:: schema-element(ns1:ObtenerEncabezadosV2Response) ::) external;
declare variable $cardNumber as xs:string external;
declare variable $fileType as xs:string external;
declare variable $getHeaders as xs:string external;
declare variable $statusService as xs:string external;
declare variable $globalId as xs:string external;

declare function local:funcProcesosHNToGetCreditCardStatementExtractHeader($getHeaderV2Response as element() (:: schema-element(ns1:ObtenerEncabezadosV2Response) ::), 
                                                                           $cardNumber as xs:string, 
                                                                           $fileType as xs:string, 
                                                                           $getHeaders as xs:string,
                                                                           $statusService as xs:string,
                                                                           $globalId as xs:string
                                                                           ) 
                                                                           as element() (:: schema-element(ns2:getCreditCardStatementExtractResponse) ::) {
     <ns2:getCreditCardStatementExtractResponse>
     
       <StatusInfo>
           <Status>{fn:data($statusService)}</Status>
           <TransactionId></TransactionId>
           <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ValueDate>           
           <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</DateTime>
           <GlobalId>{fn:data($globalId)}</GlobalId>
       </StatusInfo>
       <CardNumber>{fn:data($cardNumber)}</CardNumber>
        <AccountNumber>{fn:data($getHeaderV2Response/ns1:ObtenerEncabezadosV2Result/bf.:Encabezados/bf.:DatoObtenerEncabezadosV2[1]/bf.:NumCuenta)}</AccountNumber>
        <Month>{fn:substring(fn:data($getHeaderV2Response/ns1:ObtenerEncabezadosV2Result/bf.:Encabezados/bf.:DatoObtenerEncabezadosV2[1]/bf.:Periodo),5,2)}</Month>
        <Year>{fn:substring(fn:data($getHeaderV2Response/ns1:ObtenerEncabezadosV2Result/bf.:Encabezados/bf.:DatoObtenerEncabezadosV2[1]/bf.:Periodo),1,4)}</Year>
        <FileExtract></FileExtract>
        <FileExtension>{fn:data($fileType)}</FileExtension>
        <FileLink>{fn:data($getHeaderV2Response/ns1:ObtenerEncabezadosV2Result/bf.:Encabezados/bf.:DatoObtenerEncabezadosV2[1]/bf.:FileLink)}</FileLink>
    </ns2:getCreditCardStatementExtractResponse>
};

local:funcProcesosHNToGetCreditCardStatementExtractHeader($getHeaderV2Response, $cardNumber, $fileType, $getHeaders, $statusService, $globalId)