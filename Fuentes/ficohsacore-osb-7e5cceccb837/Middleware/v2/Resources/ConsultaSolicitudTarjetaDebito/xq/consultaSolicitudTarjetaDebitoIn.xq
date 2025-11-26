(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudTarjetaDebito" element="ns2:consultaSolicitudTarjetaDebito" location="../xsd/consultaSolicitudTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaTDNueva" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudTarjetaDebitoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/IntegrationFramework/consultaSolicitudTarjetaDebitoIn/";

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

declare function xf:consultaSolicitudTarjetaDebitoIn($requestHeader as element(ns0:RequestHeader),
    $consultaSolicitudTarjetaDebito as element(ns2:consultaSolicitudTarjetaDebito))
    as element(ns1:ConsultaTDNueva) {
        <ns1:ConsultaTDNueva>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <FICOBULKAPPTDWSType>
                <enquiryInputCollection>
                    <columnName>{ '@ID' }</columnName>
                    <criteriaValue>{ concat(fn:string(data($consultaSolicitudTarjetaDebito/COD_ID)),"*1") }</criteriaValue>
                    <operand>{ 'EQ' }</operand>
                </enquiryInputCollection>
            </FICOBULKAPPTDWSType>
        </ns1:ConsultaTDNueva>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaSolicitudTarjetaDebito as element(ns2:consultaSolicitudTarjetaDebito) external;

xf:consultaSolicitudTarjetaDebitoIn($requestHeader,
    $consultaSolicitudTarjetaDebito)