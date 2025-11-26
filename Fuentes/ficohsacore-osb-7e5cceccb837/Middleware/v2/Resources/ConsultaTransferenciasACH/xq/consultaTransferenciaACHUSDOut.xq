(:: pragma bea:local-element-parameter parameter="$getStatusReportUSDResult1" type="ns2:GetStatusReportUSDResponse/ns2:GetStatusReportUSDResult" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransferenciasACHResponse" location="../xsd/consultaTransferenciasACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransferenciasACHTypes";
declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/WcfACHOnline";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransferenciasACH/xq/consultaTransferenciaACHUSDOut/";

declare function xf:consultaTransferenciaACHUSDOut($getStatusReportUSDResult1 as element())
    as element(ns0:consultaTransferenciasACHResponse) {
        <ns0:consultaTransferenciasACHResponse>
            {
                for $Identification in $getStatusReportUSDResult1/ns1:Identification
                return
                    <IDENTIFICATION>{ data($Identification) }</IDENTIFICATION>
            }
            {
                for $MessageType in $getStatusReportUSDResult1/ns1:MessageType
                return
                    <MESSAGE_TYPE>{ data($MessageType) }</MESSAGE_TYPE>
            }
            {
                for $ResultMessage in $getStatusReportUSDResult1/ns1:ResultMessage
                return
                    <RESULT_MESSAGE>{ data($ResultMessage) }</RESULT_MESSAGE>
            }
            {
                for $UserName in $getStatusReportUSDResult1/ns1:UserName
                return
                    <USERNAME>{ data($UserName) }</USERNAME>
            }
            {
                for $OriginalMessageId in $getStatusReportUSDResult1/ns1:OriginalMessageId
                return
                    <ORIGINAL_MESSAGE_ID>{ data($OriginalMessageId) }</ORIGINAL_MESSAGE_ID>
            }
            {
                for $Processed in $getStatusReportUSDResult1/ns1:Processed
                return
                    <PROCESSED_DATE>{ data($Processed) }</PROCESSED_DATE>
            }
            {
                for $ReceivingBankId in $getStatusReportUSDResult1/ns1:ReceivingBankId
                return
                    <RECEIVING_BANK_ID>{ data($ReceivingBankId) }</RECEIVING_BANK_ID>
            }
            {
                for $ReasonCode in $getStatusReportUSDResult1/ns1:ReasonCode
                return
                    <REASON_CODE>{ data($ReasonCode) }</REASON_CODE>
            }
        </ns0:consultaTransferenciasACHResponse>
};

declare variable $getStatusReportUSDResult1 as element() external;

xf:consultaTransferenciaACHUSDOut($getStatusReportUSDResult1)