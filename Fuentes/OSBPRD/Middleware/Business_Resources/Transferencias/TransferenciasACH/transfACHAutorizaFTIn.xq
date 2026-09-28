(:: pragma bea:global-element-return element="ns0:AutorizacionTransfACH" location="../../../v2/BusinessServices/T24/autorizaciones/xsd/XMLSchema_-1772015710.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasACH/transfACHAutorizaFTIn/";

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

declare function xf:transfACHAutorizaFTIn($authorizer as xs:string,
    $transactionId as xs:string)
    as element(ns0:AutorizacionTransfACH) {
        <ns0:AutorizacionTransfACH>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($authorizer),$authorizer) }</userName>
                <password>{ fn-bea:fail-over( getPassword($authorizer),"") }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERFICOHACHORIGINATIONType>
                <transactionId>{ $transactionId }</transactionId>
            </FUNDSTRANSFERFICOHACHORIGINATIONType>
        </ns0:AutorizacionTransfACH>
};

declare variable $authorizer as xs:string external;
declare variable $transactionId as xs:string external;

xf:transfACHAutorizaFTIn($authorizer,
    $transactionId)