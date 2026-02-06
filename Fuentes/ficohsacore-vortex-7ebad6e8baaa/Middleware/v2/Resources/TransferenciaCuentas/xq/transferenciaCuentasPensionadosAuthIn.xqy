xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasPensionadosIn/";

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

declare function xf:transferenciaCuentasPensionadosIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
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
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($transferenciaCuentasRequest/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CREDITACCTNO>
                <gPAYMENTDETAILS g = "1">
                    {
                        for $value  in (splitString(data($transferenciaCuentasRequest/DESCRIPTION),34))  
                        return
                            if (fn:string($value) != "") then
                                (<PAYMENTDETAILS>{concat($value, ".")}</PAYMENTDETAILS>)
                            else 
                                ()
                    }
</gPAYMENTDETAILS>
                <PROFITCENTREDEPT>
                    {
                        let $profit  := for $descripcion  in (tokenize($transferenciaCuentasRequest/TRANSFER_DETAILS, '\|\|'))  
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
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:transferenciaCuentasPensionadosIn($requestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid,
    $auth)