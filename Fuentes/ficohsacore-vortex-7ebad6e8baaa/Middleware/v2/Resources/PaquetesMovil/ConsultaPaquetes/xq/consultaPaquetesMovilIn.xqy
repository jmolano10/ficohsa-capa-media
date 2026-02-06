xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilRequest" element="ns2:consultaPaquetesMovilRequest" location="../xsd/consultaPaquetesMovilTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaPaquetesMoviles" location="../../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaPaquetesTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMovil/ConsultaPaquetes/xq/consultaPaquetesMovilIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:consultaPaquetesMovilIn($requestHeader as element(ns0:RequestHeader),
    $consultaPaquetesMovilRequest as element(ns2:consultaPaquetesMovilRequest))
    as element(ns1:ConsultaPaquetesMoviles) {
        <ns1:ConsultaPaquetesMoviles>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentitacion/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <WSFICOPARAMPACKAGEType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaPaquetesMovilRequest/PHONE_CARRIER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOPARAMPACKAGEType>
        </ns1:ConsultaPaquetesMoviles>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaPaquetesMovilRequest as element(ns2:consultaPaquetesMovilRequest) external;

xf:consultaPaquetesMovilIn($requestHeader,
    $consultaPaquetesMovilRequest)