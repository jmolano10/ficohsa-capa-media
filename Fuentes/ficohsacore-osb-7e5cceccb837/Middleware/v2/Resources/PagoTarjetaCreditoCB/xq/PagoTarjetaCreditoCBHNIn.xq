(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoCBRequest" element="ns0:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoTarjetaCredito" location="../../../BusinessServices/PagoTarjetaCreditoCB/xsd/XMLSchema_1378853493.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/PagoTarjetaCreditoCBHNIn/";

declare function xf:PagoTarjetaCreditoCBHNIn($pagoTarjetaCreditoCBRequest as element(ns0:pagoTarjetaCredito),
    $ChannelCode as xs:string)
    as element(ns0:pagoTarjetaCredito) {
        <ns0:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ data($pagoTarjetaCreditoCBRequest/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ data($pagoTarjetaCreditoCBRequest/BALANCE_CURRENCY) }</BALANCE_CURRENCY>
            <PAYMENT_AMOUNT>{ data($pagoTarjetaCreditoCBRequest/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            <CHANNEL_CODE>{ $ChannelCode }</CHANNEL_CODE>
            <DEBIT_ACCOUNT>{ data($pagoTarjetaCreditoCBRequest/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            <REGIONAL_DETAILS>
                <SOURCE>
                    <KV_PAIR>                     
                        <KEY>REFERENCIA_CORRESPONSAL</KEY>
                        <VALUE>{ data($pagoTarjetaCreditoCBRequest/TRANSACTION_ID_BC) }</VALUE>
                    </KV_PAIR>
                </SOURCE>
            </REGIONAL_DETAILS>
        </ns0:pagoTarjetaCredito>
};

declare variable $pagoTarjetaCreditoCBRequest as element(ns0:pagoTarjetaCredito) external;
declare variable $ChannelCode as xs:string external;

xf:PagoTarjetaCreditoCBHNIn($pagoTarjetaCreditoCBRequest,
    $ChannelCode)
