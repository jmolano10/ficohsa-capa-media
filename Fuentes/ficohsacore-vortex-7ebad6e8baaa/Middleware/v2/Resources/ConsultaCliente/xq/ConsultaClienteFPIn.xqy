xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns2:consultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCliente/xq/ConsultaClienteFPIn/";

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

declare function xf:ConsultaClienteFPIn($consultaActivosClienteRequest1 as element(ns2:consultaActivosClienteRequest),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
            <WebRequestCommon>
                <userName>{
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    	} </userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    	}</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns1:Consultadecliente>
};

declare variable $consultaActivosClienteRequest1 as element(ns2:consultaActivosClienteRequest) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:ConsultaClienteFPIn($consultaActivosClienteRequest1,
    $requestHeader)