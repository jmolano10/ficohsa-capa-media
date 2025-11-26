(:: pragma bea:global-element-parameter parameter="$bloqueoCertificadoDeposito1" element="ns0:bloqueoCertificadoDeposito" location="bloqueoCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Bloqueodepasivos" location="../Resources/XMLSchema_524093592.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/bloqueoCertificadoDepositoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/bloqueoCertificadoDeposito/bloqueoCertificadoDepositoIn/";

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

declare function xf:bloqueoCertificadoDepositoIn($bloqueoCertificadoDeposito1 as element(ns0:bloqueoCertificadoDeposito),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns1:Bloqueodepasivos) {
        <ns1:Bloqueodepasivos>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<noOfAuth>0</noOfAuth>
            </OfsFunction>
            <ACLOCKEDEVENTSINPUTType>
                <ACCOUNTNUMBER>{ data($bloqueoCertificadoDeposito1/DEPOSIT_NUMBER) }</ACCOUNTNUMBER>
                <FROMDATE>{ data($bloqueoCertificadoDeposito1/BEGIN_DATE) }</FROMDATE>
                <TODATE>{ data($bloqueoCertificadoDeposito1/END_DATE) }</TODATE>
                <LOCKEDAMOUNT>{ data($bloqueoCertificadoDeposito1/BLOCK_AMOUNT) }</LOCKEDAMOUNT>
            </ACLOCKEDEVENTSINPUTType>
        </ns1:Bloqueodepasivos>
};

declare variable $bloqueoCertificadoDeposito1 as element(ns0:bloqueoCertificadoDeposito) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:bloqueoCertificadoDepositoIn($bloqueoCertificadoDeposito1,
    $autenticacionRequestHeader1)