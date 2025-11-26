(:: pragma bea:global-element-parameter parameter="$consultaAgenciasBanco1" element="ns0:consultaAgenciasBanco" location="consultaAgenciasBancoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaDAO" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoIn/";

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

declare function xf:consultaAgenciasBancoIn($consultaAgenciasBanco1 as element(ns0:consultaAgenciasBanco),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns1:ConsultaDAO) {
        <ns1:ConsultaDAO>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSADMINDEPTACCTOFFICERType>
				<enquiryInputCollection>
					<columnName>DEPT.LEVEL</columnName>
					<criteriaValue>20</criteriaValue>
               		<operand>EQ</operand>
            	</enquiryInputCollection>
            {
            	if(data($consultaAgenciasBanco1/BRANCH_TYPE) != "") then 
            			<enquiryInputCollection>
                			<columnName>AREA</columnName>
                    		<criteriaValue>{ data($consultaAgenciasBanco1/BRANCH_TYPE) }</criteriaValue>
                    		<operand>EQ</operand>
                		</enquiryInputCollection>
                 else()
            }
            {
            	if(data($consultaAgenciasBanco1/BRANCH_CODE) != "") then 
            			<enquiryInputCollection>
                			<columnName>@ID</columnName>
                    		<criteriaValue>{ data($consultaAgenciasBanco1/BRANCH_CODE) }</criteriaValue>
                    		<operand>EQ</operand>
                		</enquiryInputCollection>
                 else()
            }
              {
            	if(data($consultaAgenciasBanco1/SERVICE_CODE) != "") then (
            		if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CASHCHQLCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>...HNL...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
            		if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CASHCHQFCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>...USD...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CASHCHQALL") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>HNL/USD</criteriaValue>
	                    		<operand>EQ</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CHQBKPRTLCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>...HNL...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CHQBKPRTFCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>...USD...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco1/SERVICE_CODE) = "CHQBKPRTALL") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>HNL/USD</criteriaValue>
	                    		<operand>EQ</operand>
                 			</enquiryInputCollection>
                 	 ) else ()
                 ) else()
            }
            </WSADMINDEPTACCTOFFICERType>
        </ns1:ConsultaDAO>
};

declare variable $consultaAgenciasBanco1 as element(ns0:consultaAgenciasBanco) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:consultaAgenciasBancoIn($consultaAgenciasBanco1,
    $autenticacionRequestHeader1)