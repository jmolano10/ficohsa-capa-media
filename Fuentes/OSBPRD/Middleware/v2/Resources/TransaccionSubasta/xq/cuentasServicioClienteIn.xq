xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns1:FUNDSTRANSFERType" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Cuentasdeservicioporcliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionSubasta/xq/cuentasServicioClienteIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:cuentasServicioClienteIn($requestHeader as element(ns0:RequestHeader),
    $fUNDSTRANSFERType as element())
    as element(ns1:Cuentasdeservicioporcliente) {
        <ns1:Cuentasdeservicioporcliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOLINKSERVICEACCTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($fUNDSTRANSFERType/DEBITCUSTOMER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKSERVICEACCTType>
        </ns1:Cuentasdeservicioporcliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $fUNDSTRANSFERType as element() external;

xf:cuentasServicioClienteIn($requestHeader,
    $fUNDSTRANSFERType)