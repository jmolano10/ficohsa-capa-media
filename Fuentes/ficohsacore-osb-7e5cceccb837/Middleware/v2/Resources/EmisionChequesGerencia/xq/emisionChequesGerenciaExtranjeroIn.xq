xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns2:emisionChequesGerencia" location="../../../../Business_Resources/emisionChequesGerencia/emisionChequesGerenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EmisiondechequedegerenciaFCY" location="../../../../Business_Resources/emisionChequesGerencia/Resources/XMLSchema_-1805424041.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaExtranjeroIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
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

declare function xf:emisionChequesGerenciaExtranjeroIn($requestHeader as element(ns0:RequestHeader),
    $emisionChequesGerencia as element(ns2:emisionChequesGerencia),
    $uuid as xs:string)
    as element(ns1:EmisiondechequedegerenciaFCY) {
        <ns1:EmisiondechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon> 
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>
            <FUNDSTRANSFEROD110FCYDRAFTIBWSType>
                <DebitAccount>{ data($emisionChequesGerencia/DEBIT_ACCOUNT) }</DebitAccount>
                <DraftCurrency>{ data($emisionChequesGerencia/CHEQUE_CURRENCY) }</DraftCurrency>
                <DraftAmount>{ data($emisionChequesGerencia/AMOUNT) }</DraftAmount>
                {
                	if(fn:substring($emisionChequesGerencia/DEBIT_ACCOUNT/text(),1,3) = ('USD','EUR')) then (
		                <gORDERINGCUST>
		                    <OrderedBy>999999</OrderedBy>
		                </gORDERINGCUST>
		            ) else ()
                }                
                <gBENCUSTOMER>
                {
                        if (string-length(data($emisionChequesGerencia/BENEFICIARY_NAME)) le 35) then (                              
                            <Beneficiary>{ data($emisionChequesGerencia/BENEFICIARY_NAME) }</Beneficiary>
                        )else(
                        	let $Beneficiary := data($emisionChequesGerencia/BENEFICIARY_NAME)
                        	return
                        	for $value in splitString(data($Beneficiary),35)
                        	return
                        	<Beneficiary>{ data($value) }</Beneficiary>                	
                    	)
                    }   
                </gBENCUSTOMER>
                <gPAYMENTDETAILS>
                {
                	let $PaymentDetails := substring(fn-bea:trim(fn:string($emisionChequesGerencia/DESCRIPTION/text())), 1, 136)
                	return
                	for $value in splitString(data($PaymentDetails),34)
                	return
                		if(fn:string($value) != "") then (
                			<PaymentDetails>{ $value }</PaymentDetails>
                		) else ()
                }
                </gPAYMENTDETAILS>
                {
                	if(fn:substring($emisionChequesGerencia/DEBIT_ACCOUNT/text(),1,3) = ('USD','EUR')) then (
						<CommissionCode>WAIVE</CommissionCode>
					) else ()
				}                
                <ISSUEAGENCY>{ data($emisionChequesGerencia/WITHDRAWAL_BRANCH_ID) }</ISSUEAGENCY>
            </FUNDSTRANSFEROD110FCYDRAFTIBWSType>
        </ns1:EmisiondechequedegerenciaFCY>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $emisionChequesGerencia as element(ns2:emisionChequesGerencia) external;
declare variable $uuid as xs:string external;

xf:emisionChequesGerenciaExtranjeroIn($requestHeader,
    $emisionChequesGerencia,
    $uuid)
