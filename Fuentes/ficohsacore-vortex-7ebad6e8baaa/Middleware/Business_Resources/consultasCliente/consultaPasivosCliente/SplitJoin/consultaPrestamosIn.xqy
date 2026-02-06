xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaPrestamoTypeRequest" location="../consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/test/consultaPrestamosIn2/";

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

declare function xf:consultaPrestamosIn2($consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns0:ConsultaPrestamoTypeRequest) {
        <ns0:ConsultaPrestamoTypeRequest>
            <ns0:AUTHENTICATION_PROXY>
                <ns0:USERNAME>{ data($autenticacionRequestHeader1/UserName) }</ns0:USERNAME>
                <ns0:PASSWORD>{ data($autenticacionRequestHeader1/Password) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION_PROXY>
            <ns0:AUTHENTICATION_T24>
                <ns0:USERNAME>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</ns0:USERNAME>
                <ns0:PASSWORD>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION_T24>
            <ns0:PARAMETERS>
                <ns0:CUSTOMERID>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns0:CUSTOMERID>
            </ns0:PARAMETERS>
        </ns0:ConsultaPrestamoTypeRequest>
};

declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:consultaPrestamosIn2($consultaPasivosClienteRequest1,
    $autenticacionRequestHeader1)