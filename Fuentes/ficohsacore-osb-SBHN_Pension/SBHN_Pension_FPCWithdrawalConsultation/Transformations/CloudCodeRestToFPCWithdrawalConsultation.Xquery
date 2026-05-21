<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace pen="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/APIFPCTypes.xsd", 
                     "../Schemas/FPCWithdrawalConsultationTypes.xsd" ::)

declare variable $CloudCodeRestResponse as element() (:: schema-element(pen:CloudCodeResponse) ::) external;
declare variable $StatusService as xs:string external;
declare variable $GlobalId as xs:string external;

declare function local:funcCloudCodeRestToFPCWithdrawalConsultation($CloudCodeRestResponse as element() (:: schema-element(pen:CloudCodeResponse) ::),
                                                                    $StatusService as xs:string, 
                                                                    $GlobalId as xs:string) as element() (:: schema-element(pen:FPCWithdrawalConsultationResponse) ::) {
    <pen:FPCWithdrawalConsultationResponse>
        <StatusInfo>
            <Status>{fn:data($StatusService)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
        <Account>{fn:data($CloudCodeRestResponse/datos/retiros/cuenta)}</Account>
        <ClientName>{fn:data($CloudCodeRestResponse/datos/retiros/nombreCliente)}</ClientName>
        <IdNumber>{fn:data($CloudCodeRestResponse/datos/retiros/numeroIdentificacion)}</IdNumber>
        <PaymentMethod>{fn:data($CloudCodeRestResponse/datos/retiros/formaPago)}</PaymentMethod>
        <Currency>{fn:data($CloudCodeRestResponse/datos/retiros/moneda)}</Currency>
        <Amount>{fn:data($CloudCodeRestResponse/datos/retiros/monto)}</Amount>
        <WithdrawalType>{fn:data($CloudCodeRestResponse/datos/retiros/tipoRetiro)}</WithdrawalType>
        <BankingAccount>{fn:data($CloudCodeRestResponse/datos/retiros/cuentaBancaria)}</BankingAccount>
    </pen:FPCWithdrawalConsultationResponse>
};

local:funcCloudCodeRestToFPCWithdrawalConsultation($CloudCodeRestResponse, $StatusService, $GlobalId)]]></con:xquery>
</con:xqueryEntry>