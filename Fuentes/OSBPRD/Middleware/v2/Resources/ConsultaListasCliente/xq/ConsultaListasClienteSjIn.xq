(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaListasCliente1" element="ns1:consultaListasCliente" location="../xsd/consultaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/ConsultaListasClienteSjIn/";

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

declare function xf:ConsultaListasClienteSjIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaListasCliente1 as element(ns1:consultaListasCliente))
    as element(ns0:sjConsultaListasClienteRequest) {
        <ns0:sjConsultaListasClienteRequest>
            <ns0:USERNAME>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</ns0:USERNAME>
            <ns0:PASSWORD>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</ns0:PASSWORD>
            <ns0:CUSTOMER_LEGAL_ID>{ data($consultaListasCliente1/CUSTOMER_LEGAL_ID) }</ns0:CUSTOMER_LEGAL_ID>
        </ns0:sjConsultaListasClienteRequest>
};



declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaListasCliente1 as element(ns1:consultaListasCliente) external;

xf:ConsultaListasClienteSjIn($requestHeader1,
    $consultaListasCliente1)