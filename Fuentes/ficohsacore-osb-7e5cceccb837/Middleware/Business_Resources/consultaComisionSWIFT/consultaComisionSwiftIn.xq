(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TransferenciaInternacional_Validate" location="../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaComisionSWIFT/consultaComisionSwiftIn/";

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

declare function xf:consultaComisionSwiftIn($destinationCountry as xs:string,
    $transferCurrency as xs:string,
    $debitAccount as xs:string,
    $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $creditAccount as xs:string,
    $accountWithInstitucionTag57 as xs:string)
    as element(ns0:TransferenciaInternacional_Validate) {
        <ns0:TransferenciaInternacional_Validate>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            <gtsControl></gtsControl>
            <messageId></messageId>
            <noOfAuth>0</noOfAuth>
            <replace></replace>
         </OfsFunction>
         <FUNDSTRANSFERFICOMT103WSType id="">
            <DEBITACCOUNT>{ $debitAccount }</DEBITACCOUNT>
            <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
            <CREDITCURRENCY>{ $transferCurrency }</CREDITCURRENCY>
            <CREDITAMOUNT>20</CREDITAMOUNT>
            <gACCTWITHBANK g="1">
               <ACCOUNTWITHINSTITUTIONTAG57>{ $accountWithInstitucionTag57 }</ACCOUNTWITHINSTITUTIONTAG57>
            </gACCTWITHBANK>
            <BENEFICIARYACCOUNTNOTAG59>1234</BENEFICIARYACCOUNTNOTAG59>
            <gBENCUSTOMER g="1">
               <BENNAMEANDADDRESSTAG59>JUAN PEREZ</BENNAMEANDADDRESSTAG59>
            </gBENCUSTOMER>
            <LRDESTCNTRY>{ $destinationCountry }</LRDESTCNTRY>
            <LRSWIFTTYPE>SWIFT</LRSWIFTTYPE>
         </FUNDSTRANSFERFICOMT103WSType>
        </ns0:TransferenciaInternacional_Validate>
};

declare variable $destinationCountry as xs:string external;
declare variable $transferCurrency as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $creditAccount as xs:string external;
declare variable $accountWithInstitucionTag57 as xs:string external;

xf:consultaComisionSwiftIn($destinationCountry,
    $transferCurrency,
    $debitAccount,
    $autenticacionRequestHeader,
    $creditAccount,
    $accountWithInstitucionTag57)