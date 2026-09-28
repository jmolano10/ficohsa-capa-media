(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns1:consultaGeneralPrestamo" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodeprestamo" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaGeneralPrestamo/consultaPrestamoT24In2/";

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

declare function xf:consultaPrestamoT24In2($requestHeader1 as element(ns2:RequestHeader),
    $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo))
    as element(ns0:Consultadesaldodeprestamo) {
        <ns0:Consultadesaldodeprestamo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
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

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo) external;

xf:consultaPrestamoT24In2($requestHeader1,
    $consultaGeneralPrestamo1)