xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaAgenciasBanco" element="ns1:consultaAgenciasBanco" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultaDAO" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";

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
 
declare function xf:consultaAgenciasBancoIn($requestHeader as element(ns0:RequestHeader),
    $consultaAgenciasBanco as element(ns1:consultaAgenciasBanco))
    as element(ns2:ConsultaDAO) {
        <ns2:ConsultaDAO>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSADMINDEPTACCTOFFICERType>
				<enquiryInputCollection>
					<columnName>DEPT.LEVEL</columnName>
					<criteriaValue>20</criteriaValue>
               		<operand>EQ</operand>
            	</enquiryInputCollection>
            {
            	if(data($consultaAgenciasBanco/BRANCH_TYPE) != "") then 
            			<enquiryInputCollection>
                			<columnName>AREA</columnName>
                    		<criteriaValue>{ data($consultaAgenciasBanco/BRANCH_TYPE) }</criteriaValue>
                    		<operand>EQ</operand>
                		</enquiryInputCollection>
                 else()
            }
            {
            	if(data($consultaAgenciasBanco/BRANCH_CODE) != "") then 
            			<enquiryInputCollection>
                			<columnName>@ID</columnName>
                    		<criteriaValue>{ data($consultaAgenciasBanco/BRANCH_CODE) }</criteriaValue>
                    		<operand>EQ</operand>
                		</enquiryInputCollection>
                 else()
            }
              {
            	if(data($consultaAgenciasBanco/SERVICE_CODE) != "") then (
            		if(data($consultaAgenciasBanco/SERVICE_CODE) = "CASHCHQLCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>...HNL...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
            		if(data($consultaAgenciasBanco/SERVICE_CODE) = "CASHCHQFCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>...USD...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco/SERVICE_CODE) = "CASHCHQALL") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.PRINTING</columnName>
	                    		<criteriaValue>HNL/USD</criteriaValue>
	                    		<operand>EQ</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco/SERVICE_CODE) = "CHQBKPRTLCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>...HNL...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco/SERVICE_CODE) = "CHQBKPRTFCY") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>...USD...</criteriaValue>
	                    		<operand>LK</operand>
                 			</enquiryInputCollection>
                 	 ) else (),
                 	 if(data($consultaAgenciasBanco/SERVICE_CODE) = "CHQBKPRTALL") then (
            			
	            			<enquiryInputCollection>
	                			<columnName>LR.CC.ALLOWED</columnName>
	                    		<criteriaValue>HNL/USD</criteriaValue>
	                    		<operand>EQ</operand>
                 			</enquiryInputCollection>
                 	 ) else ()
                 ) else()
            }
            </WSADMINDEPTACCTOFFICERType>
        </ns2:ConsultaDAO>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaAgenciasBanco as element(ns1:consultaAgenciasBanco) external;

xf:consultaAgenciasBancoIn($requestHeader,
    $consultaAgenciasBanco)