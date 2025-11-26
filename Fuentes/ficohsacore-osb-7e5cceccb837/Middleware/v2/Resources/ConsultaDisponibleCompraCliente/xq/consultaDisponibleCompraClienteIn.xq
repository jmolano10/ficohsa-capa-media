(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDisponibleCompraCliente" element="ns1:consultaDisponibleCompraCliente" location="../xsd/consultaDisponibleCompraClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaDisponibleCompraCliente" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDisponibleCompraClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDisponibleCompraCliente/xq/consultaDisponibleCompraClienteIn/";

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

declare function xf:consultaDisponibleCompraClienteIn($requestHeader as element(ns2:RequestHeader),
    $consultaDisponibleCompraCliente as element(ns1:consultaDisponibleCompraCliente))
    as element(ns0:ConsultaDisponibleCompraCliente) {
        <ns0:ConsultaDisponibleCompraCliente>
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
            <FICOSELLCUSTAVAILABEFXWSType>
                <enquiryInputCollection>
                    <columnName>SEARCH.TYPE</columnName>
                    <criteriaValue>{ data($consultaDisponibleCompraCliente/SEARCH_TYPE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>VALUE</columnName>
                    <criteriaValue>{ data($consultaDisponibleCompraCliente/VALUE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOSELLCUSTAVAILABEFXWSType>
        </ns0:ConsultaDisponibleCompraCliente>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaDisponibleCompraCliente as element(ns1:consultaDisponibleCompraCliente) external;

xf:consultaDisponibleCompraClienteIn($requestHeader,
    $consultaDisponibleCompraCliente)