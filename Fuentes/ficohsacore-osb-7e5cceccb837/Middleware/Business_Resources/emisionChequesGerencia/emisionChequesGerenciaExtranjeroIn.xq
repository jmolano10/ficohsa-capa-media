(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns1:emisionChequesGerencia" location="emisionChequesGerenciaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechequedegerenciaFCY" location="Resources/XMLSchema_-1805424041.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaExtranjeroIn/";

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

declare function xf:emisionChequesGerenciaExtranjeroIn($emisionChequesGerencia as element(ns1:emisionChequesGerencia),
    $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $uuid as xs:string)
    as element(ns0:EmisiondechequedegerenciaFCY) {
        <ns0:EmisiondechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
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
        </ns0:EmisiondechequedegerenciaFCY>
};

declare variable $emisionChequesGerencia as element(ns1:emisionChequesGerencia) external;
declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $uuid as xs:string external;

xf:emisionChequesGerenciaExtranjeroIn($emisionChequesGerencia,
    $autenticacionRequestHeader,
    $uuid)