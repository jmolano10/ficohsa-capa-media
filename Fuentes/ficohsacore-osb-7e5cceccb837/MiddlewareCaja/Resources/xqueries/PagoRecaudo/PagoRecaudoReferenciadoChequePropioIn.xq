(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagorecaudoreferenciadoficochq" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/PagoRecaudoReferenciadoChequePropioIn/";

declare function xf:PagoRecaudoReferenciadoChequePropioIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $uuid as xs:string)
    as element(ns0:Pagorecaudoreferenciadoficochq) {
        <ns0:Pagorecaudoreferenciadoficochq>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <FUNDSTRANSFERLATAMFICOREQCHQWSCOPYType>
                <DEBITACCTNO>{ data($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <CHEQUENUMBER>{ data($pagoRecaudo/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUENUMBER>
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
            </FUNDSTRANSFERLATAMFICOREQCHQWSCOPYType>
        </ns0:Pagorecaudoreferenciadoficochq>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoReferenciadoChequePropioIn($autenticacionRequestHeader,
    $pagoRecaudo,
    $uuid)