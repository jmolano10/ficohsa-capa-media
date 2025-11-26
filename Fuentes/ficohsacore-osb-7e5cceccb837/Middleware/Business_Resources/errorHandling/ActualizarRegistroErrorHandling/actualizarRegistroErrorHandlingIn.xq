(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizarRegistroErrorHandling" element="ns1:actualizarRegistroErrorHandling" location="actualizarRegistroErrorHandlingTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Actualizarregistroerrorhandling" location="../Resources/XMLSchema_1080088451.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizarRegistroErrorHandlingTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/errorHandling/ActualizarRegistroErrorHandling/actualizarRegistroErrorHandlingIn/";

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

declare function xf:actualizarRegistroErrorHandlingIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizarRegistroErrorHandling as element(ns1:actualizarRegistroErrorHandling))
    as element(ns0:Actualizarregistroerrorhandling) {
        <ns0:Actualizarregistroerrorhandling>
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
            <FICOHERRORHANDLEFICOUPDATEType id = "{ data($actualizarRegistroErrorHandling/RECORD_ID) }">
                <STATUS>{ data($actualizarRegistroErrorHandling/NEW_STATUS) }</STATUS>
            </FICOHERRORHANDLEFICOUPDATEType>
        </ns0:Actualizarregistroerrorhandling>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizarRegistroErrorHandling as element(ns1:actualizarRegistroErrorHandling) external;

xf:actualizarRegistroErrorHandlingIn($autenticacionRequestHeader,
    $actualizarRegistroErrorHandling)