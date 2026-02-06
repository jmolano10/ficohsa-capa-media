xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalladaMovimientosCuenta" element="ns0:consultaDetalladaMovimientosCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Consultadetalladademovscuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalladaMovimientosCuenta/xq/consultaDetalladaMovimientosCuentaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

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
 
declare function xf:consultaDetalladaMovimientosCuentaIn($requestHeader as element(ns1:RequestHeader),
    $consultaDetalladaMovimientosCuenta as element(ns0:consultaDetalladaMovimientosCuenta),
    $endDate as xs:string,
    $beginDate as xs:string)
    as element(ns2:Consultadetalladademovscuenta) {
        <ns2:Consultadetalladademovscuenta>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
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
        </ns2:Consultadetalladademovscuenta>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $consultaDetalladaMovimientosCuenta as element(ns0:consultaDetalladaMovimientosCuenta) external;
declare variable $endDate as xs:string external;
declare variable $beginDate as xs:string external;

xf:consultaDetalladaMovimientosCuentaIn($requestHeader,
    $consultaDetalladaMovimientosCuenta,
    $endDate,
    $beginDate)