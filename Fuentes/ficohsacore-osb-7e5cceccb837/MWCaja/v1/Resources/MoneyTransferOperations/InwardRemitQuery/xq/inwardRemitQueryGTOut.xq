(:: pragma bea:global-element-parameter parameter="$queryRemittanceResponse" element="ns2:QueryRemittanceResponse" location="../../../../BusinessServices/MoneyTransferOperations/wsdl/SwitchRemittanceService.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:inwardRemitQueryResponse" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)

declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/InwardRemitQuery/xq/inwardRemitQueryGTOut/";

declare function xf:inwardRemitQueryGTOut($queryRemittanceResponse as element(ns2:QueryRemittanceResponse))
    as element(ns1:inwardRemitQueryResponse) {
        <ns1:inwardRemitQueryResponse>
            {
                for $RemitCompanyID in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:RemitCompanyID
                return
                    <ns1:REMIT_COMPANY_ID>{ data($RemitCompanyID) }</ns1:REMIT_COMPANY_ID>
            }
            {
                for $RemitCompanyName in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:RemitCompanyName
                return
                    <ns1:REMIT_COMPANY_NAME>{ data($RemitCompanyName) }</ns1:REMIT_COMPANY_NAME>
            }
            {
                for $RemittanceID in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:RemittanceID
                return
                    <ns1:REMITTANCE_ID>{ data($RemittanceID) }</ns1:REMITTANCE_ID>
            }
            {
                for $RemittanceStatus in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:RemittanceStatus
                return
                    <ns1:REMITTANCE_STATUS>{ data($RemittanceStatus) }</ns1:REMITTANCE_STATUS>
            }
            {
                for $RemittanceDescription in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:RemittanceDescription
                return
                    <ns1:REMITTANCE_DESCRIPTION>{ data($RemittanceDescription) }</ns1:REMITTANCE_DESCRIPTION>
            }
            {
                for $Currency in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:Currency
                return
                    <ns1:CURRENCY>{ data($Currency) }</ns1:CURRENCY>
            }
            {
            	for $SenderAmount in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:SenderAmount
            	return
            		<ns1:SENDER_AMOUNT>{ data($SenderAmount) }</ns1:SENDER_AMOUNT>
            }
            {
            	for $ReceiverAmount in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:ReceiverAmount
            	return
            		<ns1:RECEIVER_AMOUNT>{ data($ReceiverAmount) }</ns1:RECEIVER_AMOUNT>
            }
            {
            	for $ExchangeRate in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:ExchangeRate
            	return
            		<ns1:EXCHANGE_RATE>{ data($ExchangeRate) }</ns1:EXCHANGE_RATE>
            }            
            {
                for $SenderInfo in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:SenderInfo
                return
                    <ns1:SENDER_INFO>
                        <ns0:FIRST_NAME>{ data($SenderInfo/ns2:FirstName) }</ns0:FIRST_NAME>
                        <ns0:LAST_NAME>{ data($SenderInfo/ns2:LastName) }</ns0:LAST_NAME>
                        {
                            for $SenderOtherName in $SenderInfo/ns2:OtherName
                            return
                                <ns0:OTHER_NAME>{ data($SenderOtherName) }</ns0:OTHER_NAME>
                        }
                        <ns0:COUNTRY_NAME>{ data($SenderInfo/ns2:CountryName) }</ns0:COUNTRY_NAME>
                    </ns1:SENDER_INFO>
            }
            {
                for $ReceiverInfo in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:ReceiverInfo
                return
                    <ns1:RECEIVER_INFO>
						<ns0:ABANKS_CUSTOMER_EXIST>{ data($ReceiverInfo/ns2:AbanksCustomerExist) }</ns0:ABANKS_CUSTOMER_EXIST>
						<ns0:ABANKS_CUSTOMER_ID>{ data($ReceiverInfo/ns2:AbanksCustomerID) }</ns0:ABANKS_CUSTOMER_ID>                   	                    	                    	                                              
                        {
                            for $IdNumber in $ReceiverInfo/ns2:IdNumber
                            return
                                <ns0:ID_NUMBER>{ data($IdNumber) }</ns0:ID_NUMBER>
                        }
                        {
                            for $FirstName in $ReceiverInfo/ns2:FirstName
                            return
                                <ns0:FIRST_NAME>{ data($FirstName) }</ns0:FIRST_NAME>
                        }
                        {
                            for $LastName in $ReceiverInfo/ns2:LastName
                            return
                                <ns0:LAST_NAME>{ data($LastName) }</ns0:LAST_NAME>
                        }
                        {
                            for $OtherName in $ReceiverInfo/ns2:OtherName
                            return
                                <ns0:OTHER_NAME>{ data($OtherName) }</ns0:OTHER_NAME>
                        }
                    </ns1:RECEIVER_INFO>
            }
            {
            	for $TrxRequiresEspecialIVE in data($queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:TrxRequiresEspecialIVE)
            	return
            		<ns1:TRX_REQUIRES_ESPECIAL_IVE>{$TrxRequiresEspecialIVE}</ns1:TRX_REQUIRES_ESPECIAL_IVE>	
            }
            {
            	for $ResponseCode in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:ResponseCode
            	return
            		<ns1:RESPONSE_CODE>{data($ResponseCode)}</ns1:RESPONSE_CODE>
            }                        
            {
                for $ResponseMessage in $queryRemittanceResponse/ns2:ResponseQueryRemittance/ns2:ResponseMessage
                return
                    <ns1:RESPONSE_MESSAGE>{ data($ResponseMessage) }</ns1:RESPONSE_MESSAGE>
            }
        </ns1:inwardRemitQueryResponse>
};

declare variable $queryRemittanceResponse as element(ns2:QueryRemittanceResponse) external;

xf:inwardRemitQueryGTOut($queryRemittanceResponse)