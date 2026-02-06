xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$batch" type="ns0:batchType" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/agrupaTxnLoteXCuenta/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";

declare function escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\$1')
 } ;
 
declare function xf:agrupaTxnLoteXCuenta($batch as element())
    as element(*) {
    	<ACCOUNTS>
	    	{
		    	let $amountPos := fn:index-of($batch/DATA_STRUCTURE/FIELDS/FIELD, 'AMOUNT')
		    	let $debitAccountPos := fn:index-of($batch/DATA_STRUCTURE/FIELDS/FIELD, 'DEBIT_ACCOUNT')
		    	let $delimiter := escape-for-regex($batch/DATA_STRUCTURE/DELIMITER)
		    	let $accounts := 
		    		for $transaction in $batch/TRANSACTIONS/TRANSACTION/text()
		    			let $campos := fn:tokenize($transaction, $delimiter)
		    			let $account := $campos[position() = $debitAccountPos]
		    			let $amount := $campos[position() = $amountPos]
		    			return (
		    				<ACCOUNT>
		    					<ACCOUNT_NUMBER>{ $account }</ACCOUNT_NUMBER>
		    					<AMOUNT>{ $amount }</AMOUNT>
		    				</ACCOUNT>
		    			)
		    	for $account in fn:distinct-values($accounts/ACCOUNT_NUMBER/text())
		    	let $short_account := concat(substring($account, 1, 6), xs:long(substring($account, 7))) 
		    	return
		    		<ACCOUNT>
		    			<ACCOUNT_NUMBER>{ $short_account }</ACCOUNT_NUMBER>,
		    			<TOTAL_AMOUNT>{ sum($accounts[ACCOUNT_NUMBER/text() = $account]/AMOUNT/text())}</TOTAL_AMOUNT>
		    		</ACCOUNT>
	        }
	      </ACCOUNTS>
};

declare variable $batch as element() external;

xf:agrupaTxnLoteXCuenta($batch)