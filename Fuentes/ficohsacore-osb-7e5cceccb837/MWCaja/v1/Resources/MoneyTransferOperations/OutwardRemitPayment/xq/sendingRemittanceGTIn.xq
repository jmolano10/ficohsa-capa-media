(:: pragma bea:global-element-parameter parameter="$outwardRemitPayment" element="ns2:outwardRemitPayment" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SendingRemittance" location="../../../../BusinessServices/MoneyTransferOperations/wsdl/SwitchRemittanceService.asmx.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/OutwardRemitPayment/xq/sendingRemittanceGTIn/";

declare function xf:sendingRemittanceGTIn($outwardRemitPayment as element(ns2:outwardRemitPayment))
    as element(ns1:SendingRemittance) {
        <ns1:SendingRemittance>
            <ns1:pRequest>
                {
                    for $REMITT_COMPANY_ID in $outwardRemitPayment/ns2:REMITT_COMPANY_ID
                    return
                        <ns1:RemittCompanyID>{ data($REMITT_COMPANY_ID) }</ns1:RemittCompanyID>
                }
                {
                    let $SENDER_INFO := $outwardRemitPayment/ns2:SENDER_INFO
                    return
                        <ns1:SenderInfo>
                            <ns1:TypeID>{ data($SENDER_INFO/ns2:TYPE_ID) }</ns1:TypeID>
                            <ns1:NumberID>{ data($SENDER_INFO/ns2:NUMBER_ID) }</ns1:NumberID>
                        </ns1:SenderInfo>
                }
                {
                    let $BENEFICIARY_INFO := $outwardRemitPayment/ns2:BENEFICIARY_INFO
                    return
                        <ns1:BeneficiaryInfo>
                            <ns1:TypeID>{ data($BENEFICIARY_INFO/ns0:TYPE_ID) }</ns1:TypeID>
                            <ns1:NumberID>{ data($BENEFICIARY_INFO/ns0:NUMBER_ID) }</ns1:NumberID>
                            <ns1:FirstName>{ data($BENEFICIARY_INFO/ns0:FIRST_NAME) }</ns1:FirstName>
                            <ns1:MiddleName>{ data($BENEFICIARY_INFO/ns0:MIDDLE_NAME) }</ns1:MiddleName>
                            <ns1:LastName>{ data($BENEFICIARY_INFO/ns0:LAST_NAME) }</ns1:LastName>
                            {
                                for $LAST_NAME2 in $BENEFICIARY_INFO/ns0:LAST_NAME2
                                return
                                    <ns1:LastName2>{ data($LAST_NAME2) }</ns1:LastName2>
                            }
                            <ns1:Address>{ data($BENEFICIARY_INFO/ns0:ADDRESS) }</ns1:Address>
                            {
                                for $ADDRESS2 in $BENEFICIARY_INFO/ns0:ADDRESS2
                                return
                                    <ns1:Address2>{ data($ADDRESS2) }</ns1:Address2>
                            }
                            <ns1:CityCode>{ data($BENEFICIARY_INFO/ns0:CITY_CODE) }</ns1:CityCode>
                            <ns1:CountryCode>{ data($BENEFICIARY_INFO/ns0:COUNTRY_CODE) }</ns1:CountryCode>
                            <ns1:StateCode>{ data($BENEFICIARY_INFO/ns0:STATE_CODE) }</ns1:StateCode>
                            <ns1:ZipCode>{ data($BENEFICIARY_INFO/ns0:ZIP_CODE) }</ns1:ZipCode>
                            <ns1:Phone>{ data($BENEFICIARY_INFO/ns0:PHONE) }</ns1:Phone>
                            <ns1:PhoneCountryCode>{ data($BENEFICIARY_INFO/ns0:PHONE_COUNTRY_CODE) }</ns1:PhoneCountryCode>
                            {
                                for $EMAIL in $BENEFICIARY_INFO/ns0:EMAIL
                                return
                                    <ns1:Email>{ data($EMAIL) }</ns1:Email>
                            }
                        </ns1:BeneficiaryInfo>
                }
                {
                    let $PAYMENT := $outwardRemitPayment/ns2:PAYMENT
                    return
                        <ns1:Payment>
                            <ns1:PayItem>
                                {
                                    for $PAY_ITEM in $PAYMENT/ns0:PAY_ITEM
                                    return
                                        <ns1:RequestPaymentRemittancePayItem>
                                            <ns1:Type>{ data($PAY_ITEM/ns0:TYPE) }</ns1:Type>
                                            <ns1:Currency>{ data($PAY_ITEM/ns0:CURRENCY) }</ns1:Currency>
                                            {
                                            	for $AMOUNT in $PAY_ITEM/ns0:AMOUNT
                                            	return 
                                            		<ns1:Amount>{ data($AMOUNT) }</ns1:Amount>
                                            }                                            
                                            {
                                                for $MORE_INFO in $PAY_ITEM/ns0:MORE_INFO
                                                return
                                                    <ns1:MoreInfo>
                                                        {
                                                            for $ACCOUNT in $MORE_INFO/ns0:ACCOUNT
                                                            return
                                                                <ns1:Account>
                                                                    <ns1:Number>{ data($ACCOUNT/ns0:NUMBER) }</ns1:Number>
                                                                </ns1:Account>
                                                        }
                                                        {
                                                            for $CHECK in $MORE_INFO/ns0:CHECK
                                                            return
                                                                <ns1:Check>
                                                                    <ns1:CheckNumber>{ data($CHECK/ns0:CHECK_NUMBER) }</ns1:CheckNumber>
                                                                    {
                                                                    	for $ACCOUNT_NUMBER in $CHECK/ns0:ACCOUNT_NUMBER
                                                                    	return
                                                                    		<ns1:AccountNumber>{ data($ACCOUNT_NUMBER) }</ns1:AccountNumber> 
                                                                    }                                                                    
                                                                    {
                                                                        for $BANK_CODE in $CHECK/ns0:BANK_CODE
                                                                        return
                                                                            <ns1:BankCode>{ data($BANK_CODE) }</ns1:BankCode>
                                                                    }
                                                                    {
                                                                        for $BANK_DESCRIPTION in $CHECK/ns0:BANK_DESCRIPTION
                                                                        return
                                                                            <ns1:BankDescription>{ data($BANK_DESCRIPTION) }</ns1:BankDescription>
                                                                    }
                                                                </ns1:Check>
                                                        }
                                                        {
                                                            for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                            return
                                                                <ns1:CreditCard>
	                                                                {
	                                                                	for $CARD_NUMBER in $CREDIT_CARD/ns0:CARD_NUMBER
	                                                                	return
	                                                                		<ns1:CardNumber>{ data($CARD_NUMBER) }</ns1:CardNumber>
	                                                                }                                                                    
                                                                    <ns1:ExpirationDate>{ data($CREDIT_CARD/ns0:EXPIRATION_DATE) }</ns1:ExpirationDate>
                                                                    <ns1:VerificationCode>{ data($CREDIT_CARD/ns0:VERIFICATION_CODE) }</ns1:VerificationCode>
                                                                </ns1:CreditCard>
                                                        }
                                                        {
                                                            for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                            return
                                                                <ns1:DebitCard>
                                                                	{
                                                                		for $CARD_NUMBER in $DEBIT_CARD/ns0:CARD_NUMBER
                                                                		return
                                                                			<ns1:CardNumber>{ data($CARD_NUMBER) }</ns1:CardNumber>
                                                                			
                                                                	}                                                                    
                                                                    <ns1:ExpirationDate>{ data($DEBIT_CARD/ns0:EXPIRATION_DATE) }</ns1:ExpirationDate>
                                                                    <ns1:VerificationCode>{ data($DEBIT_CARD/ns0:VERIFICATION_CODE) }</ns1:VerificationCode>
                                                                </ns1:DebitCard>
                                                        }
                                                    </ns1:MoreInfo>
                                            }
                                        </ns1:RequestPaymentRemittancePayItem>
                                }
                            </ns1:PayItem>
                        </ns1:Payment>
                }
                {
                    let $NSO_INFO := $outwardRemitPayment/ns2:NSO_INFO
                    return
                        <ns1:NsoInfo>
                            {
                                let $TRACE := $NSO_INFO/ns0:TRACE
                                return
                                    <ns1:Trace>
                                        <ns1:TellerID>{ data($TRACE/ns0:TELLER_ID) }</ns1:TellerID>
                                        <ns1:BranchID>{ data($TRACE/ns0:BRANCH_ID) }</ns1:BranchID>
                                        <ns1:ChanelCode>{ data($TRACE/ns0:CHANNEL_CODE) }</ns1:ChanelCode>
                                        <ns1:DateTime>{ data($TRACE/ns0:DATE_TIME) }</ns1:DateTime>
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
        </ns1:SendingRemittance>
};

declare variable $outwardRemitPayment as element(ns2:outwardRemitPayment) external;

xf:sendingRemittanceGTIn($outwardRemitPayment)