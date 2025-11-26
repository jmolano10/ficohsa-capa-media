(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$devolucionCheque1" element="ns1:devolucionCheque" location="devolucionChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Aplicadevolucionporcheque" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/devolucionChequeTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/devolucionCheque/devolucionChequeIn/";

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

declare function xf:devolucionChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $devolucionCheque1 as element(ns1:devolucionCheque))
    as element(ns0:Aplicadevolucionporcheque) {
        <ns0:Aplicadevolucionporcheque>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>         
            	<messageId></messageId> 
             </OfsFunction>
            <CHEQUECOLLECTIONCHECKRETURNWSType id = "">
                <BANKCODE>{ data($devolucionCheque1/BANK_CODE) }</BANKCODE>
                <CHEQUENUMBER>{ data($devolucionCheque1/CHEQUE_NUMBER) }</CHEQUENUMBER>
                <gCREDITACCNO g = "1">
                    <mCREDITACCNO m = "1">
                        <CHEQUEAMOUNT>{ data($devolucionCheque1/AMOUNT) }</CHEQUEAMOUNT>
                    </mCREDITACCNO>
                </gCREDITACCNO>
                <CLRZONECDE>{ data($devolucionCheque1/CLEARING_CENTRE) }</CLRZONECDE>
                <LRREJECTRESON>{ data($devolucionCheque1/REJECTION_MOTIVE) }</LRREJECTRESON>
            </CHEQUECOLLECTIONCHECKRETURNWSType>
        </ns0:Aplicadevolucionporcheque>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $devolucionCheque1 as element(ns1:devolucionCheque) external;

xf:devolucionChequeIn($autenticacionRequestHeader1,
    $devolucionCheque1)