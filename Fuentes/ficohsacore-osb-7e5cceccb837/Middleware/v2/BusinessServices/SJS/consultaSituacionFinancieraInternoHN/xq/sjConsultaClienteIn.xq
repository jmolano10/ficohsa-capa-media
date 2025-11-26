(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$group" type="ns2:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/sjConsultaClienteIn/";

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
 
declare function xf:sjConsultaClienteIn($requestHeader as element(ns0:RequestHeader),
    $group as element())
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                {
                    for $CUSTOMER in $group/CUSTOMERS/CUSTOMER
                    return
                        <enquiryInputCollection>
                            <columnName>@ID</columnName>
                            <criteriaValue>{ data($CUSTOMER/ID) }</criteriaValue>
                            <operand>EQ</operand>
                        </enquiryInputCollection>
                }
            </WSCUSTOMERType>
        </ns1:Consultadecliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $group as element() external;

xf:sjConsultaClienteIn($requestHeader,
    $group)
