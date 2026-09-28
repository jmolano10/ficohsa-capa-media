(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns1:transferenciasACHRequest" location="transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TransferenciaACH" location="../Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasACH/transferenciasACHIn/";

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

declare function xf:transferenciasACHIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest),
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns0:TransferenciaACH) {
        <ns0:TransferenciaACH>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOHACHORIGINATIONType id = "">
                <DEBITACCOUNT>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <DEBITAMOUNT>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</DEBITAMOUNT>
                <CREDITCURRENCY>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</CREDITCURRENCY>
                <LRBANKCODE>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</LRBANKCODE>
                <BENEFICIARYNAME>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</BENEFICIARYNAME>
                <LRBENPAYACCT>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</LRBENPAYACCT>
                <LRNARADDEND>{ substring(fn:string($transferenciasACHRequest1/TRANSACTION_DESCRIPTION/text()),1,60) }</LRNARADDEND>
                <LRPAYACHTYPE>{ data($transferenciasACHRequest1/ACCOUNT_TYPE) }</LRPAYACHTYPE>
            </FUNDSTRANSFERFICOHACHORIGINATIONType>
        </ns0:TransferenciaACH>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest) external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:transferenciasACHIn($autenticacionRequestHeader1,
    $transferenciasACHRequest1,
    $uuid,
    $auth)