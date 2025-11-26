(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:compraPaquete" location="../../CompraPaquete/xsd/compraPaqueteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoCompraPaqueteIn/";

declare function xf:pagoRecaudoCompraPaqueteIn($pagoRecaudo as element(ns1:pagoRecaudo))
    as element(ns0:compraPaquete) {
        <ns0:compraPaquete>
            <PHONE_CARRIER>{ data($pagoRecaudo/CONTRACT_ID) }</PHONE_CARRIER>
            <PHONE_NUMBER>{ data($pagoRecaudo/DEBTOR_CODE) }</PHONE_NUMBER>
            <PACK_CODE>{ data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER) }</PACK_CODE>
            <AMOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</AMOUNT>
            <DEBIT_ACCOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
        </ns0:compraPaquete>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;

xf:pagoRecaudoCompraPaqueteIn($pagoRecaudo)