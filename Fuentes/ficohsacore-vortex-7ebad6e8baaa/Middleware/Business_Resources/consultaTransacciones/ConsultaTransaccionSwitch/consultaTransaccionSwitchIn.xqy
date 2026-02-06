xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionSwitch" element="ns1:consultaTransaccionSwitch" location="consultaTransaccionSwitchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetransaccionswitch" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchIn/";

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

declare function xf:consultaTransaccionSwitchIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaTransaccionSwitch as element(ns1:consultaTransaccionSwitch))
    as element(ns0:Consultadetransaccionswitch) {
        <ns0:Consultadetransaccionswitch>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSSWITCHTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>TXN.REF</columnName>
                    <criteriaValue>{ data($consultaTransaccionSwitch/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSSWITCHTRANSACTIONType>
        </ns0:Consultadetransaccionswitch>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaTransaccionSwitch as element(ns1:consultaTransaccionSwitch) external;

xf:consultaTransaccionSwitchIn($autenticacionRequestHeader,
    $consultaTransaccionSwitch)