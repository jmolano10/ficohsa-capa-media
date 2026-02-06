xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$desbloqueoFondosCuenta" element="ns2:desbloqueoFondosCuenta" location="../xsd/desbloqueoFondosCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Desbloqueodefondosdepasivos" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesbloqueoFondosCuenta/xq/desbloqueoFondosCuentaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:desbloqueoFondosCuentaIn($requestHeader as element(ns0:RequestHeader),
    $desbloqueoFondosCuenta as element(ns2:desbloqueoFondosCuenta))
    as element(ns1:Desbloqueodefondosdepasivos) {
        <ns1:Desbloqueodefondosdepasivos>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <ACLOCKEDEVENTSINPUTWSType>
                {
                    for $LOCK_ID in $desbloqueoFondosCuenta/LOCK_ID
                    return
                    	if($LOCK_ID != "") then (
                        	<transactionId>{ data($LOCK_ID) }</transactionId>
                        ) else ()
                }
            </ACLOCKEDEVENTSINPUTWSType>
        </ns1:Desbloqueodefondosdepasivos>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $desbloqueoFondosCuenta as element(ns2:desbloqueoFondosCuenta) external;

xf:desbloqueoFondosCuentaIn($requestHeader,
    $desbloqueoFondosCuenta)