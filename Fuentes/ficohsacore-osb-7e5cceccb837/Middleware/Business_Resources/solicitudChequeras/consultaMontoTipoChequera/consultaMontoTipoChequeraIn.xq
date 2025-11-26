(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMontoTipoChequera" element="ns1:consultaMontoTipoChequera" location="consultaMontoTipoChequeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Solicituddechequera_Validate" location="../Resources/XMLSchema_21306858.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/consultaMontoTipoChequera/consultaMontoTipoChequeraIn/";

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

declare function xf:consultaMontoTipoChequeraIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera))
    as element(ns0:Solicituddechequera_Validate) {
        <ns0:Solicituddechequera_Validate>
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
            <FICOHCHECKBOOKREQUESTISSUEDWSType>
                <ACCOUNTNUMBER>{ data($consultaMontoTipoChequera/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <CHEQUETYPEID>{ data($consultaMontoTipoChequera/CHECKBOOK_TYPE) }</CHEQUETYPEID>
            </FICOHCHECKBOOKREQUESTISSUEDWSType>
        </ns0:Solicituddechequera_Validate>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera) external;

xf:consultaMontoTipoChequeraIn($autenticacionRequestHeader,
    $consultaMontoTipoChequera)