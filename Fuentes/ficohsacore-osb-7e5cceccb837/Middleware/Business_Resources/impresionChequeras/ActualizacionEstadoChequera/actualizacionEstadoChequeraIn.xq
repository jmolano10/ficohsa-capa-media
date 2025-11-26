(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizacionEstadoChequera" element="ns0:actualizacionEstadoChequera" location="actualizacionEstadoChequeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Actualizaciondeestadodechequera" location="../Resources/XMLSchema_1756805255.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizacionEstadoChequeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/ActualizacionEstadoChequera/actualizacionEstadoChequeraIn/";

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

declare function xf:actualizacionEstadoChequeraIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizacionEstadoChequera as element(ns0:actualizacionEstadoChequera))
    as element(ns1:Actualizaciondeestadodechequera) {
        <ns1:Actualizaciondeestadodechequera>
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
            <FICOHCHECKBOOKREQUESTSTATUSUPDATEType id = "{ data($actualizacionEstadoChequera/CHEQUEBOOK_ID) }">
                <PRINTSTATUS>{ data($actualizacionEstadoChequera/NEW_STATUS) }</PRINTSTATUS>
            </FICOHCHECKBOOKREQUESTSTATUSUPDATEType>
        </ns1:Actualizaciondeestadodechequera>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizacionEstadoChequera as element(ns0:actualizacionEstadoChequera) external;

xf:actualizacionEstadoChequeraIn($autenticacionRequestHeader,
    $actualizacionEstadoChequera)