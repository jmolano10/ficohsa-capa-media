(:: pragma bea:global-element-parameter parameter="$consultaAnticiposCliente1" element="ns1:consultaAnticiposCliente" location="../../ConsultaAnticiposCliente/xsd/consultaAnticiposClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaanticiposdisponiblescta" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaAnticiposClienteTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAnticiposCliente/xq/ConsultaAnticiposHNIn/";

 
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

declare function xf:ConsultaAnticiposHNIn($consultaAnticiposCliente1 as element(ns1:consultaAnticiposCliente),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:Consultaanticiposdisponiblescta) {
        <ns0:Consultaanticiposdisponiblescta>
 			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FICOECARELIEFWSType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaAnticiposCliente1/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOECARELIEFWSType>
        </ns0:Consultaanticiposdisponiblescta>
};

declare variable $consultaAnticiposCliente1 as element(ns1:consultaAnticiposCliente) external;
declare variable $requestHeader1 as element(ns2:RequestHeader) external;

xf:ConsultaAnticiposHNIn($consultaAnticiposCliente1,
    $requestHeader1)