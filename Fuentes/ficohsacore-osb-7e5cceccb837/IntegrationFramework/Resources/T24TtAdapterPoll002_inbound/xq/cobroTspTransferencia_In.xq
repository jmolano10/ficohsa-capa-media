(:: pragma bea:global-element-parameter parameter="$t24TTAuthFlow1" element="ns1:T24TTAuthFlow" location="../xsd/T24FicoTSPServices-T24TTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns2:cobroTSPTransferencia" location="../../../BusinessServices/CobroTSPTransferencia/xsd/XMLSchema_-520411437.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cobroTSPTransferenciaTypes";
declare namespace ns1 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24TTAuthFlow";
declare namespace xf = "http://tempuri.org/IntegrationFramework/cobroTspTransferencia_In/";

declare function xf:cobroTspTransferencia_In($t24TTAuthFlow1 as element(ns1:T24TTAuthFlow),
    $PROFIT_CENTRE as xs:string,
    $CHANNEL_IDENTIFICATOR as xs:string,
    $RATE_AMOUNT as xs:string,
    $PROCESS_TYPE as xs:string,
    $RATE_CREDIT_ACCOUNT as xs:string)
    as element(ns2:cobroTSPTransferencia) {
        <ns2:cobroTSPTransferencia>
            <TRANSACTION_TYPE_CODE>
                { 
					if (fn:string($t24TTAuthFlow1/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns1:TransStmtEntry)
                    else 
                        data($t24TTAuthFlow1/ns1:transactionCode2)
			    }
			</TRANSACTION_TYPE_CODE>
            <TRANSACTION_ID>{ data($t24TTAuthFlow1/ns1:id) }</TRANSACTION_ID>
            <CUSTOMER_ID>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns1:customer2)
                    else 
                        data($t24TTAuthFlow1/ns1:customer1)
			    }
            </CUSTOMER_ID>
            <TRANSACTION_AMOUNT>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns1:tfsReference/text()) = "") then
                        
                        if (fn:string($t24TTAuthFlow1/ns1:currency2/text()) != "HNL") then
	                        if (fn:string($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountFcy1/text()) != "") then
	                            data($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountFcy1)
	                        else 
	                            data($t24TTAuthFlow1/ns1:amountFcy2)
	                    else 
	                        if (fn:string($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountLocal1/text()) != "") then
	                            data($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountLocal1)
	                        else 
	                            data($t24TTAuthFlow1/ns1:amountLocal2)
                        
                    else
                     
                        if (fn:string($t24TTAuthFlow1/ns1:currency1/text()) != "HNL") then
	                        if (fn:string($t24TTAuthFlow1/ns1:amountFcy2/text()) != "") then
	                            data($t24TTAuthFlow1/ns1:amountFcy2)
	                        else 
	                            data($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountFcy1)
	                    else 
	                        if (fn:string($t24TTAuthFlow1/ns1:amountLocal2/text()) != "") then
	                            data($t24TTAuthFlow1/ns1:amountLocal2)
	                        else 
	                            data($t24TTAuthFlow1/ns1:account1Group[1]/ns1:amountLocal1)
			    }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns1:currency2) 
                    else 
                        data($t24TTAuthFlow1/ns1:currency1) 
			    }
            </TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24TTAuthFlow1/ns1:valueDate1)) }</TRANSACTION_DATE>
            <TRANSACTION_REFERENCE>{ data($t24TTAuthFlow1/ns1:id) }</TRANSACTION_REFERENCE>
            <DEBIT_ACCOUNT>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns1:account2)
                    else 
                        data($t24TTAuthFlow1/ns1:account1Group[1]/ns1:account1) 
			    }
            </DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $RATE_CREDIT_ACCOUNT }</CREDIT_ACCOUNT>
            <PROFIT_CENTRE>{ $PROFIT_CENTRE }</PROFIT_CENTRE>
            <CHANNEL_IDENTIFICATOR>{ $CHANNEL_IDENTIFICATOR }</CHANNEL_IDENTIFICATOR>
            <RATE_AMOUNT>{ $RATE_AMOUNT }</RATE_AMOUNT>
            <PROCESS_TYPE>{ $PROCESS_TYPE }</PROCESS_TYPE>
        </ns2:cobroTSPTransferencia>
};

declare variable $t24TTAuthFlow1 as element(ns1:T24TTAuthFlow) external;
declare variable $PROFIT_CENTRE as xs:string external;
declare variable $CHANNEL_IDENTIFICATOR as xs:string external;
declare variable $RATE_AMOUNT as xs:string external;
declare variable $PROCESS_TYPE as xs:string external;
declare variable $RATE_CREDIT_ACCOUNT as xs:string external;

xf:cobroTspTransferencia_In($t24TTAuthFlow1,
    $PROFIT_CENTRE,
    $CHANNEL_IDENTIFICATOR,
    $RATE_AMOUNT,
    $PROCESS_TYPE,
    $RATE_CREDIT_ACCOUNT)