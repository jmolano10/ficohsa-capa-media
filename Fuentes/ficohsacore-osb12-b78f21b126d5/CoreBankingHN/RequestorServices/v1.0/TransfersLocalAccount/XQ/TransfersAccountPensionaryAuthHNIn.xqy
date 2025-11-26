xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/LocalTransfer/XMLSchema_1836213454.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $auth as xs:string external;
declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;


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
                            $transactionType as xs:string, 
                            $auth as xs:string, 
                            $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::)) 
                            as element() (:: schema-element(ns2:Transfmodelbankentrecuentas) ::) {
        <ns2:Transfmodelbankentrecuentas>
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
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ data($transfersLocalAccountRequest/ns1:DebitAccount) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($transfersLocalAccountRequest/ns1:Currency) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($transfersLocalAccountRequest/ns1:TransferAmmount) }</DEBITAMOUNT>
                <CREDITACCTNO>{ data($transfersLocalAccountRequest/ns1:CreditAccount) }</CREDITACCTNO>
                <gPAYMENTDETAILS g = "1">
                    {
                      if($transfersLocalAccountRequest/ns1:Description)then(
                        for $value  in (local:splitString(data($transfersLocalAccountRequest/ns1:Description),34))  
                        return
                            if (fn:string($value) != "") then(
                                (<PAYMENTDETAILS>{concat($value, ".")}</PAYMENTDETAILS>)
                            )else() 
                     )else()           
                    }
                </gPAYMENTDETAILS>
                <PROFITCENTREDEPT>
                    {
                        let $profit  := for $descripcion  in (tokenize($transfersLocalAccountRequest/ns1:TransferDetails, '\|\|'))  
                            return
                                if ((fn:string($descripcion) != "" and not( fn:contains($descripcion,'[') and
                                    fn:contains($descripcion,']') ))) then
                                    ($descripcion)
                                else 
                                    ()
                              
                        return
                            (string-join($profit,""))
                    }
				</PROFITCENTREDEPT>
				<LRCCARDNO>
                	{
                		if (data($transfersLocalAccountRequest/ns1:AdditionalInfo/*:KV_PAIR/*:Key) = "CREDIT_CARD_NUMBER") then (
                			data($transfersLocalAccountRequest/ns1:AdditionalInfo/*:KV_PAIR/*:Value)
                		) else (
                			""
                		)
                	}
                </LRCCARDNO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
    </ns2:Transfmodelbankentrecuentas>
};

local:func($uuid, $user, $password, $transactionType, $auth, $transfersLocalAccountRequest)