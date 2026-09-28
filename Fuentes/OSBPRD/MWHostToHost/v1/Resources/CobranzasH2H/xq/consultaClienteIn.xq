(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../../../../../Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CobranzasH2H/xq/consultaClienteIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:consultaClienteIn($requestHeader as element(ns1:RequestHeader),$customerId as xs:string,
    $legalId as xs:string)
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
        	<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection> 
                	{
                		if($customerId != "") then(
                			<columnName>@ID</columnName>,
                			<criteriaValue>{ $customerId }</criteriaValue>
                		) else (
                			<columnName>LR.INDX.LEGALID</columnName>,
                			<criteriaValue>{ $legalId }</criteriaValue>
                		)
                	}
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $customerId as xs:string external;
declare variable $legalId as xs:string external;

xf:consultaClienteIn($requestHeader,
	$customerId,
    $legalId)