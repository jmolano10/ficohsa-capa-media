xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest1" element="ns1:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaestadoremesaenbackend" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/consultaRemesaBackendIn/";

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

declare function xf:consultaRemesaBackendIn($requestHeader1 as element(ns2:RequestHeader),
    $actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest))
    as element(ns0:Consultaestadoremesaenbackend) {
        <ns0:Consultaestadoremesaenbackend>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSREMITSTATUST24Type>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($actualizaEstadoRemesaRequest1/REMITTANCE_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSREMITSTATUST24Type>
        </ns0:Consultaestadoremesaenbackend>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest) external;

xf:consultaRemesaBackendIn($requestHeader1,
    $actualizaEstadoRemesaRequest1)