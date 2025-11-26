(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionACH" element="ns2:consultaTransaccionACH" location="../xsd/consultaTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaACHDebito" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/consultaTransaccionACHDebitoIn/";

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
 
declare function getT24CriteriaType ($getT24CriteriaType as xs:string)  as xs:string { 
	if ($getT24CriteriaType = "MESSAGEID") then (
        "GLOBAL.REFERENCE"
	)  else (
		"LEGEND.BANK.ISSUER"
	)
 };
 
declare function xf:consultaTransaccionACHDebitoIn($requestHeader as element(ns0:RequestHeader),
    $consultaTransaccionACH as element(ns2:consultaTransaccionACH))
    as element(ns1:ConsultaACHDebito) {
        <ns1:ConsultaACHDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSACHDEBITOSType>
                <enquiryInputCollection>
                    <columnName>{ getT24CriteriaType(data($consultaTransaccionACH/SEARCH_CRITERIA)) }</columnName>
                    <criteriaValue>{ data($consultaTransaccionACH/SEARCH_VALUE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACHDEBITOSType>
        </ns1:ConsultaACHDebito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaTransaccionACH as element(ns2:consultaTransaccionACH) external;

xf:consultaTransaccionACHDebitoIn($requestHeader,
    $consultaTransaccionACH)