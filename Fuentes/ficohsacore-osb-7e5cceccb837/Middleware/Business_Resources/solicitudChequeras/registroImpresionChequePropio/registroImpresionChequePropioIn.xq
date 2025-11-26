(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroImpresionCheque" element="ns1:registroImpresionCheque" location="registroImpresionChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Registrodechequerapropimpresion" location="../Resources/XMLSchema_21306858.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroImpresionChequeTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/registroImpresionChequePropio/registroImpresionChequePropioIn/";

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

declare function xf:registroImpresionChequePropioIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $registroImpresionCheque as element(ns1:registroImpresionCheque))
    as element(ns0:Registrodechequerapropimpresion) {
        <ns0:Registrodechequerapropimpresion>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth>0</noOfAuth>
				<replace></replace>
			</OfsFunction>
            <FICOHCHECKBOOKREQUESTPRINTType>
                <ACCOUNTNUMBER>{ data($registroImpresionCheque/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <FINALCHECKNUMBER>{ data($registroImpresionCheque/LAST_CHEQUE_NO) }</FINALCHECKNUMBER>
            </FICOHCHECKBOOKREQUESTPRINTType>
        </ns0:Registrodechequerapropimpresion>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $registroImpresionCheque as element(ns1:registroImpresionCheque) external;

xf:registroImpresionChequePropioIn($autenticacionRequestHeader,
    $registroImpresionCheque)