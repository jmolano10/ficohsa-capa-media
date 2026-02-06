xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns2:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagoderecaudoreferenciadodbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/pagoRecaudoReferenciadoDebitoCuentaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "T24WebServicesImpl";

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


declare function xf:pagoRecaudoReferenciadoDebitoCuentaIn($requestHeader as element(ns0:RequestHeader),
    $pagoRecaudo as element(ns2:pagoRecaudo),
    $uuid as xs:string)
    as element(ns1:Pagoderecaudoreferenciadodbcta) {
        <ns1:Pagoderecaudoreferenciadodbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ data($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($pagoRecaudo/DEBTOR_CODE) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
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
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
			        
        </ns1:Pagoderecaudoreferenciadodbcta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoRecaudo as element(ns2:pagoRecaudo) external;
declare variable $uuid as xs:string external;

xf:pagoRecaudoReferenciadoDebitoCuentaIn($requestHeader,
    $pagoRecaudo,
    $uuid)