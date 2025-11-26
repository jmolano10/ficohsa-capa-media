(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/AnticipoSalarioTypes02.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace t24 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/T24/AnticipoSalario/xq/ConsultaAnticipoSalarioIN";

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

declare function xf:ConsultaAnticipoSalarioIN($user as xs:string,
	$pass as xs:string,
	$account as xs:string,
	$amount as xs:string)
    as element(t24:ConsultaAnticipoSalario) {
        <t24:ConsultaAnticipoSalario>
            <WebRequestCommon>
				<userName>{ fn-bea:fail-over( getUsername(data($user)), 
												data($user)) }</userName>
				<password>{ fn-bea:fail-over( getPassword(data($user)),
                								data($pass)) }</password>
			</WebRequestCommon>
			<NOFILEFICOCASHADVANCEWSType>
				<enquiryInputCollection>
					<columnName>ACCOUNT</columnName>
					<criteriaValue>{ data($account) }</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>
				<enquiryInputCollection>
					<columnName>AMOUNT</columnName>
					<criteriaValue>{ data($amount) }</criteriaValue>
					<operand>EQ</operand>
				</enquiryInputCollection>
			</NOFILEFICOCASHADVANCEWSType>
        </t24:ConsultaAnticipoSalario>
};

declare variable $user as xs:string external;
declare variable $pass as xs:string external;
declare variable $account as xs:string external;
declare variable $amount as xs:string external;

xf:ConsultaAnticipoSalarioIN($user, $pass, $account,$amount)