xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjPagosMasivosInterno" element="ns1:sjPagosMasivosInterno" location="../xsd/sjPagosMasivosInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetalleDeCuentaIn/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagosMasivosInterno";

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
declare function xf:consultaDetalleDeCuentaIn($accountNumber as xs:string,
    $sjPagosMasivosInterno as element(ns1:sjPagosMasivosInterno))
    as element(ns0:Consultadedetallesdelacuenta) {
    	<ns0:Consultadedetallesdelacuenta>
    		<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("SRV-ITPMSV"), 
												data($sjPagosMasivosInterno/PASSWORD_HEADER)) }</userName>
                <password>{ fn-bea:fail-over( getPassword("SRV-ITPMSV"),
                								data($sjPagosMasivosInterno/PASSWORD_HEADER)) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $accountNumber}</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};


declare variable $sjPagosMasivosInterno as element(ns1:sjPagosMasivosInterno) external;
declare variable $accountNumber as xs:string external;

xf:consultaDetalleDeCuentaIn($accountNumber,
    $sjPagosMasivosInterno)