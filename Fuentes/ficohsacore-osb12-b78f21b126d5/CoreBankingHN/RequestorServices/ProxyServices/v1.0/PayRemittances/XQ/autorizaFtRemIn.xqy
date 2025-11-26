xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-193201527.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $usuarioAut as xs:string external;
declare variable $passAut as xs:string external;
declare variable $transactionId as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string {
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xq:autorizaFtRemIn($usuarioAut as xs:string,
                                    $passAut as xs:string,
                                    $pagoderemesaFTResponse1 as xs:string)
                                    as element() (:: schema-element(ns1:AutorizacionreversionFT) ::) {
    <ns1:AutorizacionreversionFT>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername('SRV-ITAUTH'),data($usuarioAut)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword('SRV-ITAUTH'),data($passAut)) }</password>
        </WebRequestCommon>
        <FUNDSTRANSFERREVERSEType>
            <transactionId>{$transactionId}</transactionId>
        </FUNDSTRANSFERREVERSEType>
    </ns1:AutorizacionreversionFT>
};

xq:autorizaFtRemIn($usuarioAut, $passAut, $transactionId)
