(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarCobroDiferidoTSP" location="../../../BusinessServices/RegistrarCobroDiferidoTSP/xsd/XMLSchema_-107378753.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarCobroDiferidoTSPTypes";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/registrarCobroDiferidoTSP_In/";

declare function xf:registrarCobroDiferidoTSP_In($t24FTAuthFlow as element(ns2:T24FTAuthFlow),
    $RATE_AMOUNT as xs:string,
    $DEFERRED_PAYMENT_REASON as xs:string)
    as element(ns1:registrarCobroDiferidoTSP) {
        <ns1:registrarCobroDiferidoTSP>
            <TRANSACTION_ID>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_ID>
            <TRANSACTION_TYPE_CODE>{ data($t24FTAuthFlow/ns2:TransStmtEntry) }</TRANSACTION_TYPE_CODE>
            <TRANSACTION_REFERENCE>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_REFERENCE>
            <TRANSACTION_ACCOUNT_NUMBER>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</TRANSACTION_ACCOUNT_NUMBER>
            <TRANSACTION_CUSTOMER_ID>{ data($t24FTAuthFlow/ns2:DebitCustomerNo) }</TRANSACTION_CUSTOMER_ID>
            <TRANSACTION_CURRENCY>{ data($t24FTAuthFlow/ns2:debitCurrency) }</TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24FTAuthFlow/ns2:debitValueDate)) }</TRANSACTION_DATE>
            <TRANSACTION_DEFERRED_PAYMENT_REASON>{ $DEFERRED_PAYMENT_REASON }</TRANSACTION_DEFERRED_PAYMENT_REASON>
            <TRANSACTION_AMOUNT>
                {
                    if (fn:string($t24FTAuthFlow/ns2:creditAmount/text()) != "") then
                        (data($t24FTAuthFlow/ns2:creditAmount))
                    else 
                        data($t24FTAuthFlow/ns2:debitAmount)
                }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_RATE_AMOUNT>{ $RATE_AMOUNT }</TRANSACTION_RATE_AMOUNT>
        </ns1:registrarCobroDiferidoTSP>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;
declare variable $RATE_AMOUNT as xs:string external;
declare variable $DEFERRED_PAYMENT_REASON as xs:string external;

xf:registrarCobroDiferidoTSP_In($t24FTAuthFlow,
    $RATE_AMOUNT,
    $DEFERRED_PAYMENT_REASON)