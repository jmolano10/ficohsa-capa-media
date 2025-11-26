(:: pragma bea:global-element-parameter parameter="$RequestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaBarrioColonia" element="ns1:consultaBarrioColonia" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecoloniaobarrio" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaBarrioColoniaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaIn/";

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

declare function xf:consultaBarrioColoniaIn($RequestHeader as element(ns2:RequestHeader),
    $consultaBarrioColonia as element(ns1:consultaBarrioColonia))
    as element(ns0:Consultadecoloniaobarrio) {
        <ns0:Consultadecoloniaobarrio>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($RequestHeader/Authentication/UserName)), 
												data($RequestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($RequestHeader/Authentication/UserName)),
                								data($RequestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSNEIGHBORHOODLISTType>
                <enquiryInputCollection>
                    <columnName>COUNTRY</columnName>
                    <criteriaValue>{ data($consultaBarrioColonia/COUNTRY_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>STATE</columnName>
                    <criteriaValue>{ concat( $consultaBarrioColonia/COUNTRY_CODE, ".", $consultaBarrioColonia/DEPT_CODE ) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CITY</columnName>
                    <criteriaValue>{ concat( $consultaBarrioColonia/COUNTRY_CODE, ".", $consultaBarrioColonia/DEPT_CODE, ".", $consultaBarrioColonia/CITY_CODE ) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if( exists($consultaBarrioColonia/DISTRICT_CODE/text()) ) then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ concat( $consultaBarrioColonia/COUNTRY_CODE, ".", $consultaBarrioColonia/DEPT_CODE, ".", $consultaBarrioColonia/CITY_CODE, ".", $consultaBarrioColonia/DISTRICT_CODE ) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            ) else ()
		        }
            </WSNEIGHBORHOODLISTType>
        </ns0:Consultadecoloniaobarrio>
};

declare variable $RequestHeader as element(ns2:RequestHeader) external;
declare variable $consultaBarrioColonia as element(ns1:consultaBarrioColonia) external;

xf:consultaBarrioColoniaIn($RequestHeader,
    $consultaBarrioColonia)