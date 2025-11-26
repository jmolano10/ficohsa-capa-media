(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaOcupaciones" element="ns2:consultaOcupaciones" location="../xsd/consultaOcupacionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:getCustomerOccupations" location="../../../BusinessServices/ConsultaOcupacionesT24/services_1.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaOcupacionesTypes";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOcupacionesT24/xq/consultaOcupaciones3In/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:consultaOcupaciones3In($autenticacionRequestHeader1 as element(ns1:RequestHeader),
    $consultaOcupaciones as element(ns2:consultaOcupaciones))
    as element(ns0:getCustomerOccupations) {
        <ns0:getCustomerOccupations>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/Authentication/UserName)), 
												data($autenticacionRequestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/Authentication/UserName)),
                								data($autenticacionRequestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FICOENQOCCUPATIONSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $OCUPATTION_ID in $consultaOcupaciones/OCUPATTION_ID
                        return
                            <criteriaValue>{ data($OCUPATTION_ID) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOENQOCCUPATIONSType>
        </ns0:getCustomerOccupations>
};

declare variable $autenticacionRequestHeader1 as element(ns1:RequestHeader) external;
declare variable $consultaOcupaciones as element(ns2:consultaOcupaciones) external;

xf:consultaOcupaciones3In($autenticacionRequestHeader1,
    $consultaOcupaciones)