(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaDatosClienteIN" element="ns1:validaDatosCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/ConsultaClienteIn/";

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

declare function xf:ConsultaClienteIn($requestHeaderIN as element(ns2:RequestHeader),
    $validaDatosClienteIN as element(ns1:validaDatosCliente))
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)), 
												data($requestHeaderIN/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                								data($requestHeaderIN/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{ data($validaDatosClienteIN/LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $validaDatosClienteIN as element(ns1:validaDatosCliente) external;

xf:ConsultaClienteIn($requestHeaderIN,
    $validaDatosClienteIN)
