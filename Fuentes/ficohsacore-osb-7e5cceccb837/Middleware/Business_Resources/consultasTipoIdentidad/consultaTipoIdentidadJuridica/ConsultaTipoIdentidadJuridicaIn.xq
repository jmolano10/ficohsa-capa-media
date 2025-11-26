(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultasTipoIdentidad1" element="ns1:consultasTipoIdentidad" location="../consultasTipoIdentidadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetipodeIdentJuridica" location="../Resources/XMLSchema_-125070348.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasTipoIdentidadTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadJuridica/ConsultaTipoIdentidadJuridicaIn/";

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

declare function xf:ConsultaTipoIdentidadJuridicaIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultasTipoIdentidad1 as element(ns1:consultasTipoIdentidad))
    as element(ns0:ConsultadetipodeIdentJuridica) {
        <ns0:ConsultadetipodeIdentJuridica>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFICOHCORPORATELEGALDOCNAMEType>
        	{
        		if (exists($consultasTipoIdentidad1/ID_TYPE/text())) then (
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($consultasTipoIdentidad1/ID_TYPE) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                ) else ()
        	}
            </WSFICOHCORPORATELEGALDOCNAMEType>
        </ns0:ConsultadetipodeIdentJuridica>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultasTipoIdentidad1 as element(ns1:consultasTipoIdentidad) external;

xf:ConsultaTipoIdentidadJuridicaIn($autenticacionRequestHeader1,
    $consultasTipoIdentidad1)