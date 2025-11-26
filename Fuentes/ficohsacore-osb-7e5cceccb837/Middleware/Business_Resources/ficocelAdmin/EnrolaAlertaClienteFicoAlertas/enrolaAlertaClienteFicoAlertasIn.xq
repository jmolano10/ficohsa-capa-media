(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$enrolaAlertaClienteFicoAlertas" element="ns1:enrolaAlertaClienteFicoAlertas" location="enrolaAlertaClienteFicoAlertasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Registraralertaaclientebevents" location="../Resources/XMLSchema_1876963756.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/enrolaAlertaClienteFicoAlertasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaAlertaClienteFicoAlertas/enrolaAlertaClienteFicoAlertasIn/";

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

declare function xf:enrolaAlertaClienteFicoAlertasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $enrolaAlertaClienteFicoAlertas as element(ns1:enrolaAlertaClienteFicoAlertas))
    as element(ns0:Registraralertaaclientebevents) {
        <ns0:Registraralertaaclientebevents>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
			    <gtsControl></gtsControl>
			    <messageId></messageId>
			    <noOfAuth></noOfAuth>
			    <replace></replace>
			</OfsFunction>            
            <EBALERTREQUESTINPUTWSType>
                <EVENT>{ data($enrolaAlertaClienteFicoAlertas/ALERT_TYPE) }</EVENT>
                <CONTRACTREF>{ data($enrolaAlertaClienteFicoAlertas/PRODUCT_ID) }</CONTRACTREF>
                <SUBSCRIBE>Y</SUBSCRIBE>
            </EBALERTREQUESTINPUTWSType>
        </ns0:Registraralertaaclientebevents>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $enrolaAlertaClienteFicoAlertas as element(ns1:enrolaAlertaClienteFicoAlertas) external;

xf:enrolaAlertaClienteFicoAlertasIn($autenticacionRequestHeader,
    $enrolaAlertaClienteFicoAlertas)