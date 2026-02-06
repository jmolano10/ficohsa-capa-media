xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadefechadelsistema" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaIn/";

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

declare function xf:consultaFechaSistemaIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader))
    as element(ns0:Consultadefechadelsistema) {
        <ns0:Consultadefechadelsistema>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
	         <WSDATESType>
	            <enquiryInputCollection>
	               <columnName>COMPANY.CODE</columnName>
	               <criteriaValue>HN0010001</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	         </WSDATESType>
        </ns0:Consultadefechadelsistema>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;

xf:consultaFechaSistemaIn($autenticacionRequestHeader)