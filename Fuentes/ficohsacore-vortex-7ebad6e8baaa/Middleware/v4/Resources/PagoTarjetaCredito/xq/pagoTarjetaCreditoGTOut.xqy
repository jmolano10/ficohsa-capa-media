xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inputParameters" element="ns0:InputParameters" location="../../../../v3/BusinessServices/ABKGT/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../v3/BusinessServices/ABKGT/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoGTOut/";

declare function xf:pagoTarjetaCreditoGTOut($inputParameters as element(ns0:InputParameters),
    $outputParameters as element(ns0:OutputParameters),
    $tasaCambio as xs:string)
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            <LCY_PAYMENT>{ data($inputParameters/ns0:PN_MONTOPAGO) }</LCY_PAYMENT>
            {
                for $PV_MONEDAPAGO in $outputParameters/ns0:PV_MONEDAPAGO
                return
                    <PAYMENT_CURRENCY>{ data($PV_MONEDAPAGO) }</PAYMENT_CURRENCY>
            }
            {
                for $PN_MONTOPAGADO in $outputParameters/ns0:PN_MONTOPAGADO
                return
                    <BALANCE_PAYMENT>{ data($PN_MONTOPAGADO) }</BALANCE_PAYMENT>
            }
            {
                for $PV_MONEDASALDO in $inputParameters/ns0:PV_MONEDASALDO
                return
                    <BALANCE_CURRENCY>{ data($PV_MONEDASALDO) }</BALANCE_CURRENCY>
            }
            <EXCHANGE_RATE>{ $tasaCambio }</EXCHANGE_RATE>
            {
                for $PV_CUENTADEBITO in $inputParameters/ns0:PV_CUENTADEBITO
                return
                    <DEBIT_ACCOUNT>{ data($PV_CUENTADEBITO) }</DEBIT_ACCOUNT>
            }
            {
                for $PV_DATETIME in $outputParameters/ns0:PV_DATETIME
                return
                    <DATE_TIME>{ data($PV_DATETIME) }</DATE_TIME>
            }
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $inputParameters as element(ns0:InputParameters) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $tasaCambio as xs:string external;

xf:pagoTarjetaCreditoGTOut($inputParameters,
    $outputParameters,
    $tasaCambio)