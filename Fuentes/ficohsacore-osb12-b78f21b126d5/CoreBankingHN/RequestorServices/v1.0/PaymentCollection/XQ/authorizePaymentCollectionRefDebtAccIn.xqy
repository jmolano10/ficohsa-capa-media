xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $paymentCollectionRefDebtAccResponse as element() (:: schema-element(ns1:PagoderecaudoreferenciadodbctaResponse) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($paymentCollectionRefDebtAccResponse as element() (:: schema-element(ns1:PagoderecaudoreferenciadodbctaResponse) ::)) as element() (:: schema-element(ns1:Autorizacionpagorecaudorefdbcta) ::) {
    <ns1:Autorizacionpagorecaudorefdbcta>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername("SRV-ITAUTH"), 
												"SRV-ITAUTH_NOT_FOUND") }</userName>
                <password>{ fn-bea:fail-over( local:getPassword("SRV-ITAUTH"),
                								"") }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                {
                    for $transactionId in $paymentCollectionRefDebtAccResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
    </ns1:Autorizacionpagorecaudorefdbcta>
};

local:func($paymentCollectionRefDebtAccResponse)