(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAutoBancos" element="ns1:pagoRecaudoAutoBancos" location="../../xsds/PagoRecaudoAutoBancos/PagoRecaudoAutoBancos.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAutoBancosTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAutoBancos/pagoRecaudoAutoBancos/";

declare function xf:pagoRecaudoAutoBancos($pagoRecaudoAutoBancos as element(ns1:pagoRecaudoAutoBancos))
    as element(ns0:pagoRecaudo) {
        <ns0:pagoRecaudo>
            <CONTRACT_ID>{ data($pagoRecaudoAutoBancos/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudoAutoBancos/DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $DEBTOR_NAME in $pagoRecaudoAutoBancos/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            <PAYMENT_INFORMATION>{ $pagoRecaudoAutoBancos/PAYMENT_INFORMATION/@* , $pagoRecaudoAutoBancos/PAYMENT_INFORMATION/node() }</PAYMENT_INFORMATION>
            {
                for $BILL_INFORMATION in $pagoRecaudoAutoBancos/BILL_INFORMATION
                return
                    <BILL_INFORMATION>{ $BILL_INFORMATION/@* , $BILL_INFORMATION/node() }</BILL_INFORMATION>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $pagoRecaudoAutoBancos/EXTENDED_COLLECTION_YES_NO
                return
                    <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
            }
            {
                for $ADDITIONAL_INFO in $pagoRecaudoAutoBancos/ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>{ $ADDITIONAL_INFO/@* , $ADDITIONAL_INFO/node() }</ADDITIONAL_INFO>
            }
        </ns0:pagoRecaudo>
};

declare variable $pagoRecaudoAutoBancos as element(ns1:pagoRecaudoAutoBancos) external;

xf:pagoRecaudoAutoBancos($pagoRecaudoAutoBancos)