(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns1:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Tarjetasdecreditoporcliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteTRCHNIn/";

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

declare function xf:validaProductoClienteTRCHNIn($requestHeader as element(ns0:RequestHeader),
    $validaProductoCliente as element(ns1:validaProductoCliente))
    as element(ns2:Tarjetasdecreditoporcliente) {
        <ns2:Tarjetasdecreditoporcliente>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
	               <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <FICOLISTCLIENTCARDCPType>
                <enquiryInputCollection>
                    <columnName>CLIENT.ID</columnName>
                    <criteriaValue>{ data($validaProductoCliente/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOLISTCLIENTCARDCPType>
        </ns2:Tarjetasdecreditoporcliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $validaProductoCliente as element(ns1:validaProductoCliente) external;

xf:validaProductoClienteTRCHNIn($requestHeader,
    $validaProductoCliente)