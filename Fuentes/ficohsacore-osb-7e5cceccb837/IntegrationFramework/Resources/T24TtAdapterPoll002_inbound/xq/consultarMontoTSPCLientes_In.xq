(:: pragma bea:global-element-parameter parameter="$t24TTAuthFlow1" element="ns2:T24TTAuthFlow" location="../xsd/T24FicoTSPServices-T24TTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMontoTSPCliente" location="../../../BusinessServices/consultaMontoTSPCliente/xsd/XMLSchema_-837550061.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24TTAuthFlow";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24TtAdapterPoll002_inbound/xq/test/";

declare function xf:test($t24TTAuthFlow1 as element(ns2:T24TTAuthFlow))
    as element(ns1:consultaMontoTSPCliente) {
        <ns1:consultaMontoTSPCliente>
            <TRANSACTION_TYPE_CODE>
                { 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:TransStmtEntry)
                    else 
                        data($t24TTAuthFlow1/ns2:transactionCode2)
			    }
			</TRANSACTION_TYPE_CODE>
            <TRANSACTION_ID>{ data($t24TTAuthFlow1/ns2:id) }</TRANSACTION_ID>
            <TRANSACTION_REFERENCE>{ data($t24TTAuthFlow1/ns2:id) }</TRANSACTION_REFERENCE>
            <TRANSACTION_CUSTOMER_ID>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:customer2)
                    else 
                        data($t24TTAuthFlow1/ns2:customer1)
			    }
            </TRANSACTION_CUSTOMER_ID>
            <TRANSACTION_ACCOUNT_NUMBER>
                { 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:account2)
                    else 
                        data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:account1)
			    }
            </TRANSACTION_ACCOUNT_NUMBER>
            <TRANSACTION_AMOUNT>
                { 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        if (fn:string($t24TTAuthFlow1/ns2:currency2/text()) != "HNL") then
		                    if (fn:string($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountFcy1/text()) != "") then
		                        (data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountFcy1))
		                    else 
		                        data($t24TTAuthFlow1/ns2:amountFcy2)
		                else
		                	 if (fn:string($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountLocal1/text()) != "") then
		                        (data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountLocal1))
		                    else 
		                        data($t24TTAuthFlow1/ns2:amountLocal2)
	                else 
	                     if (fn:string($t24TTAuthFlow1/ns2:currency1/text()) != "HNL") then
		                    if (fn:string($t24TTAuthFlow1/ns2:amountFcy2/text()) != "") then
		                        (data($t24TTAuthFlow1/ns2:amountFcy2))
		                    else 
		                        data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountFcy1)
		                else
		                	 if (fn:string($t24TTAuthFlow1/ns2:amountLocal2/text()) != "") then
		                        (data($t24TTAuthFlow1/ns2:amountLocal2))
		                    else 
		                        data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:amountLocal1)   
			     }
			</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>
           		{ 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:currency2)
                    else 
                        data($t24TTAuthFlow1/ns2:currency1) 
			    }
            </TRANSACTION_CURRENCY>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', data($t24TTAuthFlow1/ns2:valueDate1)) }</TRANSACTION_DATE>
            <DESTINATION_CUSTOMER_ID>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:customer1) 
                    else 
                        data($t24TTAuthFlow1/ns2:customer2) 
			    }
            </DESTINATION_CUSTOMER_ID>
            <DESTINATION_ACCOUNT_NUMBER>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:account1Group[1]/ns2:account1) 
                    else 
                        data($t24TTAuthFlow1/ns2:account2) 
			    }
            </DESTINATION_ACCOUNT_NUMBER>
            <DESTINATION_CURRENCY>
            	{ 
					if (fn:string($t24TTAuthFlow1/ns2:tfsReference/text()) = "") then
                        data($t24TTAuthFlow1/ns2:currency1) 
                    else 
                        data($t24TTAuthFlow1/ns2:currency2) 
			    }
            </DESTINATION_CURRENCY>
            <AGREEMENT_ID>{ data($t24TTAuthFlow1/ns2:lrAgClientId) }</AGREEMENT_ID>
        </ns1:consultaMontoTSPCliente>
};

declare variable $t24TTAuthFlow1 as element(ns2:T24TTAuthFlow) external;

xf:test($t24TTAuthFlow1)