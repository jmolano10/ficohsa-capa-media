(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaLimitesCliente" element="ns1:consultaLimitesCliente" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadelimitesporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaLimitesCliente/consultaLimitesClienteIn/";

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

declare function xf:consultaLimitesClienteIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaLimitesCliente as element(ns1:consultaLimitesCliente))
    as element(ns0:Consultadelimitesporcliente) {
        <ns0:Consultadelimitesporcliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOLIMITSUMMARYType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER.ID</columnName>
                    <criteriaValue>{ data($consultaLimitesCliente/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLIMITSUMMARYType>
        </ns0:Consultadelimitesporcliente>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaLimitesCliente as element(ns1:consultaLimitesCliente) external;

xf:consultaLimitesClienteIn($autenticacionRequestHeader,
    $consultaLimitesCliente)