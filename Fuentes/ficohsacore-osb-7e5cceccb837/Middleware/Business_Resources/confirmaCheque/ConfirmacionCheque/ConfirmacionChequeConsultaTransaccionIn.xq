(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$confirmaciondechequesResponse" element="ns0:ConfirmaciondechequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetalledeconfcheque" location="../../consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/ConfirmacionCheque/ConfirmacionChequeConsultaTransaccionIn/";

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

declare function xf:ConfirmacionChequeConsultaTransaccionIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $confirmaciondechequesResponse as element(ns0:ConfirmaciondechequesResponse))
    as element(ns0:Consultadedetalledeconfcheque) {
        <ns0:Consultadedetalledeconfcheque>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSCHQCONFIRMTXNType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $transactionId in $confirmaciondechequesResponse/Status/transactionId
                        return
                            <criteriaValue>{ data($transactionId) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCHQCONFIRMTXNType>
        </ns0:Consultadedetalledeconfcheque>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $confirmaciondechequesResponse as element(ns0:ConfirmaciondechequesResponse) external;

xf:ConfirmacionChequeConsultaTransaccionIn($autenticacionRequestHeader,
    $confirmaciondechequesResponse)