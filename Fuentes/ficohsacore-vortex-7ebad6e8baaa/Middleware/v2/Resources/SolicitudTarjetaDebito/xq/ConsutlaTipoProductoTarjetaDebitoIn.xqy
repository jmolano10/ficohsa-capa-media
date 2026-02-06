xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaDebito" element="ns0:solicitudTarjetaDebito" location="../xsd/solicitudTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultarEstadoTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaDebitoTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTarjetaDebito/xq/ConsutlaTipoProductoTarjetaDebitoIn/";

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
 
declare function xf:ConsutlaTipoProductoTarjetaDebitoIn($requestHeader as element(ns1:RequestHeader),
    $solicitudTarjetaDebito as element(ns0:solicitudTarjetaDebito))
    as element(ns2:ConsultarEstadoTarjetaDebito) {
        <ns2:ConsultarEstadoTarjetaDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOHDEBITCARDSTATUSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($solicitudTarjetaDebito/CARD_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOHDEBITCARDSTATUSType>
        </ns2:ConsultarEstadoTarjetaDebito>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $solicitudTarjetaDebito as element(ns0:solicitudTarjetaDebito) external;

xf:ConsutlaTipoProductoTarjetaDebitoIn($requestHeader,
    $solicitudTarjetaDebito)