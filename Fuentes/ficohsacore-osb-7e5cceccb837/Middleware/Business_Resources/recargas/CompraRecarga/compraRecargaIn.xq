(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$compraRecarga" element="ns0:compraRecarga" location="compraRecargaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Compraderecargacondbcta" location="../Resources/XMLSchema_-1499734640.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recargas/CompraRecarga/compraRecargaIn/";

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

declare function xf:compraRecargaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $compraRecarga as element(ns0:compraRecarga),
    $uuid as xs:string)
    as element(ns1:Compraderecargacondbcta) {
        <ns1:Compraderecargacondbcta>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <FUNDSTRANSFERLATAMMOBRCHGWSType>
                <DEBITACCOUNT>{ data($compraRecarga/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <AMOUNT>{ data($compraRecarga/AMOUNT) }</AMOUNT>
                <LRAGCLIENTID>{ data($compraRecarga/SERVICE_PROVIDER_ID) }</LRAGCLIENTID>
                <LRREMITMOBILE>{ data($compraRecarga/PHONE_NUMBER) }</LRREMITMOBILE>
            </FUNDSTRANSFERLATAMMOBRCHGWSType>
        </ns1:Compraderecargacondbcta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $compraRecarga as element(ns0:compraRecarga) external;
declare variable $uuid as xs:string external;

xf:compraRecargaIn($autenticacionRequestHeader,
    $compraRecarga,
    $uuid)