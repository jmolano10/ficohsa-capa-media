(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns1:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TransferenciaInternacional" location="../../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transferenciaInternacionalIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
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

declare function xf:transferenciaInternacionalIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transaccionSubasta as element(ns1:transaccionSubasta),
    $creditAccount as xs:string,
    $creditCurrency as xs:string,
    $uuid as xs:string)
    as element(ns0:TransferenciaInternacional) {
        <ns0:TransferenciaInternacional>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
				<noOfAuth/>
				<replace/>
            </OfsFunction>            
            <FUNDSTRANSFERFICOMT103WSType>
                <DEBITACCOUNT>{ data($transaccionSubasta/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
                <CREDITCURRENCY>{ $creditCurrency }</CREDITCURRENCY>
                <CREDITAMOUNT>{ data($transaccionSubasta/TRANSACTION_AMOUNT) }</CREDITAMOUNT>
                <gACCTWITHBANK>
                    <ACCOUNTWITHINSTITUTIONTAG57>{ concat($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_CODE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_NAME) }</ACCOUNTWITHINSTITUTIONTAG57>
                    {
                     	if ( fn-bea:trim(data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_ADDRESS)) != "" ) then (
                    		<ACCOUNTWITHINSTITUTIONTAG57>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_ADDRESS) }</ACCOUNTWITHINSTITUTIONTAG57>
                     	) else ()
                     }
                     {
                     	if ( fn-bea:trim(concat($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_CITY, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_STATE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_POSTAL_CODE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_COUNTRY)) != "") then (
                    		<ACCOUNTWITHINSTITUTIONTAG57>{ concat($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_CITY, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_STATE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_POSTAL_CODE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_COUNTRY) }</ACCOUNTWITHINSTITUTIONTAG57>
                    	) else ()
                    }
                </gACCTWITHBANK>
                 <BENEFICIARYACCOUNTNOTAG59>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_ACCOUNT) }</BENEFICIARYACCOUNTNOTAG59>
                <gBENCUSTOMER>
                    <BENNAMEANDADDRESSTAG59>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_NAME) }</BENNAMEANDADDRESSTAG59>
                	<BENNAMEANDADDRESSTAG59>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_ADDRESS) }</BENNAMEANDADDRESSTAG59>
                	{
                		if(  fn-bea:trim( concat($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_CITY, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_STATE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_POSTAL_CODE ) )  != "") then (
                			<BENNAMEANDADDRESSTAG59>{ concat($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_CITY, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_STATE, " ", $transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_POSTAL_CODE) }</BENNAMEANDADDRESSTAG59>
                		) else ()
                	}                    
                </gBENCUSTOMER>
                <gPAYMENTDETAILS>
                {
                	let $REMITTANCEINFORMATIONTAG70 := substring(fn-bea:trim(fn:string($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEFICIARY_INFO/text())), 1, 136)
                	return
                	for $value in splitString(data($REMITTANCEINFORMATIONTAG70),34)
                	return
                		if(fn:string($value) != "") then (
                			<REMITTANCEINFORMATIONTAG70>{ $value }</REMITTANCEINFORMATIONTAG70>
                		) else ()
                }
                </gPAYMENTDETAILS>
                {
                	if ( data($transaccionSubasta/INTERNATIONAL_TRANSFER/INTERMEDIARY_BANK_CODE_TYPE) = "ABA" ) then (
                		<gINTERMEDBANK g="1">
               				<INTERMEDIARYINSTITUTIONTAG56>{ concat('"FW', data($transaccionSubasta/INTERNATIONAL_TRANSFER/INTERMEDIARY_BANK_CODE), '"') }</INTERMEDIARYINSTITUTIONTAG56>
            			</gINTERMEDBANK>
                	) else if ( data($transaccionSubasta/INTERNATIONAL_TRANSFER/INTERMEDIARY_BANK_CODE_TYPE) = "SWIFT" ) then (
                		<gINTERMEDBANK g="1">
               				<INTERMEDIARYINSTITUTIONTAG56>{ concat('"SW', data($transaccionSubasta/INTERNATIONAL_TRANSFER/INTERMEDIARY_BANK_CODE), '"') }</INTERMEDIARYINSTITUTIONTAG56>
            			</gINTERMEDBANK>                	
                	) else ()
                }  
                <LRDESTCNTRY>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/DESTINATION_COUNTRY) }</LRDESTCNTRY>
                <LRFICOAUCTION>YES</LRFICOAUCTION>
                {
                    let $AUCTION_RATE_TYPE := fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text())
                    return
                    	if($AUCTION_RATE_TYPE = "") then (
                        	<LRRATEOPTION>AVG</LRRATEOPTION>
                        ) else (
                        	<LRRATEOPTION>{ $AUCTION_RATE_TYPE }</LRRATEOPTION>
                        )
                }
                <LRAUCRATE>{ data($transaccionSubasta/SUGGESTED_RATE) }</LRAUCRATE>
                <LRSWIFTTYPE>{ data($transaccionSubasta/INTERNATIONAL_TRANSFER/BENEF_BANK_CODE_TYPE) }</LRSWIFTTYPE>
            </FUNDSTRANSFERFICOMT103WSType>
        </ns0:TransferenciaInternacional>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transaccionSubasta as element(ns1:transaccionSubasta) external;
declare variable $creditAccount as xs:string external;
declare variable $creditCurrency as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaInternacionalIn($autenticacionRequestHeader,
    $transaccionSubasta,
    $creditAccount,
    $creditCurrency,
    $uuid)