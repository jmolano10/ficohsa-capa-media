(:: pragma bea:global-element-parameter parameter="$sendDebitHNLResponse1" element="ns1:SendDebitHNLResponse" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)
(:: pragma bea:global-element-return element="ns2:envioTransferenciasACHResponse" location="../xsd/envioTransferenciasACHTypes.xsd" ::)

declare namespace ns0 = "http://schemas.datacontract.org/2004/07/WcfACHOnline";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioTransferenciasACH/xq/envioTransferenciasACHHNLOut/";

declare function xf:envioTransferenciasACHHNLOut($sendDebitHNLResponse1 as element(ns1:SendDebitHNLResponse))
    as element(ns2:envioTransferenciasACHResponse) {
        <ns2:envioTransferenciasACHResponse>
            <RESULT>
                <ORIGINAL_MESSAGE_ID>{ data($sendDebitHNLResponse1/ns1:SendDebitHNLResult/ns0:MessageID) }</ORIGINAL_MESSAGE_ID>
                <REASON_CODE>{ data($sendDebitHNLResponse1/ns1:SendDebitHNLResult/ns0:ReasonCode) }</REASON_CODE>
                <RESULT_MESSAGE>{ data($sendDebitHNLResponse1/ns1:SendDebitHNLResult/ns0:Message) }</RESULT_MESSAGE>
                <SUCCESS_INDICATOR>{ data($sendDebitHNLResponse1/ns1:SendDebitHNLResult/ns0:SuccessIndicator) }</SUCCESS_INDICATOR>
            </RESULT>
        </ns2:envioTransferenciasACHResponse>
};

declare variable $sendDebitHNLResponse1 as element(ns1:SendDebitHNLResponse) external;

xf:envioTransferenciasACHHNLOut($sendDebitHNLResponse1)