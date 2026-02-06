xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesReserva" element="ns2:consultaChequesReserva" location="../../../../Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedetallesdelacuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequesReserva/xq/consultaChequesReservaConsultaDetalleCuentaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
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
 
declare function xf:consultaChequesReservaConsultaDetalleCuentaIn($requestHeader as element(ns0:RequestHeader),
    $consultaChequesReserva as element(ns2:consultaChequesReserva))
    as element(ns1:Consultadedetallesdelacuenta) {
        <ns1:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaChequesReserva/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns1:Consultadedetallesdelacuenta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaChequesReserva as element(ns2:consultaChequesReserva) external;

xf:consultaChequesReservaConsultaDetalleCuentaIn($requestHeader,
    $consultaChequesReserva)