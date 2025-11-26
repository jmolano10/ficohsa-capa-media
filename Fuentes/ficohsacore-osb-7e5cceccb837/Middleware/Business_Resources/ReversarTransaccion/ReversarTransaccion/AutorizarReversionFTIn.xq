(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="reversarTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutorizacionreversionFT" location="../Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/AutorizarReversionFTIn/";

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
 
declare function xf:AutorizarReversionFTIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion))
    as element(ns0:AutorizacionreversionFT) {
        <ns0:AutorizacionreversionFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("UREVERSION"), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword("UREVERSION"),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                <transactionId>{ data($reversarTransaccion/TRANSACTION_ID) }</transactionId>
            </FUNDSTRANSFERREVERSEType>
        </ns0:AutorizacionreversionFT>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;

xf:AutorizarReversionFTIn($autenticacionRequestHeader,
    $reversarTransaccion)