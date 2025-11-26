(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDisponibleVentaMonedaExtranjera" element="ns1:consultaDisponibleVentaMonedaExtranjera" location="../xsd/consultaDisponibleVentaMonedaExtranjeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultamontodisponiblevtadolar" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xq/consultaMontoDisponibleVentaDolar/";

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

declare function xf:consultaMontoDisponibleVentaDolar($requestHeader as element(ns2:RequestHeader),
    $consultaDisponibleVentaMonedaExtranjera as element(ns1:consultaDisponibleVentaMonedaExtranjera))
    as element(ns0:consultamontodisponiblevtadolar) {
        <ns0:consultamontodisponiblevtadolar>
    	    <WebRequestCommon>
				 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
	            <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
            								data($requestHeader/Authentication/Password)) }</password>
        	</WebRequestCommon>
            <FICOESELLTABLEENTRIESFXWSType>
                <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($consultaDisponibleVentaMonedaExtranjera/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOESELLTABLEENTRIESFXWSType>
        </ns0:consultamontodisponiblevtadolar>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaDisponibleVentaMonedaExtranjera as element(ns1:consultaDisponibleVentaMonedaExtranjera) external;

xf:consultaMontoDisponibleVentaDolar($requestHeader,
    $consultaDisponibleVentaMonedaExtranjera)