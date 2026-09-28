(:: pragma bea:global-element-parameter parameter="$RequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeparametroscore" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/consultaParametrosCoreIn/";

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

declare function xf:ConsultaParametrosCoreIn($RequestHeader as element(ns2:RequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo))
    as element(ns0:Consultadeparametroscore) {
        <ns0:Consultadeparametroscore>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($RequestHeader/Authentication/UserName)), 
												data($RequestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($RequestHeader/Authentication/UserName)),
                								data($RequestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSCOREPARAMETERSType>
                <enquiryInputCollection>
                    <columnName>CURRENCY.CODE</columnName>
                    <criteriaValue>
                    { 
                    	let $moneda := data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY)
                    	return
                    	if ($moneda = "HNL") then (
                    		"USD"
                    	) else (
                    		$moneda
                    	) 
                    }
                    </criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOREPARAMETERSType>
        </ns0:Consultadeparametroscore>
};

declare variable $RequestHeader as element(ns2:RequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;

xf:ConsultaParametrosCoreIn($RequestHeader,
    $pagoRecaudo)