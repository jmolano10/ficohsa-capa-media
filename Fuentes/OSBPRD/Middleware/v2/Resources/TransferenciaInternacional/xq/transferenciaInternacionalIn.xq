xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalRequest" element="ns2:transferenciaInternacionalRequest" location="../../../../Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaInternacional" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaInternacional/xq/transferenciaInternacionalIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace ns1 = "T24WebServicesImpl";

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

declare function xf:transferenciaInternacionalIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaInternacionalRequest as element(ns2:transferenciaInternacionalRequest),
    $creditAccount as xs:string,
    $creditCurrency as xs:string,
    $uuid as xs:string)
    as element(ns1:TransferenciaInternacional) {
        <ns1:TransferenciaInternacional>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOMT103WSType>
                <DEBITACCOUNT>{ data($transferenciaInternacionalRequest/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
                <CREDITCURRENCY>{ $creditCurrency }</CREDITCURRENCY>
                <CREDITAMOUNT>{ data($transferenciaInternacionalRequest/TRANSFER_AMOUNT) }</CREDITAMOUNT>
                <gACCTWITHBANK>
                {
                	let $BENEF_BANK_CODE_TYPE := fn:string($transferenciaInternacionalRequest/BENEF_BANK_CODE_TYPE/text())
                	return
                		if ($BENEF_BANK_CODE_TYPE = "ABA") then (
		                	<ACCOUNTWITHINSTITUTIONTAG57>{ concat('"//FW', data($transferenciaInternacionalRequest/BENEF_BANK_CODE), '"') }</ACCOUNTWITHINSTITUTIONTAG57>
			        			
			        	) else if ($BENEF_BANK_CODE_TYPE = "SWIFT") then (
		                	<ACCOUNTWITHINSTITUTIONTAG57>{ concat('SW-', data($transferenciaInternacionalRequest/BENEF_BANK_CODE)) }</ACCOUNTWITHINSTITUTIONTAG57>
		                	
			        	) else (
							let $ACCOUNTWITHINSTITUTIONTAG57 := fn-bea:trim(concat($transferenciaInternacionalRequest/BENEF_BANK_NAME, " ", $transferenciaInternacionalRequest/BENEF_BANK_ADDRESS, " ", 
																					$transferenciaInternacionalRequest/BENEF_BANK_CITY, " ", $transferenciaInternacionalRequest/BENEF_BANK_STATE, " ", 
																					$transferenciaInternacionalRequest/BENEF_BANK_POSTAL_CODE, " ", $transferenciaInternacionalRequest/BENEF_BANK_COUNTRY))
							return
							for $value in splitString(data($ACCOUNTWITHINSTITUTIONTAG57),34)
							return
			        			if(fn:string($value) != "") then (
			        				<ACCOUNTWITHINSTITUTIONTAG57>{ $value }</ACCOUNTWITHINSTITUTIONTAG57>
			        			) else ()			        	
			        	)
                }
                </gACCTWITHBANK>
                <BENEFICIARYACCOUNTNOTAG59>{ data($transferenciaInternacionalRequest/BENEFICIARY_ACCOUNT) }</BENEFICIARYACCOUNTNOTAG59>
                <gBENCUSTOMER>
                {
                	let $BENNAMEANDADDRESSTAG59 := fn-bea:trim(concat($transferenciaInternacionalRequest/BENEFICIARY_NAME, " ", $transferenciaInternacionalRequest/BENEFICIARY_ADDRESS, " ",
            											  $transferenciaInternacionalRequest/BENEFICIARY_CITY, " ", $transferenciaInternacionalRequest/BENEFICIARY_STATE, " ",
            											  $transferenciaInternacionalRequest/BENEFICIARY_POSTAL_CODE))
					return
					for $value in splitString(data($BENNAMEANDADDRESSTAG59),34)
					return
	        			if(fn:string($value) != "") then (
	        				<BENNAMEANDADDRESSTAG59>{ $value }</BENNAMEANDADDRESSTAG59>
	        			) else ()
                }                  
                </gBENCUSTOMER>
                <gPAYMENTDETAILS>
                {
                	let $REMITTANCEINFORMATIONTAG70 := substring(fn-bea:trim(fn:string($transferenciaInternacionalRequest/DESCRIPTION/text())), 1, 136)
                	return
                	for $value in splitString(data($REMITTANCEINFORMATIONTAG70),34)
                	return
                		if(fn:string($value) != "") then (
                			<REMITTANCEINFORMATIONTAG70>{ $value }</REMITTANCEINFORMATIONTAG70>
                		) else ()
                }
                </gPAYMENTDETAILS>
                {
                	if ( data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE_TYPE) = "ABA" ) then (
                		<gINTERMEDBANK g="1">
               				<INTERMEDIARYINSTITUTIONTAG56>{ concat('"//FW', data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE), '"') }</INTERMEDIARYINSTITUTIONTAG56>
            			</gINTERMEDBANK>
                	) else if ( data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE_TYPE) = "SWIFT" ) then (
                		<gINTERMEDBANK g="1">
               				<INTERMEDIARYINSTITUTIONTAG56>{ concat('SW-', data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE)) }</INTERMEDIARYINSTITUTIONTAG56>
            			</gINTERMEDBANK>                	
                	) else ()
                }                
                <ACCOUNTWITHBANKACCTTAG57>{ data($transferenciaInternacionalRequest/BENEF_BANK_INT_ACCOUNT) }</ACCOUNTWITHBANKACCTTAG57>
                <LRDESTCNTRY>{ data($transferenciaInternacionalRequest/DESTINATION_COUNTRY) }</LRDESTCNTRY>
                <LRSWIFTTYPE>{ data($transferenciaInternacionalRequest/BENEF_BANK_CODE_TYPE) }</LRSWIFTTYPE>
            </FUNDSTRANSFERFICOMT103WSType>
        </ns1:TransferenciaInternacional>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaInternacionalRequest as element(ns2:transferenciaInternacionalRequest) external;
declare variable $creditAccount as xs:string external;
declare variable $creditCurrency as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaInternacionalIn($requestHeader,
    $transferenciaInternacionalRequest,
    $creditAccount,
    $creditCurrency,
    $uuid)