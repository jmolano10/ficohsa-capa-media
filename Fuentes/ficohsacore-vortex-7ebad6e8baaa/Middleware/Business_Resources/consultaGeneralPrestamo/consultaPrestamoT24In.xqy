xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns1:consultaGeneralPrestamo" location="consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodeprestamo" location="Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaGeneralPrestamo/consultaPrestamoT24In/";

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

declare function xf:consultaPrestamoT24In($consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns0:Consultadesaldodeprestamo) {
        <ns0:Consultadesaldodeprestamo>
          	<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSLOANDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ data($consultaGeneralPrestamo1/LOAN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLOANDETAILSAAType>
        </ns0:Consultadesaldodeprestamo>
};

declare variable $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:consultaPrestamoT24In($consultaGeneralPrestamo1,
    $autenticacionRequestHeader1)