xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudoSolicitud" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoNI/xq/PagoRecaudoNIIn/";
declare namespace ns3 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare function xf:PagoRecaudoNIIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns0:pagoRecaudoSolicitud) {
        <ns0:pagoRecaudoSolicitud>
            {
                for $ADDITIONAL_INFO in $pagoRecaudo/ADDITIONAL_INFO
                return
                    <ns3:additionalInfo>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <ns3:data>{ data($DATA) }</ns3:data>
                        }
                    </ns3:additionalInfo>
            }
            {
                for $PV_IDCONVENIONI in $outputParameters/ns2:PV_IDCONVENIONI
                return
                    <ns3:contractId>{ data($PV_IDCONVENIONI) }</ns3:contractId>
            }
            <ns3:debtorCode>{ data($pagoRecaudo/DEBTOR_CODE) }</ns3:debtorCode>
            {
                for $DEBTOR_NAME in $pagoRecaudo/DEBTOR_NAME
                return
                    <ns3:debtorName>{ data($DEBTOR_NAME) }</ns3:debtorName>
            }
            {
                let $PAYMENT_INFORMATION := $pagoRecaudo/PAYMENT_INFORMATION
                return
                    <ns3:paymentInformation>
                        <ns3:paymentMethod>
                         { 
                         	let $data := data($PAYMENT_INFORMATION/PAYMENT_METHOD)
                         	return
                         	if ( $data = 'ACCT_DEBIT') then (
			  					"DEB.TO.ACCT"
							)else if ( $data = 'CREDIT_CARD') then (
								"DEB.TO.TCRE"	
							)
							else () 
                         } 
                        </ns3:paymentMethod>
                        <ns3:paymentCurrency>{ data($PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns3:paymentCurrency>
                        <ns3:paymentAmount>{ data($PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns3:paymentAmount>
                        {
                            for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <ns3:debitAccount>{ data($DEBIT_ACCOUNT) }</ns3:debitAccount>
                        }
                        {
                            for $CHEQUE_NUMBER in $PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <ns3:chequeNumber>{ data($CHEQUE_NUMBER) }</ns3:chequeNumber>
                        }
                        {
                            for $BANK_CODE in $PAYMENT_INFORMATION/BANK_CODE
                            return
                                <ns3:bankCode>{ data($BANK_CODE) }</ns3:bankCode>
                        }
                        {
                            for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                            return
                                <ns3:creditCardNumber>{ data($CREDIT_CARD_NUMBER) }</ns3:creditCardNumber>
                        }
                        <ns3:expirationDate>{ data($PAYMENT_INFORMATION/EXPIRATION_DATE) }</ns3:expirationDate>
                    </ns3:paymentInformation>
            }
            {
                for $BILL_INFORMATION in $pagoRecaudo/BILL_INFORMATION
                return
                    <ns3:billInformation>
                        {
                            for $BILL_NUMBER in $BILL_INFORMATION/BILL_NUMBER
                            return
                                <ns3:billNumber>{ data($BILL_NUMBER) }</ns3:billNumber>
                        }
                        {
                            for $DUE_DATE in $BILL_INFORMATION/DUE_DATE
                            return
                                <ns3:dueDate>{ data($DUE_DATE) }</ns3:dueDate>
                        }
                    </ns3:billInformation>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $pagoRecaudo/EXTENDED_COLLECTION_YES_NO
                return
                    <ns3:extendedCollectionYesNo>{ data($EXTENDED_COLLECTION_YES_NO) }</ns3:extendedCollectionYesNo>
            }
            {
                for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudo/DEALSLIP_PICKUP_BRANCH
                return
                    <ns3:dealslipPickupBranch>{ data($DEALSLIP_PICKUP_BRANCH) }</ns3:dealslipPickupBranch>
            }
            {
                for $PV_COBRANZA in $outputParameters/ns2:PV_COBRANZA
                return
                    <ns3:cobranza>{ data($PV_COBRANZA) }</ns3:cobranza>
            }
        </ns0:pagoRecaudoSolicitud>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:PagoRecaudoNIIn($pagoRecaudo,
    $outputParameters)