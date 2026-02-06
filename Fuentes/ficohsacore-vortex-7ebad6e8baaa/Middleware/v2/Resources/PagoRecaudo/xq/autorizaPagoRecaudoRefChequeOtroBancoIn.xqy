xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagorecaudoreferenciadochqotrbcoResponse" element="ns0:PagorecaudoreferenciadochqotrbcoResponse" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Autorizacionpagorecaudorefobchq" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/Piloto/autorizacionPagoRecaudoReferenciadoChequeOtroBancoIn/";

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
 
declare function xf:autorizacionPagoRecaudoReferenciadoChequeOtroBancoIn($pagorecaudoreferenciadochqotrbcoResponse as element(ns0:PagorecaudoreferenciadochqotrbcoResponse))
    as element(ns0:Autorizacionpagorecaudorefobchq) {
        <ns0:Autorizacionpagorecaudorefobchq>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("SRV-ITAUTH"), 
												"SRV-ITAUTH_NOT_FOUND") }</userName>
                <password>{ fn-bea:fail-over( getPassword("SRV-ITAUTH"),
                								"") }</password>
            </WebRequestCommon>
            <TELLERLATAMREFOBCHQRESWSCOPYType>
                {
                    for $transactionId in $pagorecaudoreferenciadochqotrbcoResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </TELLERLATAMREFOBCHQRESWSCOPYType>
        </ns0:Autorizacionpagorecaudorefobchq>
};

declare variable $pagorecaudoreferenciadochqotrbcoResponse as element(ns0:PagorecaudoreferenciadochqotrbcoResponse) external;

xf:autorizacionPagoRecaudoReferenciadoChequeOtroBancoIn($pagorecaudoreferenciadochqotrbcoResponse)