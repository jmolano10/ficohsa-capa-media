(:: pragma bea:global-element-parameter parameter="$pagoRecaudoRespuesta" element="ns0:pagoRecaudoRespuesta" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns4:pagoRecaudo" location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns4:pagoRecaudoResponse" location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoNI/xq/PagoRecaudoNIOut/";

declare function xf:PagoRecaudoNIOut($pagoRecaudoRespuesta as element(ns0:pagoRecaudoRespuesta),
    $pagoRecaudo1 as element(ns4:pagoRecaudo), $nombreConvenio as xs:string) 
    as element(ns4:pagoRecaudoResponse) {
        <ns4:pagoRecaudoResponse>
        	<CONTRACT_NAME>{$nombreConvenio}</CONTRACT_NAME>
            {
                for $debtorName in $pagoRecaudoRespuesta/ns2:agreements/ns2:agreement/ns2:debtors/ns2:debtor/ns2:debtorName
                return
                    <DEBTOR_NAME>{ data($debtorName) }</DEBTOR_NAME>
            }
            {
                for $inputter in $pagoRecaudoRespuesta/ns2:agreements/ns2:agreement/ns2:inputter
                return
                    <INPUTTER>{ data($inputter) }</INPUTTER>
            }
            {
                for $fecTransaccion in $pagoRecaudoRespuesta/ns2:contextoRespuesta/ns2:fecTransaccion
                return
                    <DATE_TIME>{ data($fecTransaccion) }</DATE_TIME>
            }
            {
                for $branchName in $pagoRecaudoRespuesta/ns2:agreements/ns2:agreement/ns2:branchName
                return
                    <BRANCH_NAME>{ data($branchName) }</BRANCH_NAME>
            }
            {
                let $PAYMENT_INFORMATION := $pagoRecaudo1/PAYMENT_INFORMATION
                return
                    <PAYMENT_INFORMATION>
                        <PAYMENT_METHOD>
                        { 
                        	let $data := data($PAYMENT_INFORMATION/PAYMENT_METHOD)
                        	return
                         	if ( $data = 'DEB.TO.ACCT') then (
			  					"ACC_DEBIT"
							)else if ( $data = 'DEB.TO.TCRE') then (
								"CREDIT_CARD"	
							)
							else () 
                    	}
                    	</PAYMENT_METHOD>
                        <PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                        {
                            for $PAYMENT_AMOUNT in $PAYMENT_INFORMATION/PAYMENT_AMOUNT
                            return
                                <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                        }
                        {
                            for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                        }
                        {
                            for $CHEQUE_NUMBER in $PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                        }
                        {
                            for $BANK_CODE in $PAYMENT_INFORMATION/BANK_CODE
                            return
                                <BANK_CODE>{ data($BANK_CODE) }</BANK_CODE>
                        }
                        {
                            for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                            return
                                <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                        }
                        {
                            for $EXPIRATION_DATE in $PAYMENT_INFORMATION/EXPIRATION_DATE
                            return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        }
                    </PAYMENT_INFORMATION>
            }
            {
                for $billDetail in $pagoRecaudoRespuesta/ns2:agreements/ns2:agreement/ns2:debtors/ns2:debtor/ns2:bills/ns2:bill/ns2:billDetail
                return
                    <BILL_DETAIL>{ data($billDetail) }</BILL_DETAIL>
            }
        </ns4:pagoRecaudoResponse>
};

declare variable $pagoRecaudoRespuesta as element(ns0:pagoRecaudoRespuesta) external;
declare variable $pagoRecaudo1 as element(ns4:pagoRecaudo) external;
declare variable $nombreConvenio as xs:string external;

xf:PagoRecaudoNIOut($pagoRecaudoRespuesta,
    $pagoRecaudo1,$nombreConvenio)