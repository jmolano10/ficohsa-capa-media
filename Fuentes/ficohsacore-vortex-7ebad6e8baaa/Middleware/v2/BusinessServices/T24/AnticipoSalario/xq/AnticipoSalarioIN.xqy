xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/AnticipoSalarioTypes02.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace t24 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/T24/AnticipoSalario/xq/AnticipoSalarioIN";

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

declare function xf:AnticipoSalarioIN($user as xs:string,
	$pass as xs:string,
	$account as xs:string,
	$amount as xs:decimal)
    as element(t24:AnticipoSalario) {
        <t24:AnticipoSalario>
            <WebRequestCommon>
				<userName>{ fn-bea:fail-over( getUsername(data($user)), 
												data($user)) }</userName>
				<password>{ fn-bea:fail-over( getPassword(data($user)),
                								data($pass)) }</password>
			</WebRequestCommon>
			<OfsFunction>
				<noOfAuth></noOfAuth>
			</OfsFunction>
			<PDCAPTUREFICOANTICIPOType>
				<gPAYMENTTYPE>
					<mPAYMENTTYPE>
						<PAYMENTAMT>{ data($amount) }</PAYMENTAMT>
						<SETTLEMENTACCT>{ data($account) }</SETTLEMENTACCT>
					</mPAYMENTTYPE>
				</gPAYMENTTYPE>
			</PDCAPTUREFICOANTICIPOType>
        </t24:AnticipoSalario>
};

declare variable $user as xs:string external;
declare variable $pass as xs:string external;
declare variable $account as xs:string external;
declare variable $amount as xs:decimal external;

xf:AnticipoSalarioIN($user, $pass, $account, $amount)