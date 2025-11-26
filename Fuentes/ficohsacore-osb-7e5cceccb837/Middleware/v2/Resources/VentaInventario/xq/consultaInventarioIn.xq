(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeinventarioenagencia" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VentaInventario/xq/consultaInventarioIn/";

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

declare function xf:consultaInventarioIn($requestHeader1 as element(ns0:RequestHeader),
    $stockCode as xs:string)
    as element(ns1:Consultadeinventarioenagencia) {
        <ns1:Consultadeinventarioenagencia>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSSTOCKDETAILType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ $stockCode }</criteriaValue>
                    <operand>EW</operand>
                </enquiryInputCollection>
            </WSSTOCKDETAILType>
        </ns1:Consultadeinventarioenagencia>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $stockCode as xs:string external;

xf:consultaInventarioIn($requestHeader1,
    $stockCode)