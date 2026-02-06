xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns2:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AutorizacionreversionFT" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccion/xq/AutorizarReversionFTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
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
 
declare function xf:AutorizarReversionFTIn($requestHeader as element(ns0:RequestHeader),
    $reversarTransaccion as element(ns2:reversarTransaccion))
    as element(ns1:AutorizacionreversionFT) {
        <ns1:AutorizacionreversionFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("UREVERSION"), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword("UREVERSION"),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                <transactionId>{ data($reversarTransaccion/TRANSACTION_ID) }</transactionId>
            </FUNDSTRANSFERREVERSEType>
        </ns1:AutorizacionreversionFT>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $reversarTransaccion as element(ns2:reversarTransaccion) external;

xf:AutorizarReversionFTIn($requestHeader,
    $reversarTransaccion)