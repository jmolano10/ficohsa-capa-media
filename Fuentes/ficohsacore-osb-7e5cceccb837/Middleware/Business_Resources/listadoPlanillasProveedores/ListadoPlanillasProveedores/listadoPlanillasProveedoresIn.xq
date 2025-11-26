(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$listadoPlanillasProveedores1" element="ns1:listadoPlanillasProveedores" location="listadoPlanillasProveedoresTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeplanillas" location="../Resources/XMLSchema_596884079.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listadoPlanillasProveedoresTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/listadoPlanillasProveedores/ListadoPlanillasProveedores/listadoPlanillasProveedoresIn/";

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


declare function xf:listadoPlanillasProveedoresIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $listadoPlanillasProveedores1 as element(ns1:listadoPlanillasProveedores))
    as element(ns0:Consultadeplanillas) {
        <ns0:Consultadeplanillas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
        	{
        		if (fn:string($listadoPlanillasProveedores1/CONTRACT_ID) != "" and fn:string($listadoPlanillasProveedores1/PAYROLL_GROUP_ID) != "") then (
					<LATAMAGPAYROLLGRPLISTType>
	    				<enquiryInputCollection>
		                    <columnName>COMPANY.ID</columnName>
		                    <criteriaValue>{ data($listadoPlanillasProveedores1/CONTRACT_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($listadoPlanillasProveedores1/PAYROLL_GROUP_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
	                </LATAMAGPAYROLLGRPLISTType>
        		) else if (fn:string($listadoPlanillasProveedores1/CONTRACT_ID) != "") then (
        			<LATAMAGPAYROLLGRPLISTType>
	    				<enquiryInputCollection>
		                    <columnName>COMPANY.ID</columnName>
		                    <criteriaValue>{ data($listadoPlanillasProveedores1/CONTRACT_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
	                </LATAMAGPAYROLLGRPLISTType>
        		) else if (fn:string($listadoPlanillasProveedores1/PAYROLL_GROUP_ID) != "") then (
    				<LATAMAGPAYROLLGRPLISTType>
        				<enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($listadoPlanillasProveedores1/PAYROLL_GROUP_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
	                </LATAMAGPAYROLLGRPLISTType>
        		) else (
        			<LATAMAGPAYROLLGRPLISTType/>
        		)
        	}
        </ns0:Consultadeplanillas>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $listadoPlanillasProveedores1 as element(ns1:listadoPlanillasProveedores) external;

xf:listadoPlanillasProveedoresIn($autenticacionRequestHeader1,
    $listadoPlanillasProveedores1)