xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultatxnreprocesoACHEnviadas" location="../../../BusinessServices/ACH/Enviado/SvcACHConsultas/xsd/XMLSchema_814484778.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/consultaTxnReprocesoACHEnviadasIn/";

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

declare function xf:consultaTxnReprocesoACHEnviadasIn($requestHeader as element(ns0:RequestHeader),
    $transactionId as xs:string)
    as element(ns1:ConsultatxnreprocesoACHEnviadas) {
        <ns1:ConsultatxnreprocesoACHEnviadas>
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
            <WSACHOUTGOINGREPROCESSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $transactionId }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACHOUTGOINGREPROCESSType>
        </ns1:ConsultatxnreprocesoACHEnviadas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transactionId as xs:string external;

xf:consultaTxnReprocesoACHEnviadasIn($requestHeader,
    $transactionId)