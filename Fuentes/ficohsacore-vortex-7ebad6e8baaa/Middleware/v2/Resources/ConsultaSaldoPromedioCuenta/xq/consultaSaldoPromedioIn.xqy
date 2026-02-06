xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoPromedioCuenta1" element="ns1:consultaSaldoPromedioCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultasaldopromcuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoPromedioCuenta/xq/consultaSaldoPromedioIn/";

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

declare function xf:consultaSaldoPromedioIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaSaldoPromedioCuenta1 as element(ns1:consultaSaldoPromedioCuenta))
    as element(ns0:Consultasaldopromcuenta) {
    <ns0:Consultasaldopromcuenta>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
         <WSACCTAVERAGEBALType>
            <enquiryInputCollection>
               <columnName>START.DATE</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta1/START_DATE) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
               <columnName>END.DATE</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta1/END_DATE) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
               <columnName>ACCOUNT.NUMBER</columnName>
              <criteriaValue>{ data($consultaSaldoPromedioCuenta1/ACCOUNT_NUMBER) }</criteriaValue>
               <operand>EQ</operand>
            </enquiryInputCollection>
         </WSACCTAVERAGEBALType>
        </ns0:Consultasaldopromcuenta>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaSaldoPromedioCuenta1 as element(ns1:consultaSaldoPromedioCuenta) external;

xf:consultaSaldoPromedioIn($requestHeader1,
    $consultaSaldoPromedioCuenta1)