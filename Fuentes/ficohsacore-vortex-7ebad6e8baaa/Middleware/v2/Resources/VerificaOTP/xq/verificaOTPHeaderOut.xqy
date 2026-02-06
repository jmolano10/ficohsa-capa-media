xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-parameter parameter="$procVerificaOTPOutput" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/verificaOTP/xsd/verificaOTP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace aut = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/verificaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPHeaderOut/";

declare function xf:verificaOTPHeaderOut($procVerificaOTPOutput as element(ns1:OutputParameters))
    as element(aut:ResponseHeader) {
        <aut:ResponseHeader>
            {
                for $P_RETURN_CODE in $procVerificaOTPOutput/ns1:P_RETURN_CODE
                return
                    <successIndicator>{ data($P_RETURN_CODE) }</successIndicator>
            }
            {
                for $P_RETURN_MESSAGE in $procVerificaOTPOutput/ns1:P_RETURN_MESSAGE
                return
                    <messages>{ data($P_RETURN_MESSAGE) }</messages>
            }
        </aut:ResponseHeader>
};

declare variable $procVerificaOTPOutput as element(ns1:OutputParameters) external;

xf:verificaOTPHeaderOut($procVerificaOTPOutput)