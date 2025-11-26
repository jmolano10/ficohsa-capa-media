xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMontoTipoChequera" element="ns1:consultaMontoTipoChequera" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Solicituddechequera_Validate" location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTipoChequera/xq/consultaMontoTipoChequeraIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";

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

declare function xf:consultaMontoTipoChequeraIn($requestHeader as element(ns0:RequestHeader),
    $consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera))
    as element(ns2:Solicituddechequera_Validate) {
        <ns2:Solicituddechequera_Validate>
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
            <FICOHCHECKBOOKREQUESTISSUEDWSType>
                <ACCOUNTNUMBER>{ data($consultaMontoTipoChequera/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <CHEQUETYPEID>{ data($consultaMontoTipoChequera/CHECKBOOK_TYPE) }</CHEQUETYPEID>
            </FICOHCHECKBOOKREQUESTISSUEDWSType>
        </ns2:Solicituddechequera_Validate>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera) external;

xf:consultaMontoTipoChequeraIn($requestHeader,
    $consultaMontoTipoChequera)