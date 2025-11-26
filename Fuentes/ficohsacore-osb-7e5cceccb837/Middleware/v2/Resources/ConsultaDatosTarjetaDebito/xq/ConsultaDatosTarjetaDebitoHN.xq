declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace t24 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoHN";

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

declare function xf:ConsultaDatosTarjetaDebitoHN($user as xs:string,
	$pass as xs:string,
	$account as xs:string)
    as element(t24:ConsultaMaestraTarjetaDebito) {
        <t24:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
				<userName>{ fn-bea:fail-over( getUsername(data($user)), 
												data($user)) }</userName>
				<password>{ fn-bea:fail-over( getPassword(data($user)),
                								data($pass)) }</password>
			</WebRequestCommon>
			<WSFICODEBITCARDCUSTOMERType>
				<enquiryInputCollection>
					<columnName>@ID</columnName>
					<criteriaValue>{ data($account) }</criteriaValue>
					<operand>LK</operand>
				</enquiryInputCollection>
			</WSFICODEBITCARDCUSTOMERType>
        </t24:ConsultaMaestraTarjetaDebito>
};

declare variable $user as xs:string external;
declare variable $pass as xs:string external;
declare variable $account as xs:string external;

xf:ConsultaDatosTarjetaDebitoHN($user, $pass, $account)