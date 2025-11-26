xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/LocalTransfer/XMLSchema_1836213454.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $auth as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $tranfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;

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

declare function local:func($uuid as xs:string, 
                            $user as xs:string, 
                            $password as xs:string, 
                            $auth as xs:string, 
                            $transactionType as xs:string, 
                            $tranfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::)) 
                            as element() (:: schema-element(ns2:Transferenciaentrecuentas) ::) {
    <ns2:Transferenciaentrecuentas>
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
                        if (fn:string($tranfersLocalAccountRequest/ns1:InterfaceReferenceNo/text()) = "") then (
                        	$uuid
                        ) else ( 
                            fn:string($tranfersLocalAccountRequest/ns1:InterfaceReferenceNo/text())
                        )
                    }
				</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($tranfersLocalAccountRequest/ns1:DebitAccount) }</DEBITACCOUNT>
                <DEBITAMOUNT>{ data($tranfersLocalAccountRequest/ns1:TransferAmmount) }</DEBITAMOUNT>
                <CREDITACCOUNT>{ data($tranfersLocalAccountRequest/ns1:CreditAccount) }</CREDITACCOUNT>
                <gPAYMENTDETAILS>
                {
                        if($tranfersLocalAccountRequest/ns1:Description)then(
                            for $descripcion in local:splitString(local:getTxnReference(data($tranfersLocalAccountRequest/ns1:Description)),34)
                		return
                			if(fn:string($descripcion) != "") then (
                				<PAYMENTDETAILS>{concat(fn:string($descripcion), ".")}</PAYMENTDETAILS>
                			)else ()
                        )else()
                }
                {
                        if($tranfersLocalAccountRequest/ns1:TransferDetails)then(
                          for $descripcion in tokenize($tranfersLocalAccountRequest/ns1:TransferDetails, '\|\|')
                		return
                		for $descripcionAux in local:splitString(local:getTxnReference(data($descripcion)),34)
                		return
                			if(fn:string($descripcionAux) != "" and not( fn:contains($descripcionAux,'[') and fn:contains($descripcionAux,']') )) then (
                				<PAYMENTDETAILS>{concat(fn:string($descripcionAux), ".")}</PAYMENTDETAILS>
                			) else ()
                        )else()                
                }
                </gPAYMENTDETAILS>
                <LRCCARDNO>
                	{
                		if (data($tranfersLocalAccountRequest/ns1:AdditionalInfo/*:KV_PAIR/*:Key) = "CREDIT_CARD_NUMBER") then (
                			data($tranfersLocalAccountRequest/ns1:AdditionalInfo/*:KV_PAIR/*:Value)
                		) else (
                			""
                		)
                	}
                </LRCCARDNO>
                {
                    for $ITEM_LEVEL_1 in $tranfersLocalAccountRequest/ns1:ItemLevel1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $tranfersLocalAccountRequest/ns1:ItemLevel2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $tranfersLocalAccountRequest/ns1:ItemLevel3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $tranfersLocalAccountRequest/ns1:ItemLevel4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $tranfersLocalAccountRequest/ns1:ItemLevel5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
            </FUNDSTRANSFERRETAILSALEWSType>
    </ns2:Transferenciaentrecuentas>
};

local:func($uuid, $user, $password, $auth, $transactionType, $tranfersLocalAccountRequest)