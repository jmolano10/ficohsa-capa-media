(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadodbcta" location="../Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoReferenciadoDebitoCuentaIn/";

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

declare function xf:pagoRecaudoReferenciadoDebitoCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $uuid as xs:string,
    $debitAccount as xs:string)
    as element(ns0:Pagoderecaudoreferenciadodbcta) {
        <ns0:Pagoderecaudoreferenciadodbcta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
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
                <LRCCARDNO>{ data($pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</LRCCARDNO>
                <LREXPIRYDATE>{ data($pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE) }</LREXPIRYDATE>
                                <gORDERINGBANK g="1">
					<ORDERINGBANK>999999</ORDERINGBANK>
				</gORDERINGBANK>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
        </ns0:Pagoderecaudoreferenciadodbcta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $uuid as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoRecaudoReferenciadoDebitoCuentaIn($autenticacionRequestHeader,
    $pagoRecaudo,
    $uuid,
    $debitAccount)