xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaDebitoRelieve" element="ns2:solicitudTarjetaDebitoRelieve" location="../xsd/solicitudTarjetaDebitoRelieveTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaSecuenciaTDconRelieve" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaDebitoRelieveTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTarjetaDebitoRelieve/xq/consultaSecuenciaTDconRelieveIn/";

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

declare function xf:consultaSecuenciaTDconRelieveIn($requestHeader as element(ns0:RequestHeader),
    $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve))
    as element(ns1:ConsultaSecuenciaTDconRelieve) {
        <ns1:ConsultaSecuenciaTDconRelieve>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOHNDEBITCARDCOUNTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat($solicitudTarjetaDebitoRelieve/CUSTOMER_CODE , '.' , $solicitudTarjetaDebitoRelieve/CARD_TYPE) }</criteriaValue>
                    <operand>BW</operand>
                </enquiryInputCollection>
            </WSFICOHNDEBITCARDCOUNTType>
        </ns1:ConsultaSecuenciaTDconRelieve>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve) external;

xf:consultaSecuenciaTDconRelieveIn($requestHeader,
    $solicitudTarjetaDebitoRelieve)