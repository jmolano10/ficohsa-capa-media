(:: pragma bea:global-element-return element="ns0:verificaHOTPResponse" location="../xsd/verificaOTPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/verificaOTPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPOut/";

declare function xf:verificaOTPOut($status as xs:string)
    as element(ns0:verificaHOTPResponse) {
        <ns0:verificaHOTPResponse>
            <ns0:STATUS>{ $status }</ns0:STATUS>
        </ns0:verificaHOTPResponse>
};

declare variable $status as xs:string external;

xf:verificaOTPOut($status)
