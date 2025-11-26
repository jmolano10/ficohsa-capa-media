(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalladaMovimientosCuenta" element="ns1:consultaDetalladaMovimientosCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetalladademovscuenta" location="../Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaIn/";

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

declare function xf:consultaDetalladaMovimientosCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaDetalladaMovimientosCuenta as element(ns1:consultaDetalladaMovimientosCuenta),
    $endDate as xs:string,
    $beginDate as xs:string)
    as element(ns0:Consultadetalladademovscuenta) {
        <ns0:Consultadetalladademovscuenta>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>        
            <WSFICOESTMTGIVENDATESDETType>
                <enquiryInputCollection>
                    <columnName>ACCOUNT.NO</columnName>
                    <criteriaValue>{ data($consultaDetalladaMovimientosCuenta/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
				<enquiryInputCollection>
					<columnName>START.DATE</columnName>
					<criteriaValue>{$beginDate}</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>
				<enquiryInputCollection>
					<columnName>END.DATE</columnName>
					<criteriaValue>{$endDate}</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>                    
            </WSFICOESTMTGIVENDATESDETType>
        </ns0:Consultadetalladademovscuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDetalladaMovimientosCuenta as element(ns1:consultaDetalladaMovimientosCuenta) external;
declare variable $endDate as xs:string external;
declare variable $beginDate as xs:string external;

xf:consultaDetalladaMovimientosCuentaIn($autenticacionRequestHeader,
    $consultaDetalladaMovimientosCuenta,
    $endDate,
    $beginDate)