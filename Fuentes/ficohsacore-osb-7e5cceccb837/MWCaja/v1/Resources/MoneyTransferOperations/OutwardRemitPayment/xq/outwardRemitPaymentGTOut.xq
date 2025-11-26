(:: pragma bea:global-element-parameter parameter="$sendingRemittanceResponse" element="ns2:SendingRemittanceResponse" location="../../../../BusinessServices/MoneyTransferOperations/wsdl/SwitchRemittanceService.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:outwardRemitPaymentResponse" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)

declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/OutwardRemitPayment/xq/outwardRemitPaymentGTOut/";

declare function xf:outwardRemitPaymentGTOut($sendingRemittanceResponse as element(ns2:SendingRemittanceResponse))
    as element(ns1:outwardRemitPaymentResponse) {
        <ns1:outwardRemitPaymentResponse>
            {
                for $RemittCompanyID in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:RemittCompanyID
                return
                    <ns1:REMITT_COMPANY_ID>{ data($RemittCompanyID) }</ns1:REMITT_COMPANY_ID>
            }
            {
                for $RemittCompanyName in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:RemittCompanyName
                return
                    <ns1:REMITT_COMPANY_NAME>{ data($RemittCompanyName) }</ns1:REMITT_COMPANY_NAME>
            }
            {
                for $RemittanceID in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:RemittanceID
                return
                    <ns1:REMITTANCE_ID>{ data($RemittanceID) }</ns1:REMITTANCE_ID>
            }
            {
                for $Currency in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:Currency
                return
                    <ns1:CURRENCY>{ data($Currency) }</ns1:CURRENCY>
            }
            {
            	for $SendingAmount in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:SendingAmount
            	return
            		<ns1:SENDER_AMOUNT>{ data($SendingAmount) }</ns1:SENDER_AMOUNT>
            }
            {
            	for $ReceiverAmount in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:ReceiverAmount
            	return
            		<ns1:RECEIVER_AMOUNT>{ data($ReceiverAmount) }</ns1:RECEIVER_AMOUNT>            	
            }
            {
            	for $ExchangeRate in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:ExchangeRate
            	return
            		<ns1:EXCHANGE_RATE>{ data($ExchangeRate) }</ns1:EXCHANGE_RATE>
            }                                    
            {
                for $senderInfo in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:senderInfo
                return
                    <ns1:SENDER_INFO>
      					<ns0:ABANKS_CUSTOMER_EXIST>{data($senderInfo/ns2:AbanksCustomerExist)}</ns0:ABANKS_CUSTOMER_EXIST>                     
                        <ns0:ABANKS_CUSTOMER_ID>{ data($senderInfo/ns2:AbanksCustomerID) }</ns0:ABANKS_CUSTOMER_ID>
                        {
                            for $IdNumber in $senderInfo/ns2:IdNumber
                            return
                                <ns0:ID_NUMBER>{ data($IdNumber) }</ns0:ID_NUMBER>
                        }
                        {
                            for $FirstName in $senderInfo/ns2:FirstName
                            return
                                <ns0:FIRST_NAME>{ data($FirstName) }</ns0:FIRST_NAME>
                        }
                        {
                            for $LastName in $senderInfo/ns2:LastName
                            return
                                <ns0:LAST_NAME>{ data($LastName) }</ns0:LAST_NAME>
                        }
                        {
                            for $OtherName in $senderInfo/ns2:OtherName
                            return
                                <ns0:OTHER_NAME>{ data($OtherName) }</ns0:OTHER_NAME>
                        }
                    </ns1:SENDER_INFO>
            }
            {
                for $BeneficiaryInfo in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:BeneficiaryInfo
                return
                    <ns1:BENEFICIARY_INFO>
                        <ns0:FIRST_NAME>{ data($BeneficiaryInfo/ns2:FirstName) }</ns0:FIRST_NAME>
                        <ns0:LAST_NAME>{ data($BeneficiaryInfo/ns2:LastName) }</ns0:LAST_NAME>
                        {
                            for $SenderOtherName in $BeneficiaryInfo/ns2:OtherName
                            return
                                <ns0:OTHER_NAME>{ data($SenderOtherName) }</ns0:OTHER_NAME>
                        }
                        <ns0:COUNTRY_NAME>{ data($BeneficiaryInfo/ns2:CountryName) }</ns0:COUNTRY_NAME>
                    </ns1:BENEFICIARY_INFO>
            }
            {
            	for $ResponseCode in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:ResponseCode
            	return
            		<ns1:RESPONSE_CODE>{ data($ResponseCode) }</ns1:RESPONSE_CODE>
            		
            }            
            {
                for $ResponseMessage in $sendingRemittanceResponse/ns2:ResponseSendingRemittance/ns2:ResponseMessage
                return
                    <ns1:RESPONSE_MESSAGE>{ data($ResponseMessage) }</ns1:RESPONSE_MESSAGE>
            }
        </ns1:outwardRemitPaymentResponse>
};

declare variable $sendingRemittanceResponse as element(ns2:SendingRemittanceResponse) external;

xf:outwardRemitPaymentGTOut($sendingRemittanceResponse)