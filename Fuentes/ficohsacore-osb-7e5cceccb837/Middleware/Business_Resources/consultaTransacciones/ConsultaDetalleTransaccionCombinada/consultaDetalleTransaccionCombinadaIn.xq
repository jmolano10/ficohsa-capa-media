(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccionCombinada1" element="ns0:consultaDetalleTransaccionCombinada" location="consultaDetalleTransaccionCombinadaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadetransaccionTFS" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionCombinadaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionCombinada/consultaDetalleTransaccionCombinadaIn/";

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

declare function xf:consultaDetalleTransaccionCombinadaIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaDetalleTransaccionCombinada1 as element(ns0:consultaDetalleTransaccionCombinada))
    as element(ns1:ConsultadetransaccionTFS) {
        <ns1:ConsultadetransaccionTFS>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSTFSTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaDetalleTransaccionCombinada1/TRANSACTION_REFERENCE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTFSTRANSACTIONType>
        </ns1:ConsultadetransaccionTFS>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDetalleTransaccionCombinada1 as element(ns0:consultaDetalleTransaccionCombinada) external;

xf:consultaDetalleTransaccionCombinadaIn($autenticacionRequestHeader1,
    $consultaDetalleTransaccionCombinada1)