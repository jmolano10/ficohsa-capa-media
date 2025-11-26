xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarListaFatca";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultarListaFatca/consultarListaFatca_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare variable $sjConsultaListasClienteRequest as element() (:: schema-element(ns2:getCustomerListsHN_SJRequest) ::) external;

declare function ns1:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest as element() (:: schema-element(ns2:getCustomerListsHN_SJRequest) ::)) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:PV_NUMERO_IDENTIFICACION>{fn:data($sjConsultaListasClienteRequest/ns2:CUSTOMER_LEGAL_ID)}</ns3:PV_NUMERO_IDENTIFICACION>
    </ns3:InputParameters>
};

ns1:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest)