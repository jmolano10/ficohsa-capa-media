<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/PaymentWithdrawalFPCTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns2:retirosPostResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($response as element() (:: schema-element(ns2:retirosPostResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) 
                            as element() (:: schema-element(ns1:paymentWithdrawalFPCResponse) ::) {
    <ns1:paymentWithdrawalFPCResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
                if ($response/ns2:error)
                then <ErrorCode>{fn:data($response/ns2:error)}</ErrorCode>
                else ()
        }
        {
                if ($response/ns2:mensaje)
                then <ErrorMessage>{fn:data($response/ns2:mensaje)}</ErrorMessage>
                else ()
        }
        
    </ns1:paymentWithdrawalFPCResponse>
};

local:func($response, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/PaymentWithdrawalFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_PaymentWithdrawalFPC/Schemas/PaymentWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>