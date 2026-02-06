xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:verificaHOTPResponse" location="../xsd/verificaOTPTypes.xsd" ::)

declare namespace ver = "http://www.ficohsa.com.hn/middleware.services/verificaOTPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPOut/";

declare function xf:verificaOTPOut($status as xs:string)
    as element(ver:verificaHOTPResponse) {
        <ver:verificaHOTPResponse>
            <ver:STATUS>{ $status }</ver:STATUS>
        </ver:verificaHOTPResponse>
};

declare variable $status as xs:string external;

xf:verificaOTPOut($status)