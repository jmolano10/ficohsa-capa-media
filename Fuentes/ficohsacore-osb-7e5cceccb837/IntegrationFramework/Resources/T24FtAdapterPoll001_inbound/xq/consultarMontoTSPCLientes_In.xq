(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMontoTSPCliente" location="../../../BusinessServices/consultaMontoTSPCliente/xsd/XMLSchema_-837550061.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/consultarMontoTSPCLientes_In/";

declare function xf:consultarMontoTSPCLientes_In($t24FTAuthFlow as element(ns2:T24FTAuthFlow))
    as element(ns1:consultaMontoTSPCliente) {
        <ns1:consultaMontoTSPCliente>
            <TRANSACTION_TYPE_CODE>{ data($t24FTAuthFlow/ns2:TransStmtEntry) }</TRANSACTION_TYPE_CODE>
            <TRANSACTION_ID>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_ID>
            <TRANSACTION_REFERENCE>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_REFERENCE>
            <TRANSACTION_CUSTOMER_ID>{ data($t24FTAuthFlow/ns2:DebitCustomerNo) }</TRANSACTION_CUSTOMER_ID>
            <TRANSACTION_ACCOUNT_NUMBER>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</TRANSACTION_ACCOUNT_NUMBER>
            <TRANSACTION_AMOUNT>
                {
                    if (fn:string($t24FTAuthFlow/ns2:debitAmount/text()) != "") then
                        (data($t24FTAuthFlow/ns2:debitAmount))
                    else 
                        data($t24FTAuthFlow/ns2:creditAmount)
                }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>{ data($t24FTAuthFlow/ns2:debitCurrency) }</TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24FTAuthFlow/ns2:debitValueDate)) }</TRANSACTION_DATE>
            <DESTINATION_CUSTOMER_ID>{ data($t24FTAuthFlow/ns2:CreditCustomerNo) }</DESTINATION_CUSTOMER_ID>
            <DESTINATION_ACCOUNT_NUMBER>
            	{ 
            		if ( fn:string($t24FTAuthFlow/ns2:TransStmtEntry) = "940" or fn:string($t24FTAuthFlow/ns2:TransStmtEntry) = "196") then
            			data($t24FTAuthFlow/ns2:lrBenPayAcct)
            		else
            			data($t24FTAuthFlow/ns2:creditAcctNo)
            	}
            </DESTINATION_ACCOUNT_NUMBER>
            <DESTINATION_CURRENCY>{ data($t24FTAuthFlow/ns2:creditCurrency) }</DESTINATION_CURRENCY>
            <AGREEMENT_ID>{ data($t24FTAuthFlow/ns2:lrAgClientId) }</AGREEMENT_ID>
        </ns1:consultaMontoTSPCliente>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;

xf:consultarMontoTSPCLientes_In($t24FTAuthFlow)