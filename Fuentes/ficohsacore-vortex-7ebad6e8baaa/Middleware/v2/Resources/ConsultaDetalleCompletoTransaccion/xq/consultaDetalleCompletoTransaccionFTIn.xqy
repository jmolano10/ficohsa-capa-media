xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns2:consultaDetalleCompletoTransaccion" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadetransaccionFT" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleCompletoTransaccion/xq/consultaDetalleCompletoTransaccionFTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
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
 
declare function xf:consultaDetalleCompletoTransaccionFTIn($requestHeader as element(ns0:RequestHeader),
    $consultaDetalleCompletoTransaccion as element(ns2:consultaDetalleCompletoTransaccion))
    as element(ns1:ConsultadetransaccionFT) {
        <ns1:ConsultadetransaccionFT>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFTTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFTTRANSACTIONType>
        </ns1:ConsultadetransaccionFT>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaDetalleCompletoTransaccion as element(ns2:consultaDetalleCompletoTransaccion) external;

xf:consultaDetalleCompletoTransaccionFTIn($requestHeader,
    $consultaDetalleCompletoTransaccion)