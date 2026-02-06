xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:AutorizacionreversionFT" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaFinanciamientoTC/xq/autorizarTransfEntreCuentasIn/";

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
 
declare function xf:autorizarTransfEntreCuentasIn($TRANSACTION_ID as xs:string,
    $USER as xs:string)
    as element(ns0:AutorizacionreversionFT) {
        <ns0:AutorizacionreversionFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($USER)), 
												data($USER)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($USER)),
                								'') }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                <transactionId>{ $TRANSACTION_ID }</transactionId>
            </FUNDSTRANSFERREVERSEType>
        </ns0:AutorizacionreversionFT>
};

declare variable $TRANSACTION_ID as xs:string external;
declare variable $USER as xs:string external;

xf:autorizarTransfEntreCuentasIn($TRANSACTION_ID,
    $USER)