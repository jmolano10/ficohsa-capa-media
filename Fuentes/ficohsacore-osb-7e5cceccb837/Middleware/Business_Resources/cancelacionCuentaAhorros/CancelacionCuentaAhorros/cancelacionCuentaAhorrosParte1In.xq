(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelacionCuentaAhorros1" element="ns1:cancelacionCuentaAhorros" location="cancelacionCuentaAhorrosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Cancelaciondecuentaparte1" location="../Resources/XMLSchema_1790235882.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelacionCuentaAhorrosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/cancelacionCuentaAhorros/CancelacionCuentaAhorros/cancelacionCuentaAhorrosIn/";

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

declare function xf:cancelacionCuentaAhorrosIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $cancelacionCuentaAhorros1 as element(ns1:cancelacionCuentaAhorros))
    as element(ns0:Cancelaciondecuentaparte1) {
        <ns0:Cancelaciondecuentaparte1>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth>1</noOfAuth>
				<replace></replace>
            </OfsFunction>
            <ACCOUNTCLOSUREFICOHNCAJATTType id = "{ data($cancelacionCuentaAhorros1/ACCOUNT_NUMBER) }">
            	<CLOSEONLINE>Y</CLOSEONLINE>
				<CLOSEMODE>T</CLOSEMODE>
				<HNCACTA>{ data($cancelacionCuentaAhorros1/CANCEL_MOTIVE) }</HNCACTA>
			</ACCOUNTCLOSUREFICOHNCAJATTType>
        </ns0:Cancelaciondecuentaparte1>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $cancelacionCuentaAhorros1 as element(ns1:cancelacionCuentaAhorros) external;

xf:cancelacionCuentaAhorrosIn($autenticacionRequestHeader1,
    $cancelacionCuentaAhorros1)