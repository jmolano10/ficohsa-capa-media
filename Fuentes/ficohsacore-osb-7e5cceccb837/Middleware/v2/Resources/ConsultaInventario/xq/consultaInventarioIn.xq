(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaInventario1" element="ns0:consultaInventario" location="../xsd/consultaInventarioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Consultadetalleinventario" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInventarioTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInventario/xq/consultaInventarioIn/";

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

declare function xf:consultaInventarioIn($requestHeader1 as element(ns1:RequestHeader),
    $consultaInventario1 as element(ns0:consultaInventario))
    as element(ns2:Consultadetalleinventario) {
        <ns2:Consultadetalleinventario>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSINVENTORYType>
            {
            	if (fn:string($consultaInventario1/STOCK_CODE/text()) != "") then (
	                <enquiryInputCollection>
	                	<columnName>@ID</columnName>
	                    <criteriaValue>{ data($consultaInventario1/STOCK_CODE) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
	            ) else ()
            }
            </WSINVENTORYType>
        </ns2:Consultadetalleinventario>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $consultaInventario1 as element(ns0:consultaInventario) external;

xf:consultaInventarioIn($requestHeader1,
    $consultaInventario1)