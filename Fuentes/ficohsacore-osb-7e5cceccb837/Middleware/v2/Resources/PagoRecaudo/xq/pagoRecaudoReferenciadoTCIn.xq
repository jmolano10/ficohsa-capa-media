(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadodbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoReferenciadoTCIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoRecaudoReferenciadoTCIn($requestHeader1 as element(ns2:RequestHeader),
    $pagoRecaudo1 as element(ns1:pagoRecaudo),
    $uuid as xs:string,
    $debitAccount as xs:string)
    as element(ns0:Pagoderecaudoreferenciadodbcta) {
        <ns0:Pagoderecaudoreferenciadodbcta>
                        <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($pagoRecaudo1/DEBTOR_CODE) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>                
                <LRPAYCODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($pagoRecaudo1/BILL_INFORMATION/BILL_NUMBER) }</LRINVOICENO>
                        <LRDUEDATE>{ data($pagoRecaudo1/BILL_INFORMATION/DUE_DATE) }</LRDUEDATE>
                        <LRAMT>{ concat($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY , $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($pagoRecaudo1/DEBTOR_NAME) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($pagoRecaudo1/CONTRACT_ID) }</LRAGCLIENTID>
                <LRCCARDNO>{ data($pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</LRCCARDNO>
                <LREXPIRYDATE>{ data($pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE) }</LREXPIRYDATE>
                                <gORDERINGBANK g="1">
					<ORDERINGBANK>999999</ORDERINGBANK>
				</gORDERINGBANK>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
        </ns0:Pagoderecaudoreferenciadodbcta>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $uuid as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoRecaudoReferenciadoTCIn($requestHeader1,
    $pagoRecaudo1,
    $uuid,
    $debitAccount)