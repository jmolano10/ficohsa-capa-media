xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosMultipleProductos" element="ns1:sjConsultaSaldosMultipleProductos" location="../xsd/sjConsultaSaldosMultipleProductos.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodecuenta" location="../../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosMultipleProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosMultipleProductos/xq/consultadesaldodecuentaIn/";

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

declare function xf:consultadesaldodecuentaIn($sjConsultaSaldosMultipleProductos as element(ns1:sjConsultaSaldosMultipleProductos))
    as element(ns0:Consultadesaldodecuenta) {
        <ns0:Consultadesaldodecuenta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername(data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)), 
												data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)) }</userName>
                <password>{fn-bea:fail-over( getPassword(data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)),
                								data($sjConsultaSaldosMultipleProductos/ns1:PASSWORD))}</password>
            </WebRequestCommon>
            <WSFICOACCTBASICDETAILSType>
            {
            for $i in 1 to count($sjConsultaSaldosMultipleProductos/ns1:PRODUCTS/ns1:ID)
            return
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($sjConsultaSaldosMultipleProductos/ns1:PRODUCTS/ns1:ID[$i]) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            }
            </WSFICOACCTBASICDETAILSType>
        </ns0:Consultadesaldodecuenta>
};

declare variable $sjConsultaSaldosMultipleProductos as element(ns1:sjConsultaSaldosMultipleProductos) external;

xf:consultadesaldodecuentaIn($sjConsultaSaldosMultipleProductos)