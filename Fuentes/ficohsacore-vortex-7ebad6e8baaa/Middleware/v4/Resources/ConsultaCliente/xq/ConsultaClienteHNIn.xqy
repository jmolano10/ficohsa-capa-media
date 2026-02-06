xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest" element="ns2:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaClientev4" location="../../../BusinessServices/T24/svcConsultaCliente_v4/xsd/svcConsultaCliente_v4Types.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/ConsultaCliente/xq/ConsultaClienteHNIn/";

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
 
declare function xf:ConsultaClienteIn($requestHeader as element(ns0:RequestHeader),
    $consultaClienteRequest as element(ns2:consultaClienteRequest))
    as element(ns1:ConsultaClientev4) {
        <ns1:ConsultaClientev4>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            {
            	if (fn:string($consultaClienteRequest/ns2:CUSTOMER_ID_TYPE/text()) = ("CODE","CUSTOMER_ID")) then (
                	<WSV4CUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaClienteRequest/ns2:CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSV4CUSTOMERType>
                ) else if (fn:string($consultaClienteRequest/ns2:CUSTOMER_ID_TYPE/text()) = ("LEGAL_ID")) then (
                	<WSV4CUSTOMERType>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaClienteRequest/ns2:CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSV4CUSTOMERType>
                ) else (
                	<WSV4CUSTOMERType/>
                )
            }
            
        </ns1:ConsultaClientev4>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaClienteRequest as element(ns2:consultaClienteRequest) external;

xf:ConsultaClienteIn($requestHeader,
    $consultaClienteRequest)