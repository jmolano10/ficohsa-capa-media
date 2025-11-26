(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaUsuariosSistema" element="ns1:consultaUsuariosSistema" location="consultaUsuariosSistemaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/ConsultaUsuariosSistema/consultaUsuariosSistemaIn/";

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

declare function xf:consultaUsuariosSistemaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaUsuariosSistema as element(ns1:consultaUsuariosSistema))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSUSERType>
           	{
           		let $USER_ID := fn:string($consultaUsuariosSistema/USER_ID/text())
           		return 
           			if ($USER_ID != "") then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ $USER_ID }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $BRANCH_CODE := fn:string($consultaUsuariosSistema/BRANCH_CODE/text())
           		return 
           			if ($BRANCH_CODE != "") then (
		                <enquiryInputCollection>
		                    <columnName>LR.AGENCY.CODE</columnName>
		                    <criteriaValue>{ $BRANCH_CODE }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $APPLICATION := fn:string($consultaUsuariosSistema/APPLICATION/text())
           		return 
           			if ($APPLICATION != "") then (
		                <enquiryInputCollection>
		                    <columnName>APPLICATION</columnName>
		                    <criteriaValue>{ $APPLICATION }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $SIGN_ON_NAME := fn:string($consultaUsuariosSistema/SIGN_ON_NAME/text())
           		return 
           			if ($SIGN_ON_NAME != "") then (
		                <enquiryInputCollection>
		                    <columnName>SIGN.ON.NAME</columnName>
		                    <criteriaValue>{ $SIGN_ON_NAME }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }	 
	               	        	                   	{
           		let $OFFICER_DAO := fn:string($consultaUsuariosSistema/OFFICER_DAO/text())
           		return 
           			if ($OFFICER_DAO != "") then (
		                <enquiryInputCollection>
		                    <columnName>LR.OFFICER.DAO</columnName>
		                    <criteriaValue>{ $OFFICER_DAO }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }	
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaUsuariosSistema as element(ns1:consultaUsuariosSistema) external;

xf:consultaUsuariosSistemaIn($autenticacionRequestHeader,
    $consultaUsuariosSistema)