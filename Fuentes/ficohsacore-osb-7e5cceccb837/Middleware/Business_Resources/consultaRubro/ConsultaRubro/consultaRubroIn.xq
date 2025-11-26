(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRubro1" element="ns0:consultaRubro" location="consultaRubroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultaderubrocmpvtadivisas" location="../Resources/XMLSchema_-1176801753.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRubroTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaRubro/ConsultaRubro/consultaRubroIn/";

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

declare function xf:consultaRubroIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaRubro1 as element(ns0:consultaRubro))
    as element(ns1:Consultaderubrocmpvtadivisas) {
        <ns1:Consultaderubrocmpvtadivisas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSBUYSELLCATEGORYType>
            {
            	if(exists($consultaRubro1/ITEM_ID/text())) then(
                	<enquiryInputCollection>
                    	<columnName>@ID</columnName>
               			<criteriaValue>{data($consultaRubro1/ITEM_ID)}</criteriaValue>
               			<operand>EQ</operand>
                	</enquiryInputCollection>
                )
                else()
            }
            {
                if(exists($consultaRubro1/PARENT_ITEM_ID/text())) then(
                	<enquiryInputCollection>
                		<columnName>RELATED.LEVEL</columnName>
               			<criteriaValue>{data($consultaRubro1/PARENT_ITEM_ID)}</criteriaValue>
               			<operand>EQ</operand>
               		</enquiryInputCollection>
                )
                else()
            }
            {
            	if(exists($consultaRubro1/ITEM_LEVEL/text())) then(
            		<enquiryInputCollection>
                		<columnName>LEVEL</columnName>
               			<criteriaValue>{data($consultaRubro1/ITEM_LEVEL)}</criteriaValue>
               			<operand>EQ</operand>
               		</enquiryInputCollection>
            	)
            	else()
            }
            {
            	if(exists($consultaRubro1/BUY_OR_SELL/text())) then(
            		<enquiryInputCollection>
               			<columnName>@ID</columnName>
               			<criteriaValue>{data($consultaRubro1/BUY_OR_SELL)}</criteriaValue>
               			<operand>BW</operand>
            		</enquiryInputCollection>
            	)
            	else()
            }    
            </WSBUYSELLCATEGORYType>
        </ns1:Consultaderubrocmpvtadivisas>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRubro1 as element(ns0:consultaRubro) external;

xf:consultaRubroIn($autenticacionRequestHeader1,
    $consultaRubro1)