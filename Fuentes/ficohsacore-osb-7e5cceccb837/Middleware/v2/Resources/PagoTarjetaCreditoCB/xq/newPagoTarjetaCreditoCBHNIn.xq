(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoCB" element="ns0:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoTarjetaCredito" location="../../../../v3/Resources/PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/newPagoTarjetaCreditoCBHNIn/";

declare function xf:newPagoTarjetaCreditoCBHNIn($pagoTarjetaCreditoCB as element(ns0:pagoTarjetaCredito),
    $ChannelCode as xs:string,
    $FlowTarget as xs:string,
    $paramType as xs:string,
    $FlowValue as xs:string)
    as element(ns0:pagoTarjetaCredito) {
        <ns0:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ data($pagoTarjetaCreditoCB/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ data($pagoTarjetaCreditoCB/BALANCE_CURRENCY) }</BALANCE_CURRENCY>
            <PAYMENT_AMOUNT>{ data($pagoTarjetaCreditoCB/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            <CHANNEL_CODE>{ $ChannelCode }</CHANNEL_CODE>
            <DEBIT_ACCOUNT>{ data($pagoTarjetaCreditoCB/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            <REGIONAL_DETAILS>
                <SOURCE>
                    <KV_PAIR>                     
                        <KEY>FLOW_TARGET</KEY>
                        <VALUE>{$FlowTarget}</VALUE>
                    </KV_PAIR>
                </SOURCE>
                <DESTINATION>
                    <KV_PAIR>                     
                        <KEY>FLOW_VALUES</KEY>
                        {
                        let $variable := fn:concat($FlowValue, '@FM', data($pagoTarjetaCreditoCB/TRANSACTION_ID_BC),'@FM',
                        data($pagoTarjetaCreditoCB/TRANSACTION_UUID),'@FM',
                        data($pagoTarjetaCreditoCB/EXCHANGE_RATE),'@FM',
                        data($pagoTarjetaCreditoCB/ORIGINAL_AMOUNT), '@FM',
                        $paramType, '@FM',
                        data($pagoTarjetaCreditoCB/TC_OWNER_NAME),'@FM',
                        data($pagoTarjetaCreditoCB/PAYER_ID),'@FM',
                        data($pagoTarjetaCreditoCB/PAYER_NAME))
                        return (
                        <VALUE>{$variable}</VALUE>  
                              ) 
                        }      
                    </KV_PAIR>
                </DESTINATION>
            </REGIONAL_DETAILS>
        </ns0:pagoTarjetaCredito>
};

declare variable $pagoTarjetaCreditoCB as element(ns0:pagoTarjetaCredito) external;
declare variable $ChannelCode as xs:string external;
declare variable $FlowTarget as xs:string external;
declare variable $paramType as xs:string external;
declare variable $FlowValue as xs:string external;

xf:newPagoTarjetaCreditoCBHNIn($pagoTarjetaCreditoCB,
    $ChannelCode,
    $FlowTarget,
    $paramType,
    $FlowValue)
