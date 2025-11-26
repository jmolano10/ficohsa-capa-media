(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadoefec" location="../Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoReferenciadoEfectivoIn/";

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

declare function xf:pagoRecaudoReferenciadoEfectivoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $uuid as xs:string)
    as element(ns0:Pagoderecaudoreferenciadoefec) {
        <ns0:Pagoderecaudoreferenciadoefec>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <TELLERREFCOLLCASHWSCOPYType>
                <CURRENCY1>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY1>
                <LRPAYCODE>{ data($pagoRecaudo/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER) }</LRINVOICENO>
                        <LRDUEDATE>{ data($pagoRecaudo/BILL_INFORMATION/DUE_DATE) }</LRDUEDATE>
                        <LRAMT>{ concat($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY , $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($pagoRecaudo/DEBTOR_NAME) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($pagoRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
            </TELLERREFCOLLCASHWSCOPYType>
        </ns0:Pagoderecaudoreferenciadoefec>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $uuid as xs:string external; 

xf:pagoRecaudoReferenciadoEfectivoIn($autenticacionRequestHeader,
    $pagoRecaudo,
    $uuid)