(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Cancelaciondecuentaparte2" location="../Resources/XMLSchema_1790235882.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/cancelacionCuentaAhorros/CancelacionCuentaAhorros/cancelacionCuentaAhorrosParte2In/";

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

declare function xf:cancelacionCuentaAhorrosParte2In($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $account as xs:string)
    as element(ns0:Cancelaciondecuentaparte2) {
        <ns0:Cancelaciondecuentaparte2>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOHNACCTCLOSEType>
                <ACCOUNTNO>{ $account }</ACCOUNTNO>
            </TELLERFICOHNACCTCLOSEType>
        </ns0:Cancelaciondecuentaparte2>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $account as xs:string external;

xf:cancelacionCuentaAhorrosParte2In($autenticacionRequestHeader,
    $account)