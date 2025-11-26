(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito1" element="ns0:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/PagoTarjetaCreditoCBIn/";

declare function xf:PagoTarjetaCreditoCBIn($pagoTarjetaCredito1 as element(ns0:pagoTarjetaCredito),
    $ChannelCode as xs:string)
    as element(ns0:pagoTarjetaCredito) {
        <ns0:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ data($pagoTarjetaCredito1/BALANCE_CURRENCY) }</BALANCE_CURRENCY>
            <PAYMENT_AMOUNT>{ data($pagoTarjetaCredito1/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            <CHANNEL_CODE>{ $ChannelCode }</CHANNEL_CODE>
            <DEBIT_ACCOUNT>{ data($pagoTarjetaCredito1/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            {
                for $INTERFACE_REFERENCE_NO in $pagoTarjetaCredito1/INTERFACE_REFERENCE_NO
                return
                    <INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
            }
        </ns0:pagoTarjetaCredito>
};

declare variable $pagoTarjetaCredito1 as element(ns0:pagoTarjetaCredito) external;
declare variable $ChannelCode as xs:string external;

xf:PagoTarjetaCreditoCBIn($pagoTarjetaCredito1,
    $ChannelCode)