(:: pragma bea:global-element-return element="ns0:AutorizacionreversionTT" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeDepositoGarantia/autorizaReversionRetiro/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:autorizaReversionRetiro($UserName as xs:string,
    $Password as xs:string,
    $TransactionID as xs:string)
    as element(ns0:AutorizacionreversionTT) {
        <ns0:AutorizacionreversionTT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("UREVERSION"), $UserName) }</userName>
                <password>{ fn-bea:fail-over( getPassword("UREVERSION"), $Password) }</password>
            </WebRequestCommon>
            <TELLERREVERSEType>
                <transactionId>{ $TransactionID }</transactionId>
            </TELLERREVERSEType>
        </ns0:AutorizacionreversionTT>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $TransactionID as xs:string external;

xf:autorizaReversionRetiro($UserName,
    $Password,
    $TransactionID)
