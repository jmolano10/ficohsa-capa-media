xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns1:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/TransferenciasACH/xq/consDetalleCta/";
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

declare function xf:consDetalleCta($requestHeader1 as element(ns2:RequestHeader),
    $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>
                    { 
                    	if(data($transferenciasACHRequest1/LOCAL_ACCOUNT_TYPE) = "INDIRECT" ) then
                    		data($transferenciasACHRequest1/LOCAL_ORIGINAL_ACCOUNT)
                    	else
                    		data($transferenciasACHRequest1/DEBIT_ACCOUNT)
                    }
                    </criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest) external;

xf:consDetalleCta($requestHeader1,
    $transferenciasACHRequest1)