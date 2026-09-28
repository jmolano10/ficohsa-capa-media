(:: pragma bea:global-element-return element="ns0:AutorizacionreversionFT" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/TransferenciasACH/xq/autorizaFtIn/";

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
 
declare function xf:autorizaFtIn($usuarioAut as xs:string,
    $passAutorizador as xs:string,
    $trxFT as xs:string)
    as element(ns0:AutorizacionreversionFT) {
        <ns0:AutorizacionreversionFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($usuarioAut), $usuarioAut) }</userName>
                <password>{ fn-bea:fail-over( getPassword($usuarioAut),$passAutorizador ) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                <transactionId>{ $trxFT }</transactionId>
            </FUNDSTRANSFERREVERSEType>
        </ns0:AutorizacionreversionFT>
};

declare variable $usuarioAut as xs:string external;
declare variable $passAutorizador as xs:string external;
declare variable $trxFT as xs:string external;

xf:autorizaFtIn($usuarioAut,
    $passAutorizador,
    $trxFT)