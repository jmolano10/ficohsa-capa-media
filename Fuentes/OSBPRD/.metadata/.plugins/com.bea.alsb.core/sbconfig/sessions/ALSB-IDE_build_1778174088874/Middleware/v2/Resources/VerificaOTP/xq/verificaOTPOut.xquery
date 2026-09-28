<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>(:: pragma bea:global-element-return element="ns0:verificaHOTPResponse" location="../xsd/verificaOTPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/verificaOTPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPOut/";

declare function xf:verificaOTPOut($status as xs:string)
    as element(ns0:verificaHOTPResponse) {
        &lt;ns0:verificaHOTPResponse>
            &lt;ns0:STATUS>{ $status }&lt;/ns0:STATUS>
        &lt;/ns0:verificaHOTPResponse>
};

declare variable $status as xs:string external;

xf:verificaOTPOut($status)</con:xquery>
    <con:dependency location="../xsd/verificaOTPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/VerificaOTP/xsd/verificaOTPTypes"/>
    </con:dependency>
</con:xqueryEntry>