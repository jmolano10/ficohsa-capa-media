(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ampliacionLimiteClienteVenta" element="ns2:ampliacionLimiteClienteVenta" location="../xsd/ampliacionLimiteClienteVentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ActualizaLimiteVentaCliente" location="../../../BusinessServices/AmpliacionLimiteClienteVenta/xsd/XMLSchema_161558775.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ampliacionLimiteClienteVentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AmpliacionLimiteClienteVenta/xq/ampliacionLimiteClienteVentaIn/";

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

declare function xf:ampliacionLimiteClienteVentaIn($requestHeader as element(ns0:RequestHeader),
    $ampliacionLimiteClienteVenta as element(ns2:ampliacionLimiteClienteVenta))
    as element(ns1:ActualizaLimiteVentaCliente) {
        <ns1:ActualizaLimiteVentaCliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
		        <noOfAuth>0</noOfAuth>
		    </OfsFunction>            
            <CUSTOMERFICOSPLCUSTWSType id = "{ data($ampliacionLimiteClienteVenta/CUSTOMER_ID) }">
                <LRSPLCUST>{ data($ampliacionLimiteClienteVenta/SPECIAL_CUSTOMER_YES_NO) }</LRSPLCUST>
            </CUSTOMERFICOSPLCUSTWSType>
        </ns1:ActualizaLimiteVentaCliente>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $ampliacionLimiteClienteVenta as element(ns2:ampliacionLimiteClienteVenta) external;

xf:ampliacionLimiteClienteVentaIn($requestHeader,
    $ampliacionLimiteClienteVenta)