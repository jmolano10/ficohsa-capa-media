(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$eliminarDeudores" element="ns0:eliminarDeudores" location="eliminarDeudoresTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedeudores" location="../Resources/XMLSchema_-2146193603.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/eliminarDeudoresTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/eliminarDeudores/consultaDeudorIn/";

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

declare function xf:consultaDeudorIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $eliminarDeudores as element(ns0:eliminarDeudores))
    as element(ns1:Consultadedeudores) {
        <ns1:Consultadedeudores>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSDEBTORLISTType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($eliminarDeudores/COLLECTION_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
	               <columnName>DEBTOR.CODE</columnName>
	               <criteriaValue>{ data($eliminarDeudores/DEBTOR_CODE) }</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
            </WSDEBTORLISTType>            
        </ns1:Consultadedeudores>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $eliminarDeudores as element(ns0:eliminarDeudores) external;

xf:consultaDeudorIn($autenticacionRequestHeader,
    $eliminarDeudores)