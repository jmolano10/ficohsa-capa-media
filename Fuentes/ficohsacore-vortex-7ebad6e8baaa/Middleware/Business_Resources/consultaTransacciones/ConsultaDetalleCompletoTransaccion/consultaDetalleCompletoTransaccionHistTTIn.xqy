xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadetransaccionhistTT" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionHistTTIn/";

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

declare function xf:consultaDetalleCompletoTransaccionHistTTIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as element(ns1:ConsultadetransaccionhistTT) {
        <ns1:ConsultadetransaccionhistTT>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSTTTRANSACTIONHISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE, ";1") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTTTRANSACTIONHISTType>
        </ns1:ConsultadetransaccionhistTT>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:consultaDetalleCompletoTransaccionHistTTIn($autenticacionRequestHeader,
    $consultaDetalleCompletoTransaccion)