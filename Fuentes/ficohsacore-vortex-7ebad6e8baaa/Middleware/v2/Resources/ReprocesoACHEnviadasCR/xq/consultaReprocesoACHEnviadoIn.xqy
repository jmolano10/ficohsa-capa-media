xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaReprocesoACHEnviado" location="../../../BusinessServices/ACH/Enviado/SvcACHEnviado/xsd/XMLSchema_-1255526967.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/consultaReprocesoACHEnviadoIn/";

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

declare function xf:consultaReprocesoACHEnviadoIn($requestHeader1 as element(ns1:RequestHeader),
    $transactionId as xs:string)
    as element(ns0:ConsultaReprocesoACHEnviado) {
        <ns0:ConsultaReprocesoACHEnviado>
        	<WebRequestCommon>
                <userName>
	                {
	                    fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/UserName))
	                }
				</userName>
                <password>
	                {
	                    fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/Password))
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
        </ns0:ConsultaReprocesoACHEnviado>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $transactionId as xs:string external;

xf:consultaReprocesoACHEnviadoIn($requestHeader1,
    $transactionId)