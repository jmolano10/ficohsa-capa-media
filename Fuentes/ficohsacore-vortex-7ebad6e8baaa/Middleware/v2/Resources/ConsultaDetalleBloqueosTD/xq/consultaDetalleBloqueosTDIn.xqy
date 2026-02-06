xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleBloqueosTD" element="ns1:consultaDetalleBloqueosTD" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadebloqueosporTD" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleBloqueosTD/xq/consultaDetalleBloqueosTDIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace ns0 = "T24WebServicesImpl";

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
 
declare function xf:consultaDetalleBloqueosTDIn($requestHeader as element(ns2:RequestHeader),
    $consultaDetalleBloqueosTD as element(ns1:consultaDetalleBloqueosTD))
    as element(ns0:ConsultadebloqueosporTD) {
        <ns0:ConsultadebloqueosporTD>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOECUSTPOSVISATXNSType>
                <enquiryInputCollection>
                    <columnName>ACCOUNT.NUMBER</columnName>
                    <criteriaValue>{ data($consultaDetalleBloqueosTD/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
               		<columnName>NATURE.OF.TXN</columnName>
               		<criteriaValue>ATM POS</criteriaValue>
               		<operand>EQ</operand>
            	</enquiryInputCollection>
            </WSFICOECUSTPOSVISATXNSType>
        </ns0:ConsultadebloqueosporTD>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaDetalleBloqueosTD as element(ns1:consultaDetalleBloqueosTD) external;

xf:consultaDetalleBloqueosTDIn($requestHeader,
    $consultaDetalleBloqueosTD)