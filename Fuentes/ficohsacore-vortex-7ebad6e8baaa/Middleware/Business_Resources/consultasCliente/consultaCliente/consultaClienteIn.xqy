xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCliente1" element="ns1:consultaCliente" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaCliente/consultaClienteIn/";

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

declare function xf:consultaClienteIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaCliente1 as element(ns1:consultaCliente))
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            {
            	if (data($consultaCliente1/CUSTOMER_ID) != "" and data($consultaCliente1/CUSTOMER_LEGAL_ID) != "") then (
	            	<WSCUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaCliente1/CUSTOMER_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaCliente1/CUSTOMER_LEGAL_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTOMERType>
                ) else if (data($consultaCliente1/CUSTOMER_ID) != "") then (
                	<WSCUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaCliente1/CUSTOMER_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTOMERType>
                ) else (
                	<WSCUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaCliente1/CUSTOMER_LEGAL_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTOMERType>
                )
            }
        </ns0:Consultadecliente>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaCliente1 as element(ns1:consultaCliente) external;

xf:consultaClienteIn($autenticacionRequestHeader1,
    $consultaCliente1)