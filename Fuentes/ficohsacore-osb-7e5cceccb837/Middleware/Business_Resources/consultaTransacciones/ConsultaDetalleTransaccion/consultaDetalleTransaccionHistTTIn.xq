(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccion" element="ns1:consultaDetalleTransaccion" location="consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionhistTT" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionHistTTIn/";

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

declare function xf:consultaDetalleTransaccionHistTTIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaDetalleTransaccion as element(ns1:consultaDetalleTransaccion))
    as element(ns0:ConsultadetransaccionhistTT) {
        <ns0:ConsultadetransaccionhistTT>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSTTTRANSACTIONHISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat($consultaDetalleTransaccion/TRANSACTION_REFERENCE, ";1") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTTTRANSACTIONHISTType>
        </ns0:ConsultadetransaccionhistTT>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDetalleTransaccion as element(ns1:consultaDetalleTransaccion) external;

xf:consultaDetalleTransaccionHistTTIn($autenticacionRequestHeader,
    $consultaDetalleTransaccion)