(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultaMovimientosCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaIn/";

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

declare function xf:ConsultaMovimientosCuentaIn($requestHeader1 as element(ns1:RequestHeader),
    $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta),
    $beginDate as xs:string,
    $endDate as xs:string,
    $ticket as xs:string)
    as element(ns2:ConsultaMovimientosCuenta) {
        <ns2:ConsultaMovimientosCuenta>
            
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSACCOUNTENTRIESType>
            
                <enquiryInputCollection>
                	<columnName>ACCOUNT.NO</columnName>
                    <criteriaValue>{ data($consultaMovimientosCuenta1/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                
                <enquiryInputCollection>
					<columnName>START.DATE</columnName>
					<criteriaValue>{ $beginDate }</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>  
				 
				<enquiryInputCollection>
					<columnName>END.DATE</columnName>
					<criteriaValue>{ $endDate }</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>
				
				<enquiryInputCollection>
	               <columnName>PAGINAR</columnName>
	               <criteriaValue>NO</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            
	             <enquiryInputCollection>
	               <columnName>INICIOPAGINAR</columnName>
	               <criteriaValue>1</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            
	            <enquiryInputCollection>
	               <columnName>NUM.REGISTROS</columnName>
	               <criteriaValue>1</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            
	            <enquiryInputCollection>
	               <columnName>TICKET</columnName>
	               <criteriaValue>{ $ticket }</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            
            </WSACCOUNTENTRIESType>
        </ns2:ConsultaMovimientosCuenta>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;
declare variable $beginDate as xs:string external;
declare variable $endDate as xs:string external;
declare variable $ticket as xs:string external;

xf:ConsultaMovimientosCuentaIn($requestHeader1,
    $consultaMovimientosCuenta1,
    $beginDate,
    $endDate,
    $ticket)