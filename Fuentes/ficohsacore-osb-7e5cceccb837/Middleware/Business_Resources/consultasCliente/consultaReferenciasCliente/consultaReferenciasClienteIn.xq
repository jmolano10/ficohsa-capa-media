(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaReferenciasCliente" element="ns1:consultaReferenciasCliente" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Referenciasporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaReferenciasCliente/consultaReferenciasClienteIn/";

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

declare function xf:consultaReferenciasClienteIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaReferenciasCliente as element(ns1:consultaReferenciasCliente))
    as element(ns0:Referenciasporcliente) {
        <ns0:Referenciasporcliente>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSCUSTOMERREFSType>
            {
            	if ( exists($consultaReferenciasCliente/CUSTOMER_ID/text()) ) then (
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($consultaReferenciasCliente/CUSTOMER_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
               ) else (),
               if ( exists($consultaReferenciasCliente/CUSTOMER_LEGAL_ID/text()) ) then (
	                <enquiryInputCollection>
	                    <columnName>LEGAL.ID</columnName>
	                    <criteriaValue>{ data($consultaReferenciasCliente/CUSTOMER_LEGAL_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
               ) else ()
            }
            </WSCUSTOMERREFSType>
        </ns0:Referenciasporcliente>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaReferenciasCliente as element(ns1:consultaReferenciasCliente) external;

xf:consultaReferenciasClienteIn($autenticacionRequestHeader,
    $consultaReferenciasCliente)