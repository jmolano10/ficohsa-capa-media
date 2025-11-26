(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$listaFicoAlertaProducto" element="ns1:listaFicoAlertaProducto" location="listaFicoAlertaProductoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ListadeFicoAlertasporproducto" location="../Resources/XMLSchema_1876963756.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaFicoAlertaProductoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ListaFicoAlertaProducto/listaFicoAlertaProductoIn/";

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

declare function xf:listaFicoAlertaProductoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $listaFicoAlertaProducto as element(ns1:listaFicoAlertaProducto))
    as element(ns0:ListadeFicoAlertasporproducto) {
        <ns0:ListadeFicoAlertasporproducto>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSACCOUNTALERTSType>
                <enquiryInputCollection>
                    <columnName>CONTRACT.REF</columnName>
                    <criteriaValue>{ data($listaFicoAlertaProducto/PRODUCT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	let $EVENT := fn:string($listaFicoAlertaProducto/EVENT/text())
                	return
                		if ($EVENT != "") then (
			                <enquiryInputCollection>
			                    <columnName>EVENT</columnName>
			                    <criteriaValue>{ $EVENT }</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
                		) else ()
                }
                {
                	let $ACTIVE_ALERTS_YES_NO := fn:string($listaFicoAlertaProducto/ACTIVE_ALERTS_YES_NO/text())
                	return
                		if ($ACTIVE_ALERTS_YES_NO != "") then (
			                <enquiryInputCollection>
			                    <columnName>SUBSCRIBE</columnName>
			                    <criteriaValue>{ $ACTIVE_ALERTS_YES_NO }</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
                		) else ()
                }                
            </WSACCOUNTALERTSType>
        </ns0:ListadeFicoAlertasporproducto>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $listaFicoAlertaProducto as element(ns1:listaFicoAlertaProducto) external;

xf:listaFicoAlertaProductoIn($autenticacionRequestHeader,
    $listaFicoAlertaProducto)