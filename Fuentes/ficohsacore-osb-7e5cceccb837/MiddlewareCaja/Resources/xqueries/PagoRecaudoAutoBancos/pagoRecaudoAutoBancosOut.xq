(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse" element="ns0:pagoRecaudoResponse" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoAutoBancosResponse" location="../../xsds/PagoRecaudoAutoBancos/PagoRecaudoAutoBancos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAutoBancosTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAutoBancos/pagoRecaudoAutoBancosOut/";

declare function xf:pagoRecaudoAutoBancosOut($pagoRecaudoResponse as element(ns0:pagoRecaudoResponse))
    as element(ns1:pagoRecaudoAutoBancosResponse) {
        <ns1:pagoRecaudoAutoBancosResponse>
            {
                for $CONTRACT_NAME in $pagoRecaudoResponse/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTOR_NAME in $pagoRecaudoResponse/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $INPUTTER in $pagoRecaudoResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $DATE_TIME in $pagoRecaudoResponse/DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $BRANCH_NAME in $pagoRecaudoResponse/BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
            }
            {
                for $RTEFORM in $pagoRecaudoResponse/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }
            <PAYMENT_INFORMATION>{ $pagoRecaudoResponse/PAYMENT_INFORMATION/@* , $pagoRecaudoResponse/PAYMENT_INFORMATION/node() }</PAYMENT_INFORMATION>
            {
                for $BILL_DETAIL in $pagoRecaudoResponse/BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($BILL_DETAIL) }</BILL_DETAIL>
            }
        </ns1:pagoRecaudoAutoBancosResponse>
};

declare variable $pagoRecaudoResponse as element(ns0:pagoRecaudoResponse) external;

xf:pagoRecaudoAutoBancosOut($pagoRecaudoResponse)