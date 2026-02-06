xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/verificaOTP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/verificaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/PWS/verificaOTP/xq/verificaOTP/";

declare function xf:verificaOTP($entityType as xs:string,
    $entityId as xs:string,
    $otpType as xs:string,
    $otpHash as xs:string,
     $otpUserChannel as xs:string,
    $otpCountry as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_ENTITY_TYPE>{ $entityType }</ns0:P_ENTITY_TYPE>
            <ns0:P_ENTITY_ID>{ $entityId }</ns0:P_ENTITY_ID>
            <ns0:P_OTP_TYPE>{ $otpType }</ns0:P_OTP_TYPE>
            <ns0:P_OTP_HASH>{ $otpHash }</ns0:P_OTP_HASH>
            <ns0:P_CHANNEL_USER>{ $otpUserChannel }</ns0:P_CHANNEL_USER>
            <ns0:P_OTP_COUNTRY>{ $otpCountry }</ns0:P_OTP_COUNTRY>
        </ns0:InputParameters>
};

declare variable $entityType as xs:string external;
declare variable $entityId as xs:string external;
declare variable $otpType as xs:string external;
declare variable $otpHash as xs:string external;
declare variable $otpUserChannel as xs:string external;
declare variable $otpCountry as xs:string external;

xf:verificaOTP($entityType,
    $entityId,
    $otpType,
    $otpHash,
    $otpUserChannel,
    $otpCountry)