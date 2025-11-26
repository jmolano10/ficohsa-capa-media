(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudChequeras1" element="ns2:solicitudChequeras" location="solicitudChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Solicituddechequera" location="../Resources/XMLSchema_21306858.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/SolicitudChequeras/solicitudChequerasIn/";

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

declare function xf:solicitudChequerasIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $solicitudChequeras1 as element(ns2:solicitudChequeras),
    $uuid as xs:string)
    as element(ns0:Solicituddechequera) {
        <ns0:Solicituddechequera>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHCHECKBOOKREQUESTISSUEDWSType>
                <ACCOUNTNUMBER>{ data($solicitudChequeras1/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <DESTINATIONAGENCYCODE>{ data($solicitudChequeras1/DESTINATION_BRANCH) }</DESTINATIONAGENCYCODE>
                <NOOFBOOKS>{ data($solicitudChequeras1/NO_OF_BOOKS) }</NOOFBOOKS>
                <CHEQUETYPEID>{ data($solicitudChequeras1/CHEQUEBOOK_TYPE) }</CHEQUETYPEID>
                <AUTHORISEDPERSON>{ data($solicitudChequeras1/AUTHORIZED_CLAIMER) }</AUTHORISEDPERSON>
            </FICOHCHECKBOOKREQUESTISSUEDWSType>
        </ns0:Solicituddechequera>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $solicitudChequeras1 as element(ns2:solicitudChequeras) external;
declare variable $uuid as xs:string external;

xf:solicitudChequerasIn($autenticacionRequestHeader1,
    $solicitudChequeras1,
    $uuid)