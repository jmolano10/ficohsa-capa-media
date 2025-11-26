(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cargaLoteProductosRequest" element="ns2:cargaLoteProductosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../../Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CargaLoteProductos/xq/ConsultaClienteIN/";

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
 
declare function xf:ConsultaClienteIN($requestHeader as element(ns0:RequestHeader),
    $cargaLoteProductosRequest as element(ns2:cargaLoteProductosRequest))
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
	    <WSCUSTOMERType>
	        <enquiryInputCollection>
	                <columnName>@ID</columnName>
	                <criteriaValue>{ data($cargaLoteProductosRequest/CUSTOMER_ID) }</criteriaValue>
	                <operand>EQ</operand>
		</enquiryInputCollection>
	    </WSCUSTOMERType>    
        </ns1:Consultadecliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $cargaLoteProductosRequest as element(ns2:cargaLoteProductosRequest) external;

xf:ConsultaClienteIN($requestHeader,
    $cargaLoteProductosRequest)