(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$listaSolicitudesTimeout" element="ns1:listaSolicitudesTimeout" location="listaSolicitudesTimeoutTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Listadesolicitudescontimeout" location="../Resources/XMLSchema_1080088451.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaSolicitudesTimeoutTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/errorHandling/ListaSolicitudesTimeout/listaSolicitudesTimeoutIn/";

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

declare function xf:listaSolicitudesTimeoutIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $listaSolicitudesTimeout as element(ns1:listaSolicitudesTimeout))
    as element(ns0:Listadesolicitudescontimeout) {
        <ns0:Listadesolicitudescontimeout>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOEERRORHANDLEType>
            {	
            	let $REQUEST_ID := fn:string($listaSolicitudesTimeout/REQUEST_ID/text())
            	return
            		if ($REQUEST_ID != "") then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ $REQUEST_ID }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()            
            }    
            </WSFICOEERRORHANDLEType>
        </ns0:Listadesolicitudescontimeout>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $listaSolicitudesTimeout as element(ns1:listaSolicitudesTimeout) external;

xf:listaSolicitudesTimeoutIn($autenticacionRequestHeader,
    $listaSolicitudesTimeout)