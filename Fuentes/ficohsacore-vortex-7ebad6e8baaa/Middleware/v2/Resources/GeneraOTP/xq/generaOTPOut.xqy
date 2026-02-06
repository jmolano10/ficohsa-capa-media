xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/guardaOTP/xsd/guardaOTP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaHOTPResponse" location="../xsd/generaOTPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaOTPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraOTP/xq/generaHOTPOut/";

declare function xf:generaHOTPOut($outputParameters as element(ns1:OutputParameters),
    $otpValue as xs:string)
    as element(ns0:generaHOTPResponse) {
        <ns0:generaHOTPResponse>
            <ns0:OTP_VALUE>{ $otpValue }</ns0:OTP_VALUE>
            {
                for $P_GENERATION_DATE in $outputParameters/ns1:P_GENERATION_DATE
                return
                    <ns0:DATE>{ data($P_GENERATION_DATE) }</ns0:DATE>
            }
        </ns0:generaHOTPResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $otpValue as xs:string external;

xf:generaHOTPOut($outputParameters,
    $otpValue)