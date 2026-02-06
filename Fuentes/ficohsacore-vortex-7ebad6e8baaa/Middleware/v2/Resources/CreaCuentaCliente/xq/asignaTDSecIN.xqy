xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AsignacionTarjetaDebitoSec" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/asignaTDSecIN/";

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

declare function xf:asignaTDSecIN($requestHeader as element(ns1:RequestHeader),
    $Account as xs:string,
    $TypeCard as xs:string,
    $CardNumber as xs:string)
    as element(ns0:AsignacionTarjetaDebitoSec) {
        <ns0:AsignacionTarjetaDebitoSec>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <LATAMCARDORDERSCNDRYACCTWSType id = "{ concat($TypeCard ,'.', $CardNumber) }">
                <gACCTCCY>
                    <mACCTCCY>
                        <sgSCNDRYACCT>
                            <SecondaryAccount>{ $Account }</SecondaryAccount>
                        </sgSCNDRYACCT>
                    </mACCTCCY>
                </gACCTCCY>
            </LATAMCARDORDERSCNDRYACCTWSType>
        </ns0:AsignacionTarjetaDebitoSec>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $Account as xs:string external;
declare variable $TypeCard as xs:string external;
declare variable $CardNumber as xs:string external;

xf:asignaTDSecIN($requestHeader,
    $Account,
    $TypeCard,
    $CardNumber)