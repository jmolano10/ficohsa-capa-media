xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTelefonoClienteRequest" element="ns2:consultaTelefonoClienteRequest" location="../xsd/consultaTelefonoClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTelefonoCliente/xq/consultaTelefonoClienteIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTelefonoClienteTypes";
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

declare function xf:consultaTelefonoClienteIn($consultaTelefonoClienteRequest as element(ns2:consultaTelefonoClienteRequest),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            {
            	if (fn:string($consultaTelefonoClienteRequest/CUSTOMER_ID_TYPE/text()) = ("CODE","CUSTOMER_ID")) then (
                	<WSCUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaTelefonoClienteRequest/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTOMERType>
                ) else if (fn:string($consultaTelefonoClienteRequest/CUSTOMER_ID_TYPE/text()) = ("LEGAL_ID")) then (
                	<WSCUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaTelefonoClienteRequest/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTOMERType>
                ) else (
                	<WSCUSTOMERType/>
                )
            }
        </ns1:Consultadecliente>
};

declare variable $consultaTelefonoClienteRequest as element(ns2:consultaTelefonoClienteRequest) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaTelefonoClienteIn($consultaTelefonoClienteRequest,
    $requestHeader)
