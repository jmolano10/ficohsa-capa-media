xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudChequeras" element="ns2:solicitudChequeras" location="../xsd/solicitudChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Solicituddechequera" location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
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
 
declare function xf:solicitudChequerasIn($requestHeader as element(ns0:RequestHeader),
    $solicitudChequeras as element(ns2:solicitudChequeras),
    $uuid as xs:string)
    as element(ns1:Solicituddechequera) {
        <ns1:Solicituddechequera>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHCHECKBOOKREQUESTISSUEDWSType>
                <ACCOUNTNUMBER>{ data($solicitudChequeras/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <DESTINATIONAGENCYCODE>{ data($solicitudChequeras/DESTINATION_BRANCH) }</DESTINATIONAGENCYCODE>
                <NOOFBOOKS>{ data($solicitudChequeras/NO_OF_BOOKS) }</NOOFBOOKS>
                <CHEQUETYPEID>{ data($solicitudChequeras/CHEQUEBOOK_TYPE) }</CHEQUETYPEID>
                <AUTHORISEDPERSON>{ data($solicitudChequeras/AUTHORIZED_CLAIMER) }</AUTHORISEDPERSON>
            </FICOHCHECKBOOKREQUESTISSUEDWSType>
        </ns1:Solicituddechequera>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $solicitudChequeras as element(ns2:solicitudChequeras) external;
declare variable $uuid as xs:string external;

xf:solicitudChequerasIn($requestHeader,
    $solicitudChequeras,
    $uuid)