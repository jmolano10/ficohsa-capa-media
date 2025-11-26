xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1855765488.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $status1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

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


declare function xq:eliminaRemFtIn($status1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::), 
                                   $userName as xs:string, 
                                   $password as xs:string) 
                                   as element() (:: schema-element(ns1:ReversionPagoRemesaFT) ::) {
    <ns1:ReversionPagoRemesaFT>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <FUNDSTRANSFERREVERSEREMITTANCEType>
            <transactionId>{fn:data($status1/*:Status/*:transactionId)}</transactionId>
        </FUNDSTRANSFERREVERSEREMITTANCEType>
    </ns1:ReversionPagoRemesaFT>
};

xq:eliminaRemFtIn($status1, $userName, $password)
