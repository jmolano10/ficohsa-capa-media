xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest" element="ns1:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultaPrestamoTypeRequest" location="../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPrestamosIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "ConsultaPrestamosCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
declare function xf:consultaPrestamosIn($requestHeader as element(ns0:RequestHeader),
    $consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest))
    as element(ns2:ConsultaPrestamoTypeRequest) {
        <ns2:ConsultaPrestamoTypeRequest>
            <ns2:AUTHENTICATION_PROXY>
                <ns2:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns2:USERNAME>
                <ns2:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns2:PASSWORD>
            </ns2:AUTHENTICATION_PROXY>
            <ns2:AUTHENTICATION_T24>
                <ns2:USERNAME>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</ns2:USERNAME>
                <ns2:PASSWORD>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</ns2:PASSWORD>
            </ns2:AUTHENTICATION_T24>
            <ns2:PARAMETERS>
                <ns2:CUSTOMERID>{ data($consultaPasivosClienteRequest/CUSTOMER_ID) }</ns2:CUSTOMERID>
            </ns2:PARAMETERS>
        </ns2:ConsultaPrestamoTypeRequest>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaPrestamosIn($requestHeader,
    $consultaPasivosClienteRequest)