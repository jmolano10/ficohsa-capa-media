xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../XSD/ConsultaListaContratistaDelEstado/XMLSchema_-2015926973.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasContratistaDelEstado";
(:: import schema at "../XSD/ConsultaListaContratistaDelEstado/ConsultaListaContratistaDelEstado_PS.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $consultaListasContratistaDelEstadoRequest as element() (:: schema-element(ns1:sjConsultaListasContratistaDelEstadoRequest) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($consultaListasContratistaDelEstadoRequest as element() (:: schema-element(ns1:sjConsultaListasContratistaDelEstadoRequest) ::)) as element() (:: schema-element(ns2:ConsultadeContratistasdelestado) ::) {
    <ns2:ConsultadeContratistasdelestado>
        <WebRequestCommon>
          {
          let $username := fn:data($consultaListasContratistaDelEstadoRequest/ns1:USERNAME)
          let $password := fn:data($consultaListasContratistaDelEstadoRequest/ns1:PASSWORD)
            return(
            <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>,
            <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
            )
          }
            <company></company>
        </WebRequestCommon>
        <FICOSTATECONTRACTLISTWSType>
            <enquiryInputCollection>
                <columnName>LEGAL.ID</columnName>
                <criteriaValue>{fn:data($consultaListasContratistaDelEstadoRequest/ns1:CUSTOMER_LEGAL_ID)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </FICOSTATECONTRACTLISTWSType>
    </ns2:ConsultadeContratistasdelestado>
};

local:func($consultaListasContratistaDelEstadoRequest)