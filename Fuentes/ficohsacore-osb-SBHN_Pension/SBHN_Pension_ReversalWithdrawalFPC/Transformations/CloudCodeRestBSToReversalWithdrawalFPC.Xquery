<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";
(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/APIFPCTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/ReversalWithdrawalFPCTypes.xsd" ::)

declare variable $CloudCodeRestBSResponse as element() (:: schema-element(ns2:CloudCodeResponse) ::) external;
declare variable $StatusService as xs:string external;
declare variable $GlobalId as xs:string external;

declare function local:funcCloudCodeRestBSToReversalWithdrawalFPC($CloudCodeRestBSResponse as element() (:: schema-element(ns2:CloudCodeResponse) ::), 
                                                                  $StatusService as xs:string, 
                                                                  $GlobalId as xs:string) 
                                                                  as element() (:: schema-element(ns1:ReversalWithdrawalFPCResponse) ::) {
    <ns1:ReversalWithdrawalFPCResponse>
        <StatusInfo>
            {
                if ($CloudCodeRestBSResponse/ns2:error and $CloudCodeRestBSResponse/ns2:mensaje)
                then <Status>{fn:data($CloudCodeRestBSResponse/ns2:error),',',fn:data($CloudCodeRestBSResponse/ns2:mensaje)}</Status>
                else ()
            }
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
    </ns1:ReversalWithdrawalFPCResponse>
};

local:funcCloudCodeRestBSToReversalWithdrawalFPC($CloudCodeRestBSResponse, $StatusService, $GlobalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/APIFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_ReversalWithdrawalFPC/Schemas/APIFPCTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/ReversalWithdrawalFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_ReversalWithdrawalFPC/Schemas/ReversalWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>