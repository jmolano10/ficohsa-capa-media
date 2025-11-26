(:: pragma bea:global-element-parameter parameter="$pagorecaudoreferenciadoficochqResponse" element="ns0:PagorecaudoreferenciadoficochqResponse" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Autorizacionpagorecaudoreffichq" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/Piloto/autorizacionPagoRecaudoReferenciadoChequePropioIn/";

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
 
declare function xf:autorizacionPagoRecaudoReferenciadoChequePropioIn($pagorecaudoreferenciadoficochqResponse as element(ns0:PagorecaudoreferenciadoficochqResponse))
    as element(ns0:Autorizacionpagorecaudoreffichq) {
        <ns0:Autorizacionpagorecaudoreffichq>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("SRV-ITAUTH"), 
												"SRV-ITAUTH_NOT_FOUND") }</userName>
                <password>{ fn-bea:fail-over( getPassword("SRV-ITAUTH"),
                								"") }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERLATAMFICOREQCHQWSCOPYType>
                {
                    for $transactionId in $pagorecaudoreferenciadoficochqResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERLATAMFICOREQCHQWSCOPYType>
        </ns0:Autorizacionpagorecaudoreffichq>
};

declare variable $pagorecaudoreferenciadoficochqResponse as element(ns0:PagorecaudoreferenciadoficochqResponse) external;

xf:autorizacionPagoRecaudoReferenciadoChequePropioIn($pagorecaudoreferenciadoficochqResponse)