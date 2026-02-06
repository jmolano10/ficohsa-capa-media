xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns2:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ReversionpagooretiroTC" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooRetiroTCIn/";

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

declare function xf:ReversarTransaccionPagooRetiroTCIn($requestHeader as element(ns0:RequestHeader),
    $reversarTransaccion as element(ns2:reversarTransaccion),
    $uuid as xs:string)
    as element(ns1:ReversionpagoTC) {
        <ns1:ReversionpagoTC>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOCCARDPAYMENTREVType id = "{ data($reversarTransaccion/TRANSACTION_ID) }"/>
        </ns1:ReversionpagoTC>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $reversarTransaccion as element(ns2:reversarTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversarTransaccionPagooRetiroTCIn($requestHeader,
    $reversarTransaccion,
    $uuid)