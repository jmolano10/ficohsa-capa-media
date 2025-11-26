(:: pragma bea:global-element-parameter parameter="$t24TTAuthFlow" element="ns1:T24TTAuthFlow" location="../xsd/T24FicoTSPServices-T24TTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns2:registrarCobroDiferidoTSP" location="../../../BusinessServices/RegistrarCobroDiferidoTSP/xsd/XMLSchema_-107378753.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registrarCobroDiferidoTSPTypes";
declare namespace ns1 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24TTAuthFlow";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24TtAdapterPoll002_inbound/xq/registrarCobroDiferidoTSP_in/";

declare function xf:registrarCobroDiferidoTSP_in($t24TTAuthFlow as element(ns1:T24TTAuthFlow),
    $RATE_AMOUNT as xs:string,
    $DEFERRED_PAYMENT_REASON as xs:string)
    as element(ns2:registrarCobroDiferidoTSP) {
        <ns2:registrarCobroDiferidoTSP>
            <TRANSACTION_ID>{ data($t24TTAuthFlow/ns1:id) }</TRANSACTION_ID>
            <TRANSACTION_TYPE_CODE>
                { 
					if (fn:string($t24TTAuthFlow/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow/ns1:TransStmtEntry)
                    else 
                        data($t24TTAuthFlow/ns1:transactionCode2)
			    }
			</TRANSACTION_TYPE_CODE>
            <TRANSACTION_REFERENCE>{ data($t24TTAuthFlow/ns1:id) }</TRANSACTION_REFERENCE>
            <TRANSACTION_ACCOUNT_NUMBER>
            	{ 
					if (fn:string($t24TTAuthFlow/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow/ns1:account2)
                    else 
                        data($t24TTAuthFlow/ns1:account1Group[1]/ns1:account1)
			    }
            </TRANSACTION_ACCOUNT_NUMBER>
            <TRANSACTION_CUSTOMER_ID>
            	{ 
					if (fn:string($t24TTAuthFlow/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow/ns1:customer2)
                    else 
                        data($t24TTAuthFlow/ns1:customer1)
			    }
            </TRANSACTION_CUSTOMER_ID>
            <TRANSACTION_CURRENCY>
            	{ 
					if (fn:string($t24TTAuthFlow/ns1:tfsReference/text()) = "") then
                        data($t24TTAuthFlow/ns1:currency2)
                    else 
                        data($t24TTAuthFlow/ns1:currency1)
			    }
            </TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24TTAuthFlow/ns1:valueDate1)) }</TRANSACTION_DATE>
            <TRANSACTION_DEFERRED_PAYMENT_REASON>{ $DEFERRED_PAYMENT_REASON }</TRANSACTION_DEFERRED_PAYMENT_REASON>
            <TRANSACTION_AMOUNT>
            	{ 
					if (fn:string($t24TTAuthFlow/ns1:tfsReference/text()) = "") then
                       if (fn:string($t24TTAuthFlow/ns1:currency2/text()) != "HNL") then
	                        if (fn:string($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountFcy1/text()) != "") then
	                            (data($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountFcy1))
	                        else 
	                            data($t24TTAuthFlow/ns1:amountFcy2)
	                    else 
	                        if (fn:string($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountLocal1/text()) != "") then
	                            (data($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountLocal1))
	                        else 
	                            data($t24TTAuthFlow/ns1:amountLocal2) 	
                        
                        
                    else 
                        if (fn:string($t24TTAuthFlow/ns1:currency1/text()) != "HNL") then
	                        if (fn:string($t24TTAuthFlow/ns1:amountFcy2/text()) != "") then
	                            data($t24TTAuthFlow/ns1:amountFcy2)
	                        else 
	                            data($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountFcy1)
	                    else 
	                        if (fn:string($t24TTAuthFlow/ns1:amountLocal2/text()) != "") then
	                            data($t24TTAuthFlow/ns1:amountLocal2)
	                        else 
	                            data($t24TTAuthFlow/ns1:account1Group[1]/ns1:amountLocal1)
			    }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_RATE_AMOUNT>{ $RATE_AMOUNT }</TRANSACTION_RATE_AMOUNT>
        </ns2:registrarCobroDiferidoTSP>
};

declare variable $t24TTAuthFlow as element(ns1:T24TTAuthFlow) external;
declare variable $RATE_AMOUNT as xs:string external;
declare variable $DEFERRED_PAYMENT_REASON as xs:string external;

xf:registrarCobroDiferidoTSP_in($t24TTAuthFlow,
    $RATE_AMOUNT,
    $DEFERRED_PAYMENT_REASON)