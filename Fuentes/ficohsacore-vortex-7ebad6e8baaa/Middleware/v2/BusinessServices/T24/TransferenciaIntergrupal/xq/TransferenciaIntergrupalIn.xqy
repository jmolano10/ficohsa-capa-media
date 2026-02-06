xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../../../../Resources/TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaIntergrupalInsert" location="../xsd/TransferenciaIntergrupalTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/TransferenciaIntergrupalIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/kvpType";

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
declare function getTxnReference($reference as xs:string)  as xs:string {      
		 let $refList := fn:tokenize($reference,"-")
		 let $Text:= fn:substring-after($reference,"-")
		 let $Count:=fn:count($refList)
		 let $CountCadenaDeudor:=string-length($Text)-string-length($refList[$Count])
		 let $Text2:=fn:substring($Text,1,fn:number($CountCadenaDeudor)-1)
		 let $CodigoDeudor:=fn:replace($Text2,"-","..")
		 let $NombreDeudor:=fn:replace(fn:substring-after($Text,$Text2),"-","")
		 let $NumeroTransaccion:=fn:concat(fn:string($refList[1]),"-",$CodigoDeudor,"-",$NombreDeudor)
		 return
		 if ($refList[1] ="DRF") then 
		     $NumeroTransaccion
		 else
		     $reference		 
 };
declare function letter-sequence
  ()  as xs:string* {      
  	 let $number-for-a := string-to-codepoints('A')
	 let $number-for-z := string-to-codepoints('Z')
	 for $letter in ($number-for-a to $number-for-z)
	 return
  	 	codepoints-to-string($letter)
 };
declare function begins-with-a-letter
	($word as xs:string)  as xs:boolean {      
		letter-sequence() = upper-case(substring($word,1,1))
 };
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:TransferenciaIntergrupalIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:TransferenciaIntergrupalInsert) {
        <ns1:TransferenciaIntergrupalInsert>
            <WebRequestCommon>
                <userName>
                {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                }
                </userName>
                <password>
                {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>
                    {
                        if (fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text()) = "") then
                            ($uuid)
                        else 
                            fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text())
                    }
				</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERINTERTRANSFWSType>
                <TransactionType>{ $transactionType }</TransactionType>
                <DebitAccount>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DebitAccount>
                {
                	if ($transferenciaCuentasRequest/DEBIT_CREDIT/text() = "DEBIT") then 
                		(<DebitCurrency>{ data($transferenciaCuentasRequest/CURRENCY) }</DebitCurrency>) 
                	else 
                		()
                }
                {
                	if ($transferenciaCuentasRequest/DEBIT_CREDIT/text() = "DEBIT") then 
                		(<DebitAmount>{ fn:round-half-to-even(data($transferenciaCuentasRequest/TRANSFER_AMOUNT), 2) }</DebitAmount>) 
                	else 
                		()
                }               
                <CreditAccount>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CreditAccount>
                {
                	if ($transferenciaCuentasRequest/DEBIT_CREDIT/text() = "CREDIT") then 
                		(<CreditCurrency>{ data($transferenciaCuentasRequest/CURRENCY) }</CreditCurrency>) 
                	else 
                		()
                }
                {
                	if ($transferenciaCuentasRequest/DEBIT_CREDIT/text() = "CREDIT") then <CreditAmount>{ fn:round-half-to-even(data($transferenciaCuentasRequest/TRANSFER_AMOUNT), 2) }</CreditAmount> else ()
                }
                <gPAYMENTDETAILS>
                    {
	                    for $descripcion in splitString(getTxnReference(fn:string($transferenciaCuentasRequest/DESCRIPTION/text())),34)
	                		return
	                			if(fn:string($descripcion) != "") then (
	                				<Paymentdetails>{concat(fn:string($descripcion), ".")}</Paymentdetails>
	                			) else ()
                    }
                    {
	                	for $descripcion in tokenize($transferenciaCuentasRequest/TRANSFER_DETAILS, '\|\|')
	                		return
	                		for $descripcionAux in splitString(getTxnReference(data($descripcion)),34)
	                		return
	                			if(fn:string($descripcionAux) != "" and not( fn:contains($descripcionAux,'[') and 
	                														 fn:contains($descripcionAux,']') )) then (
	                				<Paymentdetails>{concat(fn:string($descripcionAux), ".")}</Paymentdetails>
	                			) else ()        
                	}
                </gPAYMENTDETAILS>                
                {
                    for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $transferenciaCuentasRequest/ITEM_LEVEL_3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $transferenciaCuentasRequest/ITEM_LEVEL_4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $transferenciaCuentasRequest/ITEM_LEVEL_5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
                {
                	<REFERENCES>{$transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="T24_IN_OUT"]/VALUE/text()}</REFERENCES>
                }
                {
                	<LRTRNAMEREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos el nombre del remitente.:)
                	 (: En cambio si e senviada (ENV o !REC) especificamos el nobmre del destinatario :)
                		if ($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="T24_IN_OUT"]/VALUE/text() = "REC") then
                			fn:replace($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE/text(), '(\r?\n|\r)$', '')
                		else
                		fn:replace($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE/text(), '(\r?\n|\r)$', '')
                	}
                	</LRTRNAMEREC>
                }
                {
                	<LRTRACTREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos la cuenta del remitente (de donde se debita):)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la cuenta destinatario (a donde acreditamos) :)
                		if ($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="T24_IN_OUT"]/VALUE/text() = "REC") then
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT']/VALUE/text()
                		else
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_ACCOUNT']/VALUE/text()
                	}               	
                	</LRTRACTREC>
                }
                {
                	<LRTRCURREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos la moneda de la cuenta del remitente (de donde se debita):)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la cuenta destinatario (a donde acreditamos) :)
                		if ($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="T24_IN_OUT"]/VALUE/text() = "REC") then
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT_CURRENCY']/VALUE/text()
                		else
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_CURRENCY']/VALUE/text()
                	}                	
                	</LRTRCURREC>
                }
                {
                	<LRTRAMTREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos el monto que nos están enviando en moneda de cuenta origen:)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la moneda de la cuenta destino :)
                		if ($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="T24_IN_OUT"]/VALUE/text() = "REC") then
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_AMOUNT']/VALUE/text()
                		else
                			$transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_AMOUNT']/VALUE/text()
                	}                	
                	</LRTRAMTREC>
                }
            </FUNDSTRANSFERINTERTRANSFWSType>
        </ns1:TransferenciaIntergrupalInsert>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:TransferenciaIntergrupalIn($requestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid,
    $auth)