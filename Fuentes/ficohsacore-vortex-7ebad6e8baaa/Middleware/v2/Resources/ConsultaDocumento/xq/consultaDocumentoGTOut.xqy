xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDocumento/xsd/consultaDocumento_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDocumentoResponse" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDocumento";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDocumento/xq/consultaDocumentoGTOut/";

declare function xf:consultaDocumentoGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaDocumentoResponse) {
        <ns0:consultaDocumentoResponse>
        {
        	let $ptBranch  			:= $outputParameters/ns1:PT_BRANCH/ns1:ITEM
        	let $ptJournal 			:= $outputParameters/ns1:PT_JOURNAL/ns1:ITEM
        	let $ptTeller 			:= $outputParameters/ns1:PT_TELLER/ns1:ITEM
        	let $ptType 			:= $outputParameters/ns1:PT_TYPE/ns1:ITEM
        	let $ptCurrency 		:= $outputParameters/ns1:PT_CURRENCY/ns1:ITEM
        	let $ptDate 			:= $outputParameters/ns1:PT_DATE/ns1:ITEM
        	let $ptTransactionId 	:= $outputParameters/ns1:PT_TRANSACTID/ns1:ITEM
        	let $ptAccount 			:= $outputParameters/ns1:PT_ACCOUNT/ns1:ITEM
        	let $ptCheckNumber 		:= $outputParameters/ns1:PT_CHECKNUMBER/ns1:ITEM
        	let $ptAmount 			:= $outputParameters/ns1:PT_AMOUNT/ns1:ITEM
        	let $ptServiceType 		:= $outputParameters/ns1:PT_SERVICETYPE/ns1:ITEM
        	let $ptTxnId 			:= $outputParameters/ns1:PT_TXNID/ns1:ITEM
        	let $ptTransactionCode 	:= $outputParameters/ns1:PT_TRANSACTCODE/ns1:ITEM
        	let $count     			:= count($ptBranch)
        	return
        	if($count > 0) then (
        		<DOCUMENTS>
        			{
        				for $index in (1 to $count)
        				return(
        					<DOCUMENT>
        						{
        							for $BRANCH in $ptBranch[$index]
        							return
        							if(string($BRANCH/text()) != "")then(
        								<BRANCH>{ data($BRANCH) }</BRANCH>
        							)else()
        						}
        						{
        							for $JOURNAL in $ptJournal[$index]
        							return
        							if(string($JOURNAL/text()) != "")then(
        								<JOURNAL>{ data($JOURNAL) }</JOURNAL>
        							)else()
        						}
        						{
        							for $TELLER in $ptTeller[$index]
        							return
        							if(string($TELLER/text()) != "")then(
        								<TELLER>{ data($TELLER) }</TELLER>
        							)else()
        						}
        						{
        							for $TYPE in $ptType[$index]
        							return
        							if(string($TYPE/text()) != "")then(
        								<TYPE>{ data($TYPE) }</TYPE>
        							)else()
        						}
        						{
        							for $CURRENCY in $ptCurrency[$index]
        							return
        							if(string($CURRENCY/text()) != "")then(
        								<CURRENCY>{ data($CURRENCY) }</CURRENCY>
        							)else()
        						}
        						{
        							for $DATE in $ptDate[$index]
        							return
        							if(string($DATE/text()) != "")then(
        								<DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($DATE))) }</DATE>
        							)else()
        						}
        						{
        							for $TRANSACTION_ID in $ptTransactionId[$index]
        							return
        							if(string($TRANSACTION_ID/text()) != "")then(
        								<TRANSACTION_ID>{ data($TRANSACTION_ID) }</TRANSACTION_ID>
        							)else()
        						}
        						{
        							for $ACCOUNT in $ptAccount[$index]
        							return
        							if(string($ACCOUNT/text()) != "")then(
        								<ACCOUNT>{ data($ACCOUNT) }</ACCOUNT>
        							)else()
        						}
        						{
        							for $CHECK_NUMBER in $ptCheckNumber[$index]
        							return
        							if(string($CHECK_NUMBER/text()) != "")then(
        								<CHECK_NUMBER>{ data($CHECK_NUMBER) }</CHECK_NUMBER>
        							)else()
        						}
        						{
        							for $AMOUNT in $ptAmount[$index]
        							return
        							if(string($AMOUNT/text()) != "")then(
        								<AMOUNT>{ data($AMOUNT) }</AMOUNT>
        							)else()
        						}
        						{
        							for $SERVICE_TYPE in $ptServiceType[$index]
        							return
        							if(string($SERVICE_TYPE/text()) != "")then(
        								<SERVICE_TYPE>{ data($SERVICE_TYPE) }</SERVICE_TYPE>
        							)else()
        						}
        						{
        							for $TXN_ID in $ptTxnId[$index]
        							return
        							if(string($TXN_ID/text()) != "")then(
        								<TXN_ID>{ data($TXN_ID) }</TXN_ID>
        							)else()
        						}
        						{
        							for $TRANSACTION_CODE in $ptTransactionCode[$index]
        							return
        							if(string($TRANSACTION_CODE/text()) != "")then(
        								<TRANSACTION_CODE>{ data($TRANSACTION_CODE) }</TRANSACTION_CODE>
        							)else()
        						}
        					</DOCUMENT>
        				)
        			}
        		</DOCUMENTS>
        	)else()
        }
        </ns0:consultaDocumentoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaDocumentoGTOut($outputParameters)