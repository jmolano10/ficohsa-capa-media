xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$resultGroup" type="xs:anyType" ::)
(:: pragma bea:global-element-parameter parameter="$FlotantesDBOut" element="ns0:OutputParameters" location="../../../BusinessServices/ConsultaFlotanteTC/xsd/consultaAutorizacionesFlotantes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAutorizacionesFlotantesResponse" location="../xsd/consultaAutorizacionesFlotantesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAutorizacionesFlotantes/xq/consultaAutorizacionesFlotantesNIOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaAutorizacionesFlotantesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAutorizacionesFlotantes";
declare namespace ns2 = "http://www.procesa.com/fdcs";

declare function xf:consultaAutorizacionesFlotantesNIOut($resultGroup as element(*),
$FlotantesDBOut as element(ns0:OutputParameters))
    as element(ns1:consultaAutorizacionesFlotantesResponse) {
        <ns1:consultaAutorizacionesFlotantesResponse>
            <AUTHORIZATIONS>
                   {
                      if(not(empty($FlotantesDBOut/ns0:PT_CAF/ns0:ACCOUNT_NUMBER))) then (
	    					 fn-bea:inlinedXML(data($FlotantesDBOut/ns0:PT_CAF/ns0:AUTHORIZATION_ITEMS1))


                      )else(
                        for $nodes in $resultGroup/OUTSTANDING_AUTHORIZATION_INQUIRY_RESPONSES/ns2:OutstandingAuthorizationInquiryResponse
    				return(
    				<AUTHORIZATION>
    					<ORG>{ data($nodes/OFXOAO-ORG) }</ORG>
	    				<CARD_NUMBER>{ data($nodes/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR) }</CARD_NUMBER>
	    				<AUTHORIZATION_ITEMS>
	    					{
	    						for $authorization in $nodes/OutstandingAuthArray/OutstandingAuthData
	    						return(
	    							<AUTHORIZATION_ITEM>
	    								<SEQUENCE_CARD>{ data($authorization/OFXOAO-CARD-SEQ) }</SEQUENCE_CARD>
	    								<CREDIT_PLAN>{ data($authorization/OFXOAO-CREDIT-PLAN) }</CREDIT_PLAN>
	    								<AVAILABLE_PURCHASE>{ data($authorization/OFXOAO-AVAIL-CREDIT) }</AVAILABLE_PURCHASE>
	    								<CASH_AVAILABLE_CREDIT>{ data($authorization/OFXOAO-CASH-AVAIL-CREDIT) }</CASH_AVAILABLE_CREDIT>
	    								<EFFECTIVE_DATE>{ data($authorization/OFXOAO-EFF-DATE) }</EFFECTIVE_DATE>
	    								<TIME>{ data($authorization/OFXOAO-TIME) }</TIME>
	    								<AUTH_AMOUNT>{ data($authorization/OFXOAO-AUTH-AMOUNT) }</AUTH_AMOUNT>
	    								<ACTION>{ data($authorization/OFXOAO-ACTION) }</ACTION>
	    								<ACTION_REASON>{ data($authorization/OFXOAO-ACTION-REASON) }</ACTION_REASON>
	    								<REASON_DESCRIPTION>{ data($authorization/OFXOAO-REASON-DESC) }</REASON_DESCRIPTION>
	    								<REQUEST_TYPE>{ data($authorization/OFXOAO-REQUEST-TYPE) }</REQUEST_TYPE>
	    								<AUTH_TYPE>{ data($authorization/OFXOAO-AUTH-TYPE) }</AUTH_TYPE>
	    								<AUTHORIZATION_CODE>{ data($authorization/OFXOAO-AUTHORIZATION-CODE) }</AUTHORIZATION_CODE>
	    								<MERCH_CAT_CD>{ data($authorization/OFXOAO-MERCH-CAT-CD) }</MERCH_CAT_CD>
	    								<CATEGORY_DESCRIPTION>{ data($authorization/OFXOAO-CATEGORY-DESC) }</CATEGORY_DESCRIPTION>
	    								<NAME_LOCATION_CARD_ACCEPTOR>{ data($authorization/OFXOAO-CRD-ACCPT-NAME-LOC) }</NAME_LOCATION_CARD_ACCEPTOR>
	    								<TRANSACTION_DESCRIPTION>{ data($authorization/OFXOAO-TRANSACTION-DESC) }</TRANSACTION_DESCRIPTION>
	    								<TRANSACTION_ENTRY_MODE>{ data($authorization/OFXOAO-PAN-ENTRY-MODE) }</TRANSACTION_ENTRY_MODE>
	    								<TRANSACTION_ENTRY_DESCRIPTION>{ data($authorization/OFXOAO-PAN-ENTRY-DESCRIPTION) }</TRANSACTION_ENTRY_DESCRIPTION>
	    								<MERCHANT_CODE>{ data($authorization/OFXOAO-MER-CODE) }</MERCHANT_CODE>
	    								<RESPONSE_CODE>{ data($authorization/OFXOAO-B039-RESP-CODE) }</RESPONSE_CODE>
	    								<CURRENCY_CODE>{ data($authorization/OFXOAO-CURR-CODE) }</CURRENCY_CODE>
	    								<CRD_ACCPT_ST_CTRY>{ data($authorization/OFXOAO-CRD-ACCPT-ST-CTRY) }</CRD_ACCPT_ST_CTRY>
	    								<TRANSACTION_SOURCE>{ data($authorization/OFXOAO-TRANS-SOURCE) }</TRANSACTION_SOURCE>
	    								<MERCHANT_CODE_2>{ data($authorization/OFXOAO-MERCH-CODE) }</MERCHANT_CODE_2>
	    								<PROCESSING_CODE>{ data($authorization/OFXOAO-B003-PROC-CODE) }</PROCESSING_CODE>
	    								<TRANSACTION_AMOUNT>{ data($authorization/OFXOAO-B004-TXN-AMT) }</TRANSACTION_AMOUNT>
	    								<TRANSACTION_TIME>{ data($authorization/OFXOAO-AUTH-B012-LCL-TXN-TM) }</TRANSACTION_TIME>
	    								<TRANSACTION_DATE>{ data($authorization/OFXOAO-REF-NBR) }</TRANSACTION_DATE>
	    								<REFERENCE_NUMBER>{ data($authorization/OFXOAO-B013-LCL-TXN-DTE) }</REFERENCE_NUMBER>
	    								<TRANSACTION_CURRENCY>{ data($authorization/OFXOAO-B049-CURR-CODE) }</TRANSACTION_CURRENCY>
	    							</AUTHORIZATION_ITEM>
	    						)
	    					}
	    				</AUTHORIZATION_ITEMS>
        			</AUTHORIZATION>
        			)
                      )  
                   }
            </AUTHORIZATIONS>
        </ns1:consultaAutorizacionesFlotantesResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $FlotantesDBOut as element(ns0:OutputParameters) external;

xf:consultaAutorizacionesFlotantesNIOut($resultGroup,$FlotantesDBOut)