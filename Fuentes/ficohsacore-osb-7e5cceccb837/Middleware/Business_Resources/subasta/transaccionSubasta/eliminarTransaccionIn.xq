(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EliminaciondetransaccionFTihld" location="../../ReversarTransaccion/Resources/XMLSchema_-193201527.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/eliminarTransaccionIn/";

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

declare function xf:eliminarTransaccionIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $status as element())
    as element(ns0:EliminaciondetransaccionFTihld) {
        <ns0:EliminaciondetransaccionFTihld>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEType>
                {
                    for $transactionId in $status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREVERSEType>
        </ns0:EliminaciondetransaccionFTihld>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $status as element() external;

xf:eliminarTransaccionIn($autenticacionRequestHeader,
    $status)