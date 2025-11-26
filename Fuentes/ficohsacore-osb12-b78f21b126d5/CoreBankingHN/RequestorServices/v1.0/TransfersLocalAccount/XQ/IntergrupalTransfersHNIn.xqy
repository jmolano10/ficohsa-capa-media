xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/IntergrupalTransfers/XMLSchema_383322568.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;
declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $auth as xs:string external;
declare variable $transactionType as xs:string external;

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
declare function local:getTxnReference($reference as xs:string)  as xs:string {      
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
declare function local:letter-sequence
  ()  as xs:string* {      
  	 let $number-for-a := string-to-codepoints('A')
	 let $number-for-z := string-to-codepoints('Z')
	 for $letter in ($number-for-a to $number-for-z)
	 return
  	 	codepoints-to-string($letter)
 };
declare function local:begins-with-a-letter
	($word as xs:string)  as xs:boolean {      
		local:letter-sequence() = upper-case(substring($word,1,1))
 };
declare function local:splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), local:splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function local:func($transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::), 
                            $uuid as xs:string, 
                            $user as xs:string, 
                            $password as xs:string, 
                            $auth as xs:string, 
                            $transactionType as xs:string) 
                            as element() (:: schema-element(ns2:TransferenciaIntergrupalInsert) ::) {
    <ns2:TransferenciaIntergrupalInsert>
    <WebRequestCommon>
                <userName>
                {
                        fn-bea:fail-over( local:getUsername(data($user)),
                        data($user))
                }
                </userName>
                <password>
                {
                        fn-bea:fail-over( local:getPassword(data($user)),
                        data($password))
                }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>
                    {
                        if (fn:string($transfersLocalAccountRequest/ns1:InterfaceReferenceNo/text()) = "") then
                            ($uuid)
                        else 
                            fn:string($transfersLocalAccountRequest/ns1:InterfaceReferenceNo/text())
                    }
				</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERINTERTRANSFWSType>
                <TransactionType>{ $transactionType }</TransactionType>
                <DebitAccount>{ data($transfersLocalAccountRequest/ns1:DebitAccount) }</DebitAccount>
                {
                	if (fn:string($transfersLocalAccountRequest/ns1:DebitCredit/text()) = "DEBIT") then 
                		(<DebitCurrency>{ data($transfersLocalAccountRequest/ns1:Currency) }</DebitCurrency>) 
                	else 
                		()
                }
                {
                	if (fn:string($transfersLocalAccountRequest/ns1:DebitCredit/text()) = "DEBIT") then 
                		(<DebitAmount>{ fn:round-half-to-even(xs:decimal(data($transfersLocalAccountRequest/ns1:TransferAmmount)), 2) }</DebitAmount>) 
                	else 
                		()
                }               
                <CreditAccount>{ data($transfersLocalAccountRequest/ns1:CreditAccount) }</CreditAccount>
                {
                	if ($transfersLocalAccountRequest/ns1:DebitCredit/text() = "CREDIT") then 
                		(<CreditCurrency>{ data($transfersLocalAccountRequest/ns1:Currency) }</CreditCurrency>) 
                	else 
                		()
                }
                {
                	if ($transfersLocalAccountRequest/ns1:DebitCredit/text() = "CREDIT") then <CreditAmount>{ fn:round-half-to-even(xs:decimal(data($transfersLocalAccountRequest/ns1:TransferAmmount)), 2) }</CreditAmount> else ()
                }
                <gPAYMENTDETAILS>
                    {
                        if($transfersLocalAccountRequest/ns1:Description)then(
                            for $descripcion in local:splitString(local:getTxnReference(data($transfersLocalAccountRequest/ns1:Description)),34)
                		return
                			if(fn:string($descripcion) != "") then (
                				<Paymentdetails>{concat(fn:string($descripcion), ".")}</Paymentdetails>
                			)else ()
                        )else()
                    }
                    {
                        if($transfersLocalAccountRequest/ns1:TransferDetails)then(
                          for $descripcion in tokenize($transfersLocalAccountRequest/ns1:TransferDetails, '\|\|')
                                return
                		for $descripcionAux in local:splitString(local:getTxnReference(data($descripcion)),34)
                		return
                			if(fn:string($descripcionAux) != "" and not( fn:contains($descripcionAux,'[') and fn:contains($descripcionAux,']') )) then (
                				<PAYMENTDETAILS>{concat(fn:string($descripcionAux), ".")}</PAYMENTDETAILS>
                			) else ()
                        )else()      
                    }
                </gPAYMENTDETAILS>                
                {
                    for $ITEM_LEVEL_1 in $transfersLocalAccountRequest/ns1:ItemLevel1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $transfersLocalAccountRequest/ns1:ItemLevel2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $transfersLocalAccountRequest/ns1:ItemLevel3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $transfersLocalAccountRequest/ns1:ItemLevel4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $transfersLocalAccountRequest/ns1:ItemLevel5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
                {
                	<REFERENCES>{$transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key="T24_IN_OUT"]/*:Value/text()}</REFERENCES>
                }
                {
                	<LRTRNAMEREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos el nombre del remitente.:)
                	 (: En cambio si e senviada (ENV o !REC) especificamos el nobmre del destinatario :)
                		if ($transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key="T24_IN_OUT"]/*:Value/text() = "REC") then
                			fn:replace($transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key = 'ACCOUNT_OWNER']/*:Value/text(), '(\r?\n|\r)$', '')
                		else
                		fn:replace($transfersLocalAccountRequest/ns1:RegionalDetails/*:DESTINATION/*:KV_PAIR[*:Key = 'ACCOUNT_OWNER']/*:Value/text(), '(\r?\n|\r)$', '')
                	}
                	</LRTRNAMEREC>
                }
                {
                	<LRTRACTREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos la cuenta del remitente (de donde se debita):)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la cuenta destinatario (a donde acreditamos) :)
                		if ($transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key="T24_IN_OUT"]/*:Value/text() = "REC") then
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key = 'DEBIT_ACCOUNT']/*:Value/text()
                		else
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:DESTINATION/*:KV_PAIR[*:Key = 'CREDIT_ACCOUNT']/*:Value/text()
                	}               	
                	</LRTRACTREC>
                }
                {
                	<LRTRCURREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos la moneda de la cuenta del remitente (de donde se debita):)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la cuenta destinatario (a donde acreditamos) :)
                		if ($transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key="T24_IN_OUT"]/*:Value/text() = "REC") then
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key = 'DEBIT_ACCOUNT_CURRENCY']/*:Value/text()
                		else
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:DESTINATION/*:KV_PAIR[*:Key = 'CREDIT_CURRENCY']/*:Value/text()
                	}                	
                	</LRTRCURREC>
                }
                {
                	<LRTRAMTREC>
                	{(: Si la transferencia se está recibiendo ('REC'), Entonces especificamos el monto que nos están enviando en moneda de cuenta origen:)
                	 (: En cambio si e senviada (ENV o !REC) especificamos la moneda de la cuenta destino :)
                		if ($transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key="T24_IN_OUT"]/*:Value/text() = "REC") then
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:SOURCE/*:KV_PAIR[*:Key = 'DEBIT_AMOUNT']/*:Value/text()
                		else
                			$transfersLocalAccountRequest/ns1:RegionalDetails/*:DESTINATION/*:KV_PAIR[*:Key = 'CREDIT_AMOUNT']/*:Value/text()
                	}                	
                	</LRTRAMTREC>
                }
            </FUNDSTRANSFERINTERTRANSFWSType>
    </ns2:TransferenciaIntergrupalInsert>
};

local:func($transfersLocalAccountRequest, $uuid, $user, $password, $auth, $transactionType)
