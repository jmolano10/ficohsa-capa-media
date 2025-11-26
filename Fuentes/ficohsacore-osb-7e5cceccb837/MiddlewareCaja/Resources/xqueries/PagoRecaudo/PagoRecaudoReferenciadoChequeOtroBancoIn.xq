(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagorecaudoreferenciadochqotrbco" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/PagoRecaudoReferenciadoChequeOtroBancoIn/";

declare function xf:PagoRecaudoReferenciadoChequeOtroBancoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $uuid as xs:string)
    as element(ns0:Pagorecaudoreferenciadochqotrbco) {
        <ns0:Pagorecaudoreferenciadochqotrbco>
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
            <TELLERLATAMREFOBCHQRESWSCOPYType>
                <CURRENCY1>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY1>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <CHEQUENUMBER>{ data($pagoRecaudo/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUENUMBER>
                        <CHEQUEBANKCDE>{ data($pagoRecaudo/PAYMENT_INFORMATION/BANK_CODE) }</CHEQUEBANKCDE>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
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
            </TELLERLATAMREFOBCHQRESWSCOPYType>
        </ns0:Pagorecaudoreferenciadochqotrbco>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoReferenciadoChequeOtroBancoIn($autenticacionRequestHeader,
    $pagoRecaudo,
    $uuid)