(:: pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadodbctaResponse" element="ns0:PagoderecaudoreferenciadodbctaResponse" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Autorizacionpagorecaudorefdbcta" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/Piloto/autorizacionPagoRecaudoReferenciadoDebitoCuentaIn/";

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
 
declare function xf:autorizacionPagoRecaudoReferenciadoDebitoCuentaIn($pagoderecaudoreferenciadodbctaResponse as element(ns0:PagoderecaudoreferenciadodbctaResponse))
    as element(ns0:Autorizacionpagorecaudorefdbcta) {
        <ns0:Autorizacionpagorecaudorefdbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("SRV-ITAUTH"), 
												"SRV-ITAUTH_NOT_FOUND") }</userName>
                <password>{ fn-bea:fail-over( getPassword("SRV-ITAUTH"),
                								"") }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                {
                    for $transactionId in $pagoderecaudoreferenciadodbctaResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
        </ns0:Autorizacionpagorecaudorefdbcta>
};

declare variable $pagoderecaudoreferenciadodbctaResponse as element(ns0:PagoderecaudoreferenciadodbctaResponse) external;

xf:autorizacionPagoRecaudoReferenciadoDebitoCuentaIn($pagoderecaudoreferenciadodbctaResponse)