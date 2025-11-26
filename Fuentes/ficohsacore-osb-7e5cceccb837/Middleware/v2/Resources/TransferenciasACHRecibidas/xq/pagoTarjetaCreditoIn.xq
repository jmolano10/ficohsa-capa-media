(:: pragma bea:local-element-parameter parameter="$tRANSACTION_DETAIL1" type="ns0:transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/pagoTarjetaCreditoIn/";

declare function xf:pagoTarjetaCreditoIn($tRANSACTION_DETAIL1 as element(),
    $debitAccount as xs:string)
    as element(ns1:pagoTarjetaCredito) {
        <ns1:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ data($tRANSACTION_DETAIL1/DESTINATION) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ data($tRANSACTION_DETAIL1/CURRENCY) }</BALANCE_CURRENCY>
            <PAYMENT_AMOUNT>{ data($tRANSACTION_DETAIL1/AMOUNT) }</PAYMENT_AMOUNT>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
        </ns1:pagoTarjetaCredito>
};

declare variable $tRANSACTION_DETAIL1 as element() external;
declare variable $debitAccount as xs:string external;

xf:pagoTarjetaCreditoIn($tRANSACTION_DETAIL1,
    $debitAccount)