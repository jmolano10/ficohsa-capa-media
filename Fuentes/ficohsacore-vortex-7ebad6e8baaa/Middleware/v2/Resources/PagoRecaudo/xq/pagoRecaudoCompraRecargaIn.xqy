xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:compraRecarga" location="../../../../Business_Resources/recargas/CompraRecarga/compraRecargaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoCompraRecargaIn/";

declare function xf:pagoRecaudoCompraRecargaIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:compraRecarga) {
        <ns1:compraRecarga>
            <PHONE_NUMBER>{ data($pagoRecaudo/DEBTOR_CODE) }</PHONE_NUMBER>
            <SERVICE_PROVIDER_ID>{ data($pagoRecaudo/CONTRACT_ID) }</SERVICE_PROVIDER_ID>
            <AMOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</AMOUNT>
            <DEBIT_ACCOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
        </ns1:compraRecarga>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoRecaudoCompraRecargaIn($pagoRecaudo)