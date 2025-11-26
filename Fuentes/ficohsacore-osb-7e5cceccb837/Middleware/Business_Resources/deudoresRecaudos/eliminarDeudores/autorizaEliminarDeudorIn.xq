(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Autorizaeliminardeudor" location="../Resources/XMLSchema_-2146193603.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/eliminarDeudores/autorizaEliminarDeudorIn/";

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

declare function xf:autorizaEliminarDeudorIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $Id as xs:string)
    as element(ns0:Autorizaeliminardeudor) {
        <ns0:Autorizaeliminardeudor>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername("UREVERSION"), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword("UREVERSION"),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <LATAMAGDEBTORAFFILIATIONLATAMINPUTWSType>
                <transactionId>{ $Id }</transactionId>
            </LATAMAGDEBTORAFFILIATIONLATAMINPUTWSType>
        </ns0:Autorizaeliminardeudor>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $Id as xs:string external;

xf:autorizaEliminarDeudorIn($autenticacionRequestHeader,
    $Id)