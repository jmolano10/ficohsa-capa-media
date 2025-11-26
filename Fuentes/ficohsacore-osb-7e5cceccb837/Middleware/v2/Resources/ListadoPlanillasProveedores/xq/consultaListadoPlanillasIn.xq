(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$listadoPlanillasProveedores" element="ns2:listadoPlanillasProveedores" location="../xsd/listadoPlanillasProveedoresTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaListadoGrupoPlanilla" location="../../../../Business_Resources/listadoPlanillasProveedores/Resources/XMLSchema_596884079.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/listadoPlanillasProveedoresTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListadoPlanillasProveedores/xq/consultaListadoPlanillasIn/";

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

declare function xf:consultaListadoPlanillasIn($requestHeader as element(ns0:RequestHeader),
    $listadoPlanillasProveedores as element(ns2:listadoPlanillasProveedores))
    as element(ns1:ConsultaListadoGrupoPlanilla) {
        <ns1:ConsultaListadoGrupoPlanilla>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            	<WSPAYROLLGROUPType>
	                <enquiryInputCollection>
	                    <columnName>COMPANY.ID</columnName>
	                    <criteriaValue>{ data($listadoPlanillasProveedores/CONTRACT_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
	                <enquiryInputCollection>
	                    <columnName>CUST.CODE</columnName>
	                    <criteriaValue>{ data($listadoPlanillasProveedores/CUSTOMER_COMPANY_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
	                <enquiryInputCollection>
	                    <columnName>PRG.CODE</columnName>
	                    <criteriaValue>{ data($listadoPlanillasProveedores/PAYROLL_GROUP_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
            	</WSPAYROLLGROUPType>
        </ns1:ConsultaListadoGrupoPlanilla>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $listadoPlanillasProveedores as element(ns2:listadoPlanillasProveedores) external;

xf:consultaListadoPlanillasIn($requestHeader,
    $listadoPlanillasProveedores)
