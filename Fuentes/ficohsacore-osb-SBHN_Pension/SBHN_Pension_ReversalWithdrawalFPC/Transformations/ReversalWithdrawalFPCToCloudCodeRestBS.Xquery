<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/APIFPCTypes.xsd", 
                     "../Schemas/ReversalWithdrawalFPC.xsd" ::)

declare variable $ReversalWithdrawalFPC as element() (:: schema-element(ns1:ReversalWithdrawalFPC) ::) external;

declare function local:funcReversalWithdrawalFPCToCloudCodeRestBS($ReversalWithdrawalFPC as element() (:: schema-element(ns1:ReversalWithdrawalFPC) ::)) as element() (:: schema-element(ns1:CloudCode) ::) {
    <ns1:CloudCode>
        <ns1:numeroTransaccion>{fn:data($ReversalWithdrawalFPC/TransactionNumber)}</ns1:numeroTransaccion>
        <ns1:cuenta>{fn:data($ReversalWithdrawalFPC/AccountNumber)}</ns1:cuenta>
    </ns1:CloudCode>
};

local:funcReversalWithdrawalFPCToCloudCodeRestBS($ReversalWithdrawalFPC)]]></con:xquery>
</con:xqueryEntry>