xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaInternacional_Validate" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionSwift/xq/consultaComisionSwiftIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:consultaComisionSwiftIn($requestHeader as element(ns0:RequestHeader),
    $destinationCountry as xs:string,
    $transferCurrency as xs:string,
    $debitAccount as xs:string,
    $creditAccount as xs:string,
    $accountWithInstitucionTag57 as xs:string)
    as element(ns1:TransferenciaInternacional_Validate) {
        <ns1:TransferenciaInternacional_Validate>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
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
        </ns1:TransferenciaInternacional_Validate>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $destinationCountry as xs:string external;
declare variable $transferCurrency as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $accountWithInstitucionTag57 as xs:string external;

xf:consultaComisionSwiftIn($requestHeader,
    $destinationCountry,
    $transferCurrency,
    $debitAccount,
    $creditAccount,
    $accountWithInstitucionTag57)