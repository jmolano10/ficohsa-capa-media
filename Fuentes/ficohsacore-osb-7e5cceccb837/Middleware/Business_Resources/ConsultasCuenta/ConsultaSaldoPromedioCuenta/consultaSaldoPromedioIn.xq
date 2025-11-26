(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoPromedioCuenta" element="ns1:consultaSaldoPromedioCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultasaldopromcuenta" location="../Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoPromedioCuenta/consultaSaldoPromedioIn/";

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

declare function xf:consultaSaldoPromedioIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaSaldoPromedioCuenta as element(ns1:consultaSaldoPromedioCuenta))
    as element(ns0:Consultasaldopromcuenta) {
        <ns0:Consultasaldopromcuenta>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
         <WSACCTAVERAGEBALType>
            <enquiryInputCollection>
               <columnName>START.DATE</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta/START_DATE) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
               <columnName>END.DATE</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta/END_DATE) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
               <columnName>ACCOUNT.NUMBER</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta/ACCOUNT_NUMBER) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
         </WSACCTAVERAGEBALType>
        </ns0:Consultasaldopromcuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaSaldoPromedioCuenta as element(ns1:consultaSaldoPromedioCuenta) external;

xf:consultaSaldoPromedioIn($autenticacionRequestHeader,
    $consultaSaldoPromedioCuenta)