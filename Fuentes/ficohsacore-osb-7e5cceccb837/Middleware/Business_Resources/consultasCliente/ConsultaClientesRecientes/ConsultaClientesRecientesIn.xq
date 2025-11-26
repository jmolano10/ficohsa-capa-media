(:: pragma bea:global-element-parameter parameter="$consultaClientesRecientes1" element="ns1:consultaClientesRecientes" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/ConsultaClientesRecientes/ConsultaClientesRecientesIn/";

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

declare function xf:ConsultaClientesRecientesIn($consultaClientesRecientes1 as element(ns1:consultaClientesRecientes),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
	                {
	                	if(fn:string($consultaClientesRecientes1/LAST_CUSTOMER_ID/text()) = "") then (
	                    	<criteriaValue>{ data($consultaClientesRecientes1/FIRST_CUSTOMER_ID) }</criteriaValue>,
	                    	<operand>GT</operand>
	                    ) else (
	                    	<criteriaValue>{ concat(data($consultaClientesRecientes1/FIRST_CUSTOMER_ID), " ", data($consultaClientesRecientes1/LAST_CUSTOMER_ID)) }</criteriaValue>,
	                    	<operand>RG</operand>
	                    )
	                }
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $consultaClientesRecientes1 as element(ns1:consultaClientesRecientes) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:ConsultaClientesRecientesIn($consultaClientesRecientes1,
    $autenticacionRequestHeader1)