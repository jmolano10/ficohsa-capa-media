(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cobroTSPTransferencia" location="../../../BusinessServices/CobroTSPTransferencia/xsd/XMLSchema_-520411437.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobroTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/cobroTspTransferencia_In/";

declare function xf:cobroTspTransferencia_In($t24FTAuthFlow as element(ns2:T24FTAuthFlow),
    $PROFIT_CENTRE as xs:string,
    $CHANNEL_IDENTIFICATOR as xs:string,
    $RATE_AMOUNT as xs:string,
    $PROCESS_TYPE as xs:string,
    $RATE_CREDIT_ACCOUNT as xs:string)
    as element(ns1:cobroTSPTransferencia) {
        <ns1:cobroTSPTransferencia>
            <TRANSACTION_TYPE_CODE>{ data($t24FTAuthFlow/ns2:TransStmtEntry) }</TRANSACTION_TYPE_CODE>
            <TRANSACTION_ID>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_ID>
            <CUSTOMER_ID>{ data($t24FTAuthFlow/ns2:DebitCustomerNo) }</CUSTOMER_ID>
            <TRANSACTION_AMOUNT>
                {
                    if (fn:string($t24FTAuthFlow/ns2:creditAmount/text()) != "") then
                        (data($t24FTAuthFlow/ns2:creditAmount))
                    else 
                        data($t24FTAuthFlow/ns2:debitAmount)
                }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>{ data($t24FTAuthFlow/ns2:debitCurrency) }</TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24FTAuthFlow/ns2:debitValueDate)) }</TRANSACTION_DATE>
            <TRANSACTION_REFERENCE>{ data($t24FTAuthFlow/ns2:id) }</TRANSACTION_REFERENCE>
            <DEBIT_ACCOUNT>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $RATE_CREDIT_ACCOUNT }</CREDIT_ACCOUNT>
            <PROFIT_CENTRE>{ $PROFIT_CENTRE }</PROFIT_CENTRE>
            <CHANNEL_IDENTIFICATOR>{ $CHANNEL_IDENTIFICATOR }</CHANNEL_IDENTIFICATOR>
            <RATE_AMOUNT>{ $RATE_AMOUNT }</RATE_AMOUNT>
            <PROCESS_TYPE>{ $PROCESS_TYPE }</PROCESS_TYPE>
        </ns1:cobroTSPTransferencia>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;
declare variable $PROFIT_CENTRE as xs:string external;
declare variable $CHANNEL_IDENTIFICATOR as xs:string external;
declare variable $RATE_AMOUNT as xs:string external;
declare variable $PROCESS_TYPE as xs:string external;
declare variable $RATE_CREDIT_ACCOUNT as xs:string external;

xf:cobroTspTransferencia_In($t24FTAuthFlow,
    $PROFIT_CENTRE,
    $CHANNEL_IDENTIFICATOR,
    $RATE_AMOUNT,
    $PROCESS_TYPE,
    $RATE_CREDIT_ACCOUNT)