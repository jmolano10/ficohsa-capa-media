(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns1:emisionChequesGerencia" location="emisionChequesGerenciaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechequedegerenciaFT" location="Resources/XMLSchema_-1805424041.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaLocalIn/";

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

declare function xf:emisionChequesGerenciaLocalIn($emisionChequesGerencia as element(ns1:emisionChequesGerencia),
    $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $uuid as xs:string)
    as element(ns0:EmisiondechequedegerenciaFT) {
        <ns0:EmisiondechequedegerenciaFT>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
				{
					if( upper-case($autenticacionRequestHeader/UserName/text()) = ("SRV-ITINTB", "SRV-ITWFCR")) then (
						<noOfAuth>0</noOfAuth>
					) else (
						<noOfAuth></noOfAuth>
					)
				}
				<replace></replace>
			</OfsFunction>
            <FUNDSTRANSFERFICOCASHIERCHEQUEBULKWSType>
                <DebitAccountno>{ data($emisionChequesGerencia/DEBIT_ACCOUNT) }</DebitAccountno>
                <CashierChequeAmount>{ data($emisionChequesGerencia/AMOUNT) }</CashierChequeAmount>
                <gPAYMENTDETAILS>
                {
                	let $PaymentDetails := substring(fn-bea:trim(fn:string($emisionChequesGerencia/DESCRIPTION/text())), 1, 136)
                	return
                	for $value in splitString(data($PaymentDetails),34)
                	return
                		if(fn:string($value) != "") then (
                			<Description>{ $value }</Description>
                		) else ()
                }
                </gPAYMENTDETAILS>
                <LRBENNAME>{ substring(fn-bea:trim(fn:string($emisionChequesGerencia/BENEFICIARY_NAME/text())), 1, 60) }</LRBENNAME>
                <ISSUEAGENCY>{ data($emisionChequesGerencia/WITHDRAWAL_BRANCH_ID) }</ISSUEAGENCY>
        		{
					let $acctPrefix := substring(fn-bea:trim(fn:string($emisionChequesGerencia/DEBIT_ACCOUNT/text())), 1, 3)
					return
					if ($acctPrefix = "HNL") then(
						<LRCOMNCOLLECT></LRCOMNCOLLECT>
					) else (
						if( upper-case($autenticacionRequestHeader/UserName/text()) = ("SRV-ITINTB", "SRV-ITPMSV") ) then (
							<LRCOMNCOLLECT>Y</LRCOMNCOLLECT>
						) else (
							<LRCOMNCOLLECT></LRCOMNCOLLECT>
						)
					)
				}
            </FUNDSTRANSFERFICOCASHIERCHEQUEBULKWSType>
        </ns0:EmisiondechequedegerenciaFT>
};

declare variable $emisionChequesGerencia as element(ns1:emisionChequesGerencia) external;
declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $uuid as xs:string external;

xf:emisionChequesGerenciaLocalIn($emisionChequesGerencia,
    $autenticacionRequestHeader,
    $uuid)