(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$listaRecaudos" element="ns1:listaRecaudos" location="listaRecaudosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Listaderecaudos" location="../Resources/XMLSchema_-1599652964.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaRecaudosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/listaRecaudos/listaRecaudosIn/";

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

declare function xf:listaRecaudosIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $listaRecaudos as element(ns1:listaRecaudos))
    as element(ns0:Listaderecaudos) {
        <ns0:Listaderecaudos>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSCOLLECTIONSLISTType>
            {
            	if ( $listaRecaudos/COLLECTION_ID/text() != "" ) then (
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($listaRecaudos/COLLECTION_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                ) else ()
            }
            </WSCOLLECTIONSLISTType>
        </ns0:Listaderecaudos>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $listaRecaudos as element(ns1:listaRecaudos) external;

xf:listaRecaudosIn($autenticacionRequestHeader,
    $listaRecaudos)