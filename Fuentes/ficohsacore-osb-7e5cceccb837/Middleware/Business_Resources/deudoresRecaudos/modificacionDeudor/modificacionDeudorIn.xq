(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$modificacionDeudor" element="ns1:modificacionDeudor" location="modificacionDeudorTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedeudoresResponse" element="ns0:ConsultadedeudoresResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Modificaciondedeudor" location="../Resources/XMLSchema_-2146193603.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/modificacionDeudorTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/modificacionDeudor/modificacionDeudorIn/";

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

declare function xf:modificacionDeudorIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $modificacionDeudor as element(ns1:modificacionDeudor),
    $consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse))
    as element(ns0:Modificaciondedeudor) {
        <ns0:Modificaciondedeudor>
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
            <LATAMAGDEBTORAFFILIATIONDEBTOREDITWSType id = "{ data($consultadedeudoresResponse/WSDEBTORLISTType[1]/gWSDEBTORLISTDetailType/mWSDEBTORLISTDetailType[1]/ID) }">
                <gDEBTORNAME>
                    <DEBTORNAME>{ data($modificacionDeudor/DEBTOR_NAME) }</DEBTORNAME>
                </gDEBTORNAME>
            </LATAMAGDEBTORAFFILIATIONDEBTOREDITWSType>
        </ns0:Modificaciondedeudor>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $modificacionDeudor as element(ns1:modificacionDeudor) external;
declare variable $consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse) external;

xf:modificacionDeudorIn($autenticacionRequestHeader,
    $modificacionDeudor,
    $consultadedeudoresResponse)