(:: pragma bea:global-element-parameter parameter="$inwardRemitQuery" element="ns2:inwardRemitQuery" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:QueryRemittance" location="../../../../BusinessServices/MoneyTransferOperations/wsdl/SwitchRemittanceService.asmx.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/InwardRemitQuery/xq/queryRemittanceGTIn/";

declare function xf:queryRemittanceGTIn($inwardRemitQuery as element(ns2:inwardRemitQuery))
    as element(ns1:QueryRemittance) {
        <ns1:QueryRemittance>
            <ns1:pRequest>
                {
                    for $REMIT_COMPANY_ID in $inwardRemitQuery/ns2:REMIT_COMPANY_ID
                    return
                        <ns1:RemitCompanyID>{ data($REMIT_COMPANY_ID) }</ns1:RemitCompanyID>
                }
                <ns1:RemittanceID>{ data($inwardRemitQuery/ns2:REMITTANCE_ID) }</ns1:RemittanceID>
                {
                    let $BENEFICIARY := $inwardRemitQuery/ns2:BENEFICIARY
                    return
                        <ns1:Beneficiary>
                            <ns1:TypeID>{ data($BENEFICIARY/ns2:TYPE_ID) }</ns1:TypeID>
                            <ns1:NumberID>{ data($BENEFICIARY/ns2:NUMBER_ID) }</ns1:NumberID>
                        </ns1:Beneficiary>
                }
                {
                    let $NSO_INFO := $inwardRemitQuery/ns2:NSO_INFO
                    return
                        <ns1:NsoInfo>
                            {
                                let $TRACE := $NSO_INFO/ns0:TRACE
                                return
                                    <ns1:Trace>
                                        <ns1:TellerID>{ data($TRACE/ns0:TELLER_ID) }</ns1:TellerID>
                                        <ns1:BranchID>{ data($TRACE/ns0:BRANCH_ID) }</ns1:BranchID>
                                        <ns1:ChanelCode>{ data($TRACE/ns0:CHANNEL_CODE) }</ns1:ChanelCode>
                                        {
                                        	let $DATE_TIME := $TRACE/ns0:DATE_TIME
                                        	return
                                        		<ns1:DateTime>{fn-bea:dateTime-to-string-with-format("yyyyMMddHH:mm:ss",$DATE_TIME)}</ns1:DateTime>
                                        }                                                                                	                                                                                                                       
                                        {
                                            for $QUEUE_TICKET_ID in $TRACE/ns0:QUEUE_TICKET_ID
                                            return
                                                <ns1:QueueTicketID>{ data($QUEUE_TICKET_ID) }</ns1:QueueTicketID>
                                        }
                                        {
                                            for $TXN_REF_NO in $TRACE/ns0:TXN_REF_NO
                                            return
                                                <ns1:TxnRefNo>{ data($TXN_REF_NO) }</ns1:TxnRefNo>
                                        }
                                        {
                                            for $DEALSLIP_ID in $TRACE/ns0:DEALSLIP_ID
                                            return
                                                <ns1:DealslipID>{ data($DEALSLIP_ID) }</ns1:DealslipID>
                                        }
                                    </ns1:Trace>
                            }
                            {
                                for $AUTHORIZATION in $NSO_INFO/ns0:AUTHORIZATION
                                return
                                    <ns1:Authorization>
                                        <ns1:Type>{ data($AUTHORIZATION/ns0:TYPE) }</ns1:Type>
                                        {
                                            for $KV_PAIRS in $AUTHORIZATION/ns0:KV_PAIRS
                                            return
                                                <ns1:KVPairs>
                                                    <ns1:pair>
                                                        {
                                                            for $PAIR in $KV_PAIRS/ns0:PAIR
                                                            return
                                                                <ns1:RequestNSO_InfoAuthKVPairsPair>
                                                                    <ns1:Key>{ data($PAIR/ns0:KEY) }</ns1:Key>
                                                                    <ns1:Value>{ data($PAIR/ns0:VALUE) }</ns1:Value>
                                                                </ns1:RequestNSO_InfoAuthKVPairsPair>
                                                        }
                                                    </ns1:pair>
                                                </ns1:KVPairs>
                                        }
                                    </ns1:Authorization>
                            }
                            {
                                for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns0:BANKNOTE_BREAKDOWN
                                return
                                    <ns1:BankNoteBreakdown>
                                        <ns1:BankNote>
                                            {
                                                for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns0:BANKNOTE
                                                return
                                                    <ns1:RequestNSO_InfoBankNoteBankNote>
                                                        <ns1:Currency>{ data($BANKNOTE/ns0:CURRENCY) }</ns1:Currency>
                                                        <ns1:Value>{ data($BANKNOTE/ns0:VALUE) }</ns1:Value>
                                                        <ns1:Quantity>{ data($BANKNOTE/ns0:QUANTITY) }</ns1:Quantity>
                                                        <ns1:Total>{ data($BANKNOTE/ns0:TOTAL) }</ns1:Total>
                                                    </ns1:RequestNSO_InfoBankNoteBankNote>
                                            }
                                        </ns1:BankNote>
                                    </ns1:BankNoteBreakdown>
                            }
                            {
                                for $ADDITIONAL_INFO in $NSO_INFO/ns0:ADDITIONAL_INFO
                                return
                                    <ns1:AdditionalInfo>
                                        {
                                            for $KV_PAIRS in $ADDITIONAL_INFO/ns0:KV_PAIRS
                                            return
                                                <ns1:KVPairs>
                                                    <ns1:Pair>
                                                        {
                                                            for $PAIR in $KV_PAIRS/ns0:PAIR
                                                            return
                                                                <ns1:RequestNSO_InfoAuthKVPairsPair>
                                                                    <ns1:Key>{ data($PAIR/ns0:KEY) }</ns1:Key>
                                                                    <ns1:Value>{ data($PAIR/ns0:VALUE) }</ns1:Value>
                                                                </ns1:RequestNSO_InfoAuthKVPairsPair>
                                                        }
                                                    </ns1:Pair>
                                                </ns1:KVPairs>
                                        }
                                    </ns1:AdditionalInfo>
                            }
                            {
                            	for $CTR_REFERENCE in $NSO_INFO/ns0:CTR_REFERENCE
                            	return                            	
                            		<ns1:CtrReference>{ data($CTR_REFERENCE) }</ns1:CtrReference>                            		                            		
                            }                            
                        </ns1:NsoInfo>
                }
            </ns1:pRequest>
        </ns1:QueryRemittance>
};

declare variable $inwardRemitQuery as element(ns2:inwardRemitQuery) external;

xf:queryRemittanceGTIn($inwardRemitQuery)