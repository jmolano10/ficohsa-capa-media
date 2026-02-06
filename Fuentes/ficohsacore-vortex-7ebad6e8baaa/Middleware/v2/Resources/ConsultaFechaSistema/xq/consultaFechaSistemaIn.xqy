xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadefechadelsistema" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFechaSistema/xq/consultaFechaSistemaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:consultaFechaSistemaIn($requestHeader as element(ns0:RequestHeader))
    as element(ns1:Consultadefechadelsistema) {
        <ns1:Consultadefechadelsistema>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
	         <WSDATESType>
	            <enquiryInputCollection>
	               <columnName>COMPANY.CODE</columnName>
	               <criteriaValue>HN0010001</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	         </WSDATESType>
        </ns1:Consultadefechadelsistema>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaFechaSistemaIn($requestHeader)