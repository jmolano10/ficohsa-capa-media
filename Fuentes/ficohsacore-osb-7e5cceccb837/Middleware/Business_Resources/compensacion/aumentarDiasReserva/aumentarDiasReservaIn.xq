(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$aumentarDiasReserva1" element="ns1:aumentarDiasReserva" location="aumentarDiasReservaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Aumentadiasdereserva" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aumentarDiasReservaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/aumentarDiasReserva/aumentarDiasReservaIn/";

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

declare function xf:aumentarDiasReservaIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $aumentarDiasReserva1 as element(ns1:aumentarDiasReserva))
    as element(ns0:Aumentadiasdereserva) {
        <ns0:Aumentadiasdereserva>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>         
            	<messageId></messageId> 
         	</OfsFunction>
            <CHEQUECOLLECTIONAUTORESERVEINCREASEWSType>
                <BANKCODE>{ data($aumentarDiasReserva1/BANK_CODE) }</BANKCODE>
                <CHEQUENUMBER>{ data($aumentarDiasReserva1/CHEQUE_NUMBER) }</CHEQUENUMBER>
                <gCREDITACCNO g = "1">
                    <mCREDITACCNO m = "1">
                        <CHEQUEAMOUNT>{ data($aumentarDiasReserva1/AMOUNT) }</CHEQUEAMOUNT>
                    </mCREDITACCNO>
                </gCREDITACCNO>
                <CLRZONECDE>{ data($aumentarDiasReserva1/CLEARING_CENTRE) }</CLRZONECDE>
            </CHEQUECOLLECTIONAUTORESERVEINCREASEWSType>
        </ns0:Aumentadiasdereserva>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $aumentarDiasReserva1 as element(ns1:aumentarDiasReserva) external;

xf:aumentarDiasReservaIn($autenticacionRequestHeader1,
    $aumentarDiasReserva1)