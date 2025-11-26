(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns0:consultaRemesas" location="consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultaderemesa" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasIn/";

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

declare function xf:consultaRemesasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRemesas as element(ns0:consultaRemesas))
    as element(ns1:Consultaderemesa) {
        <ns1:Consultaderemesa>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSLATAMAGREMITTANCEINFOType>
            {
            	let $REMITTANCE_ID := fn:string($consultaRemesas/REMITTANCE_ID/text())
            	return
            		if($REMITTANCE_ID != "") then ( 
		                <enquiryInputCollection>
		                    <columnName>REMITTANCE.KEY</columnName>
		                    <criteriaValue>{ $REMITTANCE_ID }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
	    			) else ()
            }
            {
            	let $REMITTER_NAME := fn:string($consultaRemesas/REMITTER_NAME/text())
            	return
            		if($REMITTER_NAME != "") then ( 
		                <enquiryInputCollection>
		                    <columnName>ORD.PARTY.NAME</columnName>
		                    <criteriaValue>{ $REMITTER_NAME }</criteriaValue>
		                    <operand>CT</operand>
		                </enquiryInputCollection>
	    			) else ()
            }
            {
            	let $BENEFICIARY_NAME := fn:string($consultaRemesas/BENEFICIARY_NAME/text())
            	return
            		if($BENEFICIARY_NAME != "") then ( 
		                <enquiryInputCollection>
		                    <columnName>BEN.NAME</columnName>
		                    <criteriaValue>{ $BENEFICIARY_NAME }</criteriaValue>
		                    <operand>CT</operand>
		                </enquiryInputCollection>
	    			) else ()
            }                        
            </WSLATAMAGREMITTANCEINFOType>
        </ns1:Consultaderemesa>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRemesas as element(ns0:consultaRemesas) external;

xf:consultaRemesasIn($autenticacionRequestHeader,
    $consultaRemesas)