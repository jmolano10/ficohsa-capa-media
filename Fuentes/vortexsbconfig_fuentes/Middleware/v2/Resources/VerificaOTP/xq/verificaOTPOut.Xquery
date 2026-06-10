<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:verificaHOTPResponse" location="../xsd/verificaOTPTypes.xsd" ::)

declare namespace ver = "http://www.ficohsa.com.hn/middleware.services/verificaOTPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPOut/";

declare function xf:verificaOTPOut($status as xs:string)
    as element(ver:verificaHOTPResponse) {
        &lt;ver:verificaHOTPResponse>
            &lt;ver:STATUS>{ $status }&lt;/ver:STATUS>
        &lt;/ver:verificaHOTPResponse>
};

declare variable $status as xs:string external;

xf:verificaOTPOut($status)</con:xquery>
</con:xqueryEntry>