(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaProspecto1" element="ns1:creaProspecto" location="../../CreaProspecto/xsd/creaProspectoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaProspectoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProspectoHN/xq/ConsultaCliente/";

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

declare function xf:ConsultaCliente($requestHeader1 as element(ns2:RequestHeader),
    $creaProspecto1 as element(ns1:creaProspecto))
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
            <WebRequestCommon>
				<userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
			</WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                	<columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{ data($creaProspecto1/ns1:BASIC_INFO/ns1:IDENTIFICATION/ns1:LEGAL_IDENTIFICATION_ITEM[1]/ns1:LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $creaProspecto1 as element(ns1:creaProspecto) external;

xf:ConsultaCliente($requestHeader1,
    $creaProspecto1)
