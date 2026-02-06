xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns1:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Consultadecertifdeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseDEPHNIn/";

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
 
declare function xf:consultaProductoOnBaseDEPHNIn($requestHeader as element(ns0:RequestHeader),
    $consultaProductoOnBase as element(ns1:consultaProductoOnBase))
    as element(ns2:Consultadecertifdeposito) {
        <ns2:Consultadecertifdeposito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSAZACCOUNTDEPType>              
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaProductoOnBase/PRODUCT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSAZACCOUNTDEPType>
        </ns2:Consultadecertifdeposito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaProductoOnBase as element(ns1:consultaProductoOnBase) external;

xf:consultaProductoOnBaseDEPHNIn($requestHeader,
    $consultaProductoOnBase)