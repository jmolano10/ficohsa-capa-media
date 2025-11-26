(:: pragma bea:global-element-parameter parameter="$sjPagoMultipleRecaudoResponse" element="ns1:sjPagoMultipleRecaudoResponse" location="../../../BusinessServices/SJS/pagoMultipleRecaudo/xsd/sjPagoMultipleRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoMultipleRecaudoResponse" location="../xsd/pagoMultipleRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoMultipleRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagoMultipleRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoMultipleRecaudo/xq/pagoMultipleRecaudoOut/";

declare function xf:pagoMultipleRecaudoOut($sjPagoMultipleRecaudoResponse as element(ns1:sjPagoMultipleRecaudoResponse))
    as element(ns0:pagoMultipleRecaudoResponse) {
        <ns0:pagoMultipleRecaudoResponse>
            <ns0:AGREEMENTS>
                {
                    for $contractID in distinct-values($sjPagoMultipleRecaudoResponse/AGREEMENTS/AGREEMENT/CONTRACT_ID)
                        let $agreementsByID := $sjPagoMultipleRecaudoResponse/AGREEMENTS/AGREEMENT[ CONTRACT_ID = $contractID ]
                        return
                        <ns0:AGREEMENT>
                            <ns0:CONTRACT_ID>{ data($contractID) }</ns0:CONTRACT_ID>
                            {
                            	let $agreementsSuccess := $agreementsByID[ upper-case(SUCCESS_INDICATOR) = 'SUCCESS' ]
                            	return(
                            		if( count($agreementsSuccess) > 0 )then(
                            			for $CONTRACT_NAME in $agreementsSuccess[1]/CONTRACT_NAME
		                                return
		                                    <ns0:CONTRACT_NAME>{ data($CONTRACT_NAME) }</ns0:CONTRACT_NAME>,
		                                    
		                                for $INPUTTER in $agreementsSuccess[1]/INPUTTER
		                                return
		                                    <ns0:INPUTTER>{ data($INPUTTER) }</ns0:INPUTTER>,
		                                    
		                                for $BRANCH_NAME in $agreementsSuccess[1]/BRANCH_NAME
		                                return
		                                    <ns0:BRANCH_NAME>{ data($BRANCH_NAME) }</ns0:BRANCH_NAME>
                            		)else()	
                            	)
                            }
                            <ns0:DEBTORS>
                                {
                                    for $debtorCode in distinct-values($agreementsByID/DEBTOR_CODE)
                                        let $agreementsByDebtor := $agreementsByID[ DEBTOR_CODE = $debtorCode ]
                                        return
                                        <ns0:DEBTOR>
                                            <ns0:DEBTOR_CODE>{ data($debtorCode) }</ns0:DEBTOR_CODE>
                                            {
                                                for $DEBTOR_NAME in $agreementsByDebtor[ upper-case(SUCCESS_INDICATOR) = 'SUCCESS' ][1]/DEBTOR_NAME
                                                return
                                                    <ns0:DEBTOR_NAME>{ data($DEBTOR_NAME) }</ns0:DEBTOR_NAME>
                                            }
                                            <ns0:BILLS>
                                                {
                                                    for $agreementsByBill in $agreementsByDebtor
                                                    return
                                                        <ns0:BILL>
                                                        <ns0:BILL_NUMBER>{ data($agreementsByBill/BILL_NUMBER) }</ns0:BILL_NUMBER>
                                                        <ns0:SUCCESS_INDICATOR>{ data($agreementsByBill/SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>
                                                        {
                                                            for $ERROR_MESSAGE in $agreementsByBill/ERROR_MESSAGE
                                                            return
                                                                <ns0:ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
                                                        }
                                                        {
                                                        	for $transactionID in $agreementsByBill/TRANSACTION_ID
                                                        	return
                                                        	<ns0:TRANSACTION_ID>{ data($transactionID) }</ns0:TRANSACTION_ID>
                                                        }
                                                        {
                                                            for $DATE_TIME in $agreementsByBill/DATE_TIME
                                                            return
                                                                <ns0:DATE_TIME>{ data($DATE_TIME) }</ns0:DATE_TIME>
                                                        }
                                                        {
                                                            for $PAYMENT_INFORMATION in $agreementsByBill/PAYMENT_INFORMATION
                                                            return
                                                            <ns0:PAYMENT_INFORMATION>
                                                                {
                                                                	for $PAYMENT_METHOD in $PAYMENT_INFORMATION/PAYMENT_METHOD
                                                                	return
                                                                	<ns0:PAYMENT_METHOD>{ data($PAYMENT_METHOD) }</ns0:PAYMENT_METHOD>
                                                                }
                                                                {
                                                                	for $PAYMENT_CURRENCY in $PAYMENT_INFORMATION/PAYMENT_CURRENCY
                                                                	return
                                                                	<ns0:PAYMENT_CURRENCY>{ data($PAYMENT_CURRENCY) }</ns0:PAYMENT_CURRENCY>
                                                                }
                                                                {
                                                                    for $PAYMENT_AMOUNT in $PAYMENT_INFORMATION/PAYMENT_AMOUNT
                                                                    return
                                                                        <ns0:PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:PAYMENT_AMOUNT>
                                                                }
                                                                {
                                                                    for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/DEBIT_ACCOUNT
                                                                    return
                                                                        <ns0:DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
                                                                }
                                                                {
                                                                    for $CHEQUE_NUMBER in $PAYMENT_INFORMATION/CHEQUE_NUMBER
                                                                    return
                                                                        <ns0:CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns0:CHEQUE_NUMBER>
                                                                }
                                                                {
                                                                    for $BANK_CODE in $PAYMENT_INFORMATION/BANK_CODE
                                                                    return
                                                                        <ns0:BANK_CODE>{ data($BANK_CODE) }</ns0:BANK_CODE>
                                                                }
                                                                {
                                                                    for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                                                                    return
                                                                        <ns0:CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</ns0:CREDIT_CARD_NUMBER>
                                                                }
                                                                {
                                                                    for $EXPIRATION_DATE in $PAYMENT_INFORMATION/EXPIRATION_DATE
                                                                    return
                                                                        <ns0:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
                                                                }
                                                            </ns0:PAYMENT_INFORMATION>
                                                        }
                                                        {
                                                            for $BILL_DETAIL in $agreementsByBill/BILL_DETAIL
                                                            return
                                                                <ns0:BILL_DETAIL>{ data($BILL_DETAIL) }</ns0:BILL_DETAIL>
                                                        }
                                                    </ns0:BILL>
                                                }
                                            </ns0:BILLS>
                                        </ns0:DEBTOR>
                                }
                            </ns0:DEBTORS>
                    </ns0:AGREEMENT>
                }
            </ns0:AGREEMENTS>
        </ns0:pagoMultipleRecaudoResponse>
};

declare variable $sjPagoMultipleRecaudoResponse as element(ns1:sjPagoMultipleRecaudoResponse) external;

xf:pagoMultipleRecaudoOut($sjPagoMultipleRecaudoResponse)