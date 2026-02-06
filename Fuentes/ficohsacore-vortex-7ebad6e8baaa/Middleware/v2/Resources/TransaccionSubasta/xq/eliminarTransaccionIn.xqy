xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$status" type="ns1:Status" location="../../../../Business_Resources/subasta/Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EliminaciondetransaccionFTihld" location="../../../../Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionSubasta/xq/eliminarTransaccionIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:eliminarTransaccionIn($requestHeader as element(ns0:RequestHeader),
    $status as element())
    as element(ns1:EliminaciondetransaccionFTihld) {
        <ns1:EliminaciondetransaccionFTihld>
             <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                {
                    for $transactionId in $status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREVERSEType>
        </ns1:EliminaciondetransaccionFTihld>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $status as element() external;

xf:eliminarTransaccionIn($requestHeader,
    $status)