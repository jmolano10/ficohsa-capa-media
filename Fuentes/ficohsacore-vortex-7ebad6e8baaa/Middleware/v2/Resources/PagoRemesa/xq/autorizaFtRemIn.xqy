xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaFTResponse1" element="ns0:PagoderemesaFTResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutorizacionreversionFT" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/autorizaFtRemIn/";

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

declare function xf:autorizaFtRemIn($pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse),
    $usuarioAut as xs:string,
    $passAut as xs:string)
    as element(ns0:AutorizacionreversionFT) {
        <ns0:AutorizacionreversionFT>
        	<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($usuarioAut), $usuarioAut) }</userName>
                <password>{ fn-bea:fail-over( getPassword($usuarioAut),$passAut ) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                {
                    for $transactionId in $pagoderemesaFTResponse1/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREVERSEType>
        </ns0:AutorizacionreversionFT>
};

declare variable $pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse) external;
declare variable $usuarioAut as xs:string external;
declare variable $passAut as xs:string external;

xf:autorizaFtRemIn($pagoderemesaFTResponse1,
    $usuarioAut,
    $passAut)