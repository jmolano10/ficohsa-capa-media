(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion1" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadetransaccionPD" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionPDIn/";

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

declare function xf:consultaDetalleCompletoTransaccionPDIn($consultaDetalleCompletoTransaccion1 as element(ns0:consultaDetalleCompletoTransaccion),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns1:ConsultadetransaccionPD) {
        <ns1:ConsultadetransaccionPD>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <FICOHNPDBALANCESVIRTUALType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaDetalleCompletoTransaccion1/TRANSACTION_REFERENCE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOHNPDBALANCESVIRTUALType>
        </ns1:ConsultadetransaccionPD>
};

declare variable $consultaDetalleCompletoTransaccion1 as element(ns0:consultaDetalleCompletoTransaccion) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:consultaDetalleCompletoTransaccionPDIn($consultaDetalleCompletoTransaccion1,
    $autenticacionRequestHeader1)