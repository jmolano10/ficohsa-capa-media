(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$afiliacionDeudores" element="ns1:afiliacionDeudores" location="afiliacionDeudoresTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Afiliaciondedeudores" location="../Resources/XMLSchema_-2146193603.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/afiliacionDeudoresTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/afiliacionDeudores/afiliacionDeudoresIn/";

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

declare function xf:afiliacionDeudoresIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $afiliacionDeudores as element(ns1:afiliacionDeudores))
    as element(ns0:Afiliaciondedeudores) {
        <ns0:Afiliaciondedeudores>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <LATAMAGDEBTORAFFILIATIONLATAMINPUTWSType>
                <DEBTORCODE>{ data($afiliacionDeudores/DEBTOR_CODE) }</DEBTORCODE>
                <gDEBTORNAME g = "1">
                    <DEBTORNAME>{ data($afiliacionDeudores/DEBTOR_NAME) }</DEBTORNAME>
                </gDEBTORNAME>
                <AGRCONTRACTID>{ data($afiliacionDeudores/COLLECTION_CODE) }</AGRCONTRACTID>
            </LATAMAGDEBTORAFFILIATIONLATAMINPUTWSType>
        </ns0:Afiliaciondedeudores>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $afiliacionDeudores as element(ns1:afiliacionDeudores) external;

xf:afiliacionDeudoresIn($autenticacionRequestHeader,
    $afiliacionDeudores)