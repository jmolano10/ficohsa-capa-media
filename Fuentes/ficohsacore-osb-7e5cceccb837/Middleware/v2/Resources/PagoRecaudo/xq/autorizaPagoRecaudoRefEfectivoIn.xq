(:: pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadoefecResponse" element="ns0:PagoderecaudoreferenciadoefecResponse" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Autorizacionpagorecaudorefefec" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/Piloto/autorizacionPagoRecaudoReferenciadoEfectivoIn/";

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

declare function xf:autorizacionPagoRecaudoReferenciadoEfectivoIn($pagoderecaudoreferenciadoefecResponse as element(ns0:PagoderecaudoreferenciadoefecResponse))
    as element(ns0:Autorizacionpagorecaudorefefec) {
        <ns0:Autorizacionpagorecaudorefefec>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("SRV-ITAUTH"), 
												"SRV-ITAUTH_NOT_FOUND") }</userName>
                <password>{ fn-bea:fail-over( getPassword("SRV-ITAUTH"),
                								"") }</password>
            </WebRequestCommon>
            <TELLERREFCOLLCASHWSCOPYType>
                {
                    for $transactionId in $pagoderecaudoreferenciadoefecResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </TELLERREFCOLLCASHWSCOPYType>
        </ns0:Autorizacionpagorecaudorefefec>
};

declare variable $pagoderecaudoreferenciadoefecResponse as element(ns0:PagoderecaudoreferenciadoefecResponse) external;

xf:autorizacionPagoRecaudoReferenciadoEfectivoIn($pagoderecaudoreferenciadoefecResponse)