(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaDatosClienteIN" element="ns0:validaDatosCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaListasClienteRequest" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/ConsultaListasClienteSjIn/";

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


declare function xf:ConsultaListasClienteSjIn($requestHeaderIN as element(ns2:RequestHeader),
    $validaDatosClienteIN as element(ns0:validaDatosCliente))
    as element(ns1:sjConsultaListasClienteRequest) {
        <ns1:sjConsultaListasClienteRequest>
            <ns1:USERNAME>{ fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)), 
												data($requestHeaderIN/Authentitacion/UserName)) }</ns1:USERNAME>
            <ns1:PASSWORD>{ fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                								data($requestHeaderIN/Authentication/Password)) }</ns1:PASSWORD>
            <ns1:CUSTOMER_LEGAL_ID>{ data($validaDatosClienteIN/LEGAL_ID) }</ns1:CUSTOMER_LEGAL_ID>
        </ns1:sjConsultaListasClienteRequest>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $validaDatosClienteIN as element(ns0:validaDatosCliente) external;

xf:ConsultaListasClienteSjIn($requestHeaderIN,
    $validaDatosClienteIN)
