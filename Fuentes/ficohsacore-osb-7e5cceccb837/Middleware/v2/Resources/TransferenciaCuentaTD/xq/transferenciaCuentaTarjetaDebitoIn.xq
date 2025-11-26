(:: pragma bea:global-element-parameter parameter="$transferenciaCuentaTD" element="ns0:transferenciaCuentaTD" location="../xsd/transferenciaCuentaTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaCuentaTarjetaDebito" location="../../../BusinessServices/T24/svcTransferenciasTD/xsd/XMLSchema_-207313410.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaCuentaTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentaTD/xq/transferenciaCuentaTarjetaDebitoIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
 (: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:transferenciaCuentaTarjetaDebitoIn($transferenciaCuentaTD as element(ns0:transferenciaCuentaTD),
    $serviceAccountName as xs:string,
    $cuentaDebitoInternoHNL as xs:string,
    $cuentaDebitoInternoUSD as xs:string,
    $txnTypeCredito as xs:string)
    as element(ns1:TransferenciaCuentaTarjetaDebito) {
        <ns1:TransferenciaCuentaTarjetaDebito>
            <WebRequestCommon>
                <userName>
	                {
	                    fn-bea:fail-over( getUsername($serviceAccountName), $serviceAccountName)
	                }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($serviceAccountName), '')
                    }
				</password>
            </WebRequestCommon>
            	<OfsFunction>
                	<gtsControl/>
                	<messageId/>
                	<noOfAuth/>
                	<replace/>
            	</OfsFunction>
            <FUNDSTRANSFERVISAFASTFUNDSCREDITType>
                <TransactionType>{ $txnTypeCredito }</TransactionType>
                <DebitAcctNo>
                    {
                        let $debitCurrency  := (string($transferenciaCuentaTD/CURRENCY/text()))  
                        return
                            if ($debitCurrency = 'HNL') then(
                            	$cuentaDebitoInternoHNL
                            ) else if ($debitCurrency = 'USD') then (
                            	$cuentaDebitoInternoUSD
                            ) else()
                    }
				</DebitAcctNo>
                <DebitCurrency>{ data($transferenciaCuentaTD/CURRENCY) }</DebitCurrency>
                <DebitAmount>{ fn:string(data($transferenciaCuentaTD/AMOUNT/text())) }</DebitAmount>
                <LRCARDNUMBER>{ data($transferenciaCuentaTD/CARD_NUMBER) }</LRCARDNUMBER>
                <SYSTRACEAUDN>{ data($transferenciaCuentaTD/TERMINAL_REFERENCE) }</SYSTRACEAUDN>
                <RETRIEVALREFN>{ data($transferenciaCuentaTD/RETRIEVAL_REF_NO) }</RETRIEVALREFN>
                <gTRANSACTIONDAT>
                {
                    for $ADDITIONAL_DATA in splitString(data($transferenciaCuentaTD/ADDITIONAL_DATA),65)
                	return
                		if(fn:string($ADDITIONAL_DATA) != "") then (
                    		<TRANSACTIONDAT>{ data($ADDITIONAL_DATA) }</TRANSACTIONDAT>
                    	) else ()
                }
                </gTRANSACTIONDAT>
            </FUNDSTRANSFERVISAFASTFUNDSCREDITType>
        </ns1:TransferenciaCuentaTarjetaDebito>
};

declare variable $transferenciaCuentaTD as element(ns0:transferenciaCuentaTD) external;
declare variable $serviceAccountName as xs:string external;
declare variable $cuentaDebitoInternoHNL as xs:string external;
declare variable $cuentaDebitoInternoUSD as xs:string external;
declare variable $txnTypeCredito as xs:string external;

xf:transferenciaCuentaTarjetaDebitoIn($transferenciaCuentaTD,
    $serviceAccountName,
    $cuentaDebitoInternoHNL,
    $cuentaDebitoInternoUSD,
    $txnTypeCredito)