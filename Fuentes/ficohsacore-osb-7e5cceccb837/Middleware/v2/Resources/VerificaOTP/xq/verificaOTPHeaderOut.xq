(:: pragma bea:global-element-parameter parameter="$procVerificaOTPOutput" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/verificaOTP/xsd/verificaOTP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/verificaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaOTP/xq/verificaOTPHeaderOut/";

declare function xf:verificaOTPHeaderOut($procVerificaOTPOutput as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $procVerificaOTPOutput as element(ns1:OutputParameters) external;

xf:verificaOTPHeaderOut($procVerificaOTPOutput)
