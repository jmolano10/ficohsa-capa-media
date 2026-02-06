xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultasClienteIn/";

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
 
declare function xf:consultasClienteIn($requestHeader as element(ns0:RequestHeader),
    $CUSTOMERID as xs:string)
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
										data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                						data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ $CUSTOMERID }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns1:Consultadecliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $CUSTOMERID as xs:string external;

xf:consultasClienteIn($requestHeader,
    $CUSTOMERID)