(:: pragma bea:global-element-parameter parameter="$getStatusReportUSDResponse1" element="ns1:GetStatusReportUSDResponse" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransaccionACHResponse" location="../xsd/consultaTransaccionACHTypes.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/WcfACHOnline";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/GetStatusReportUSDOut/";

declare function xf:GetStatusReportUSDOut($getStatusReportUSDResponse1 as element(ns1:GetStatusReportUSDResponse))
    as element(ns0:consultaTransaccionACHResponse) {
        <ns0:consultaTransaccionACHResponse>
            {
                for $OriginalMessageId in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:OriginalMessageId
                return
                    <ORIGINAL_MESSAGE_ID>{ data($OriginalMessageId) }</ORIGINAL_MESSAGE_ID>
            }
            {
                for $Processed in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:Processed
                return
                    <PROCESSED_DATE>{ data($Processed) }</PROCESSED_DATE>
            }
            {
                for $ReceivingBankId in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ReceivingBankId
                return
                    <RECEIVING_BANK_ID>{ data($ReceivingBankId) }</RECEIVING_BANK_ID>
            }
            {
                for $ReasonCode in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ReasonCode
                return
                    <REASON_CODE>{ data($ReasonCode) }</REASON_CODE>
            }
            <TRANSACTIONS>
                <TRANSACTION_RECORD>
                    {
                        for $DetailId in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:DetailId
                        return
                            <DETAIL_ID>{ data($DetailId) }</DETAIL_ID>
                    }
                    {
                        for $OriginatingAccount in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:OriginatingAccount
                        return
                            <ORIGINATING_ACCOUNT>{ data($OriginatingAccount) }</ORIGINATING_ACCOUNT>
                    }
                    {
                        for $ReceivingAccount in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:ReceivingAccount
                        return
                            <RECEIVING_ACCOUNT>{ data($ReceivingAccount) }</RECEIVING_ACCOUNT>
                    }
                    {
                        for $ReceivingAccountName in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:ReceivingAccountName
                        return
                            <RECEIVING_ACCOUNT_NAME>{ data($ReceivingAccountName) }</RECEIVING_ACCOUNT_NAME>
                    }
                    {
                        for $Status in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:Status
                        return
                            <STATUS>{ fn:upper-case(data($Status)) }</STATUS>
                    }
                    {
                        for $Amount in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:Amount
                        return
                            <AMOUNT>{ data($Amount) }</AMOUNT>
                    }
                    {
                        for $Results in $getStatusReportUSDResponse1/ns1:GetStatusReportUSDResult/ns2:ItemDetails/ns2:ResponseItemDetails[1]/ns2:Results
                        return
                            <RESULTS>{ data($Results) }</RESULTS>
                    }
                </TRANSACTION_RECORD>
            </TRANSACTIONS>
        </ns0:consultaTransaccionACHResponse>
};

declare variable $getStatusReportUSDResponse1 as element(ns1:GetStatusReportUSDResponse) external;

xf:GetStatusReportUSDOut($getStatusReportUSDResponse1)