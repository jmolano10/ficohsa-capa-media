xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$evaluaCuentaAbanksTypeResponse1" element="ns0:EvaluaCuentaAbanksTypeResponse" location="../../../../v2/BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedetallesdelacuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/ConsultaCuentaForEachIn/";

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

declare function xf:ConsultaCuentaForEachIn($requestHeader1 as element(ns2:RequestHeader),
    $evaluaCuentaAbanksTypeResponse1 as element(ns0:EvaluaCuentaAbanksTypeResponse),
    $index as xs:int)
    as element(ns1:Consultadedetallesdelacuenta) {
        <ns1:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
             <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {                        							
                            let $ACCOUNT_ID := $evaluaCuentaAbanksTypeResponse1/ns0:EvaluaCuentaAbanksTypeResponse[$index]/ns0:ACCOUNT_ID
                            return
                                <criteriaValue>{ data($ACCOUNT_ID) }</criteriaValue>                                               
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns1:Consultadedetallesdelacuenta>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $evaluaCuentaAbanksTypeResponse1 as element(ns0:EvaluaCuentaAbanksTypeResponse) external;
declare variable $index as xs:int external;

xf:ConsultaCuentaForEachIn($requestHeader1,
    $evaluaCuentaAbanksTypeResponse1,
    $index)