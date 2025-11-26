(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteRequest1" element="ns0:actualizaDatosClienteRequest" location="../xsd/actualizaDatosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/consultaClienteIn/";

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

declare function xf:consultaClienteIn($requestHeader1 as element(ns2:RequestHeader),
    $actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest))
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
            <WebRequestCommon>
                <userName>{
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    	} </userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    	}</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($actualizaDatosClienteRequest1/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns1:Consultadecliente>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest) external;

xf:consultaClienteIn($requestHeader1,
    $actualizaDatosClienteRequest1)