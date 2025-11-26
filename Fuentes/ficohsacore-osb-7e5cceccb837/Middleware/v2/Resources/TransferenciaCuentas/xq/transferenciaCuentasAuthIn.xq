(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transferenciaentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasIn/";

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

declare function xf:transferenciaCuentasIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:Transferenciaentrecuentas) {
        <ns1:Transferenciaentrecuentas>
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
                        if (fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text()) = "") then (
                        	$uuid
                        ) else ( 
                            fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text())
                        )
                    }
				</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <DEBITAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCOUNT>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CREDITACCOUNT>
                <gPAYMENTDETAILS>
                {
                	for $descripcion in splitString(getTxnReference(data($transferenciaCuentasRequest/DESCRIPTION)),34)
                		return
                			if(fn:string($descripcion) != "") then (
                				<PAYMENTDETAILS>{concat(fn:string($descripcion), ".")}</PAYMENTDETAILS>
                			) else ()
                }
                {
                	for $descripcion in tokenize($transferenciaCuentasRequest/TRANSFER_DETAILS, '\|\|')
                		return
                		for $descripcionAux in splitString(getTxnReference(data($descripcion)),34)
                		return
                			if(fn:string($descripcionAux) != "" and not( fn:contains($descripcionAux,'[') and 
                														 fn:contains($descripcionAux,']') )) then (
                				<PAYMENTDETAILS>{concat(fn:string($descripcionAux), ".")}</PAYMENTDETAILS>
                			) else ()        
                }
                </gPAYMENTDETAILS>
                <LRCCARDNO>
                	{
                		if (data($transferenciaCuentasRequest/ADDITIONAL_INFO/KV_PAIR/KEY) = "CREDIT_CARD_NUMBER") then (
                			data($transferenciaCuentasRequest/ADDITIONAL_INFO/KV_PAIR/VALUE)
                		) else (
                			""
                		)
                	}
                </LRCCARDNO>
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
            </FUNDSTRANSFERRETAILSALEWSType>
        </ns1:Transferenciaentrecuentas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:transferenciaCuentasIn($requestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid,
    $auth)