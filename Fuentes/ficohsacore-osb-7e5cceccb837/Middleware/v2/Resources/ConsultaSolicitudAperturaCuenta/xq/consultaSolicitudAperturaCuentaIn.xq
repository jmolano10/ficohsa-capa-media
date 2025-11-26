(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudAperturaCuenta" element="ns2:consultaSolicitudAperturaCuenta" location="../xsd/consultaSolicitudAperturaCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaCuentaAperturada" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudAperturaCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudAperturaCuenta/xq/consultaSolicitudAperturaCuentaIn/";

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

declare function xf:consultaSolicitudAperturaCuentaIn($requestHeader as element(ns0:RequestHeader),
    $consultaSolicitudAperturaCuenta as element(ns2:consultaSolicitudAperturaCuenta))
    as element(ns1:ConsultaCuentaAperturada) {
        <ns1:ConsultaCuentaAperturada>
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
            <FICOBULKAPPACCTWSType>
                <enquiryInputCollection>
                	<columnName>{ '@ID' }</columnName>
                    <criteriaValue>{ concat(fn:string(data($consultaSolicitudAperturaCuenta/COD_ID)),"*1") }</criteriaValue>
                    <operand>{ 'EQ' }</operand>
                </enquiryInputCollection>
            </FICOBULKAPPACCTWSType>
        </ns1:ConsultaCuentaAperturada>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaSolicitudAperturaCuenta as element(ns2:consultaSolicitudAperturaCuenta) external;

xf:consultaSolicitudAperturaCuentaIn($requestHeader,
    $consultaSolicitudAperturaCuenta)
