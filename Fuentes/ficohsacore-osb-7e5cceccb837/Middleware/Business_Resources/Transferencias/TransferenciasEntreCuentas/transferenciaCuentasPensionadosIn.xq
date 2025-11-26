(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns1:transferenciaCuentasRequest" location="transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transfmodelbankentrecuentas" location="../Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasPensionadosIn/";

(: Función encargada de realizar el mapeo de usuario :)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña :)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

(: Se encarga de devolver una secuencia de las letras :)
declare function letter-sequence
  ()  as xs:string* {      
  	 let $number-for-a := string-to-codepoints('A')
	 let $number-for-z := string-to-codepoints('Z')
	 for $letter in ($number-for-a to $number-for-z)
	 return
  	 	codepoints-to-string($letter)
 };

(: Se encarga de validar si la primera posicion de la entrada es una letra :)
declare function begins-with-a-letter
	($word as xs:string)  as xs:boolean {      
		letter-sequence() = upper-case(substring($word,1,1))
 };

(: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:transferenciaCuentasPensionadosIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string)
    as element(ns0:Transfmodelbankentrecuentas) {
        <ns0:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
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
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($transferenciaCuentasRequest/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CREDITACCTNO>
                {
                	if(begins-with-a-letter(data($transferenciaCuentasRequest/DEBIT_ACCOUNT)))then(
                		<gORDERINGCUST g = "1">
                      		<ORDERINGCUST>999999</ORDERINGCUST>
                    	</gORDERINGCUST>
                	)
                	else()
                } 
                <gPAYMENTDETAILS g = "1">
                    {
                		for $value in splitString(data($transferenciaCuentasRequest/DESCRIPTION),34)
                		return
                			if(fn:string($value) != "") then (
                				<PAYMENTDETAILS>{concat($value, ".")}</PAYMENTDETAILS>
                			) else ()
                    }
                </gPAYMENTDETAILS>
                <PROFITCENTREDEPT>                    
	                {
	                	let $profit :=
	                        for $descripcion in tokenize($transferenciaCuentasRequest/TRANSFER_DETAILS, '\|\|')
	                		return
	                		if(fn:string($descripcion) != "" and not( fn:contains($descripcion,'[') and 
	                														 fn:contains($descripcion,']') )) then (
	                				$descripcion
	                		) else ()
	                	return string-join($profit,"")
	                }
                </PROFITCENTREDEPT>                               
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns0:Transfmodelbankentrecuentas>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaCuentasPensionadosIn($autenticacionRequestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid)