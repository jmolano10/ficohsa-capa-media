xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaHOTPRequest" element="ns0:generaHOTPRequest" location="../../../../Resources/GeneraOTP/xsd/generaOTPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../xsd/guardaOTP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaOTPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraOTP/xq/guardaOTPIn/";

declare function xf:guardaOTPIn($generaHOTPRequest as element(ns0:generaHOTPRequest),
    $otpType as xs:string,
    $otpEncrypted as xs:string,
    $otpHash as xs:string,
    $otpUserChannel as xs:string,
    $otpCountry as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_ENTITY_TYPE>{ data($generaHOTPRequest/ns0:ENTITY_INFO/ns0:TYPE) }</ns1:P_ENTITY_TYPE>
            <ns1:P_ENTITY_ID>{ data($generaHOTPRequest/ns0:ENTITY_INFO/ns0:ID) }</ns1:P_ENTITY_ID>
            <ns1:P_OTP_TYPE>{ $otpType }</ns1:P_OTP_TYPE>
            <ns1:P_OTP_ENCRYPTED>{ $otpEncrypted }</ns1:P_OTP_ENCRYPTED>
            <ns1:P_OTP_HASH>{ $otpHash }</ns1:P_OTP_HASH>
            <ns1:P_CHANNEL_USER>{ $otpUserChannel }</ns1:P_CHANNEL_USER>
            <ns1:P_OTP_COUNTRY>{ $otpCountry }</ns1:P_OTP_COUNTRY>
        </ns1:InputParameters>
};

declare variable $generaHOTPRequest as element(ns0:generaHOTPRequest) external;
declare variable $otpType as xs:string external;
declare variable $otpEncrypted as xs:string external;
declare variable $otpHash as xs:string external;
declare variable $otpUserChannel as xs:string external;
declare variable $otpCountry as xs:string external;

xf:guardaOTPIn($generaHOTPRequest,
    $otpType,
    $otpEncrypted,
    $otpHash,
    $otpUserChannel,
    $otpCountry)