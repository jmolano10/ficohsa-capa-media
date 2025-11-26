(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaClienteporTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguroFacade/xq/consultaClienteTDIn/";

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


declare function xf:consultaClienteTDIn($debitCard as xs:string,
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:ConsultaClienteporTarjetaDebito) {
        <ns1:ConsultaClienteporTarjetaDebito>
            <WebRequestCommon>
            	<userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), data($requestHeader/Authentication/UserName)) }</userName>
				<password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)), data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOCARDINFOType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $debitCard }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOCARDINFOType>
        </ns1:ConsultaClienteporTarjetaDebito>
};

declare variable $debitCard as xs:string external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaClienteTDIn($debitCard,
    $requestHeader)