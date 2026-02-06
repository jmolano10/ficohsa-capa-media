xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionACH1" element="ns0:consultaTransaccionACH" location="../xsd/consultaTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadeTxnACHRecibida" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/consultaTransaccionACHIn/";

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

declare function xf:consultaTransaccionACHIn($requestHeader as element(ns2:RequestHeader),
    $consultaTransaccionACH1 as element(ns0:consultaTransaccionACH))
    as element(ns1:ConsultadeTxnACHRecibida) {
        <ns1:ConsultadeTxnACHRecibida>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSACHINCOMINGType>
                <enquiryInputCollection>
                    <columnName>{ getT24CriteriaType(data($consultaTransaccionACH1/SEARCH_CRITERIA)) }</columnName>
                    <criteriaValue>{ data($consultaTransaccionACH1/SEARCH_VALUE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACHINCOMINGType>
        </ns1:ConsultadeTxnACHRecibida>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaTransaccionACH1 as element(ns0:consultaTransaccionACH) external;

xf:consultaTransaccionACHIn($requestHeader,
    $consultaTransaccionACH1)