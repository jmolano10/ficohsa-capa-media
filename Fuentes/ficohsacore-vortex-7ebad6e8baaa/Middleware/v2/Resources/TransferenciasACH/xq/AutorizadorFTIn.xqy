xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:AutorizacionTransfACH" location="../../../BusinessServices/T24/autorizaciones/xsd/XMLSchema_-1772015710.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/AutorizadorFTIn/";
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


declare function xf:AutorizadorFTIn($TransFT as xs:string,
    $Username as xs:string,
    $Password as xs:string)
    as element(ns0:AutorizacionTransfACH) {
        <ns0:AutorizacionTransfACH>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername($Username), $Username) }</userName>
                <password>{ fn-bea:fail-over(getPassword($Username), $Password) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERFICOHACHORIGINATIONType>
                <transactionId>{ $TransFT }</transactionId>
            </FUNDSTRANSFERFICOHACHORIGINATIONType>
        </ns0:AutorizacionTransfACH>
};

declare variable $TransFT as xs:string external;
declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

xf:AutorizadorFTIn($TransFT,
    $Username,
    $Password)