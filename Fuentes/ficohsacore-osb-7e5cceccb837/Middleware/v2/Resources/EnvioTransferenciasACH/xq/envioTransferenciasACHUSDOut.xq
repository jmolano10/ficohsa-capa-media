(:: pragma bea:global-element-parameter parameter="$sendDebitUSDResponse1" element="ns1:SendDebitUSDResponse" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)
(:: pragma bea:global-element-return element="ns2:envioTransferenciasACHResponse" location="../xsd/envioTransferenciasACHTypes.xsd" ::)

declare namespace ns0 = "http://schemas.datacontract.org/2004/07/WcfACHOnline";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioTransferenciasACH/xq/envioTransferenciasACHUSDOut/";

declare function xf:envioTransferenciasACHUSDOut($sendDebitUSDResponse1 as element(ns1:SendDebitUSDResponse))
    as element(ns2:envioTransferenciasACHResponse) {
        <ns2:envioTransferenciasACHResponse>
            <RESULT>
                {
                    for $MessageID in $sendDebitUSDResponse1/ns1:SendDebitUSDResult/ns0:MessageID
                    return
                        <ORIGINAL_MESSAGE_ID>{ data($MessageID) }</ORIGINAL_MESSAGE_ID>
                }
                {
                    for $ReasonCode in $sendDebitUSDResponse1/ns1:SendDebitUSDResult/ns0:ReasonCode
                    return
                        <REASON_CODE>{ data($ReasonCode) }</REASON_CODE>
                }
                {
                    for $Message in $sendDebitUSDResponse1/ns1:SendDebitUSDResult/ns0:Message
                    return
                        <RESULT_MESSAGE>{ data($Message) }</RESULT_MESSAGE>
                }
                {
                    for $SuccessIndicator in $sendDebitUSDResponse1/ns1:SendDebitUSDResult/ns0:SuccessIndicator
                    return
                        <SUCCESS_INDICATOR>{ data($SuccessIndicator) }</SUCCESS_INDICATOR>
                }
            </RESULT>
        </ns2:envioTransferenciasACHResponse>
};

declare variable $sendDebitUSDResponse1 as element(ns1:SendDebitUSDResponse) external;

xf:envioTransferenciasACHUSDOut($sendDebitUSDResponse1)