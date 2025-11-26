(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleSaldosPignorados1" element="ns2:consultaDetalleSaldosPignorados" location="consultaDetalleSaldosPignoradosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadebloqueosporTD" location="../../tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalleSaldoPignorado/consultaDetalleSaldosPignoradosIn/";

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

declare function xf:consultaDetalleSaldosPignoradosIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $consultaDetalleSaldosPignorados1 as element(ns2:consultaDetalleSaldosPignorados))
    as element(ns0:ConsultadebloqueosporTD) {
        <ns0:ConsultadebloqueosporTD>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFICOECUSTPOSVISATXNSType>
                <enquiryInputCollection>
                	<columnName>ACCOUNT.NUMBER</columnName>
                    <criteriaValue>{ data($consultaDetalleSaldosPignorados1/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand> 
                </enquiryInputCollection>
                <enquiryInputCollection>
               		<columnName>NATURE.OF.TXN</columnName>
               		<criteriaValue>ATM POS</criteriaValue>
               		<operand>NE</operand>
            	</enquiryInputCollection>
            </WSFICOECUSTPOSVISATXNSType>
        </ns0:ConsultadebloqueosporTD>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaDetalleSaldosPignorados1 as element(ns2:consultaDetalleSaldosPignorados) external;

xf:consultaDetalleSaldosPignoradosIn($autenticacionRequestHeader1,
    $consultaDetalleSaldosPignorados1)