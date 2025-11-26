(:: pragma bea:global-element-parameter parameter="$inputParameters" element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCPAOut/";

declare function xf:pagoTCPAOut($inputParameters as element(ns0:InputParameters),
    $outputParameters as element(ns0:OutputParameters))
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            {
                for $PAYMENT_AMOUNT in $inputParameters/ns0:PN_MONTOPAGO
                return
                    <LCY_PAYMENT>{ data($PAYMENT_AMOUNT) }</LCY_PAYMENT>
            }
            {
                for $PAYMENT_CURRENCY in $outputParameters/ns0:PV_MONEDAPAGO
                return
                    <PAYMENT_CURRENCY>{ data($PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                for $PAID_AMOUNT in $outputParameters/ns0:PN_MONTOPAGADO
                return
                    <BALANCE_PAYMENT>{ data($PAID_AMOUNT) }</BALANCE_PAYMENT>
            }
            {
                for $BALANCE_CURRENCY in $inputParameters/ns0:PV_MONEDASALDO
                return
                    <BALANCE_CURRENCY>{ data($BALANCE_CURRENCY) }</BALANCE_CURRENCY>
            }
            {
                for $EXCHANGE_RATE in $outputParameters/ns0:PN_TASACAMBIO
                return
                    <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
            {
                for $DEBIT_ACCOUNT in $inputParameters/ns0:PV_CUENTADEBITO
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $DATETIME in $outputParameters/ns0:PV_DATETIME
                return
                    <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
            }
          
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $inputParameters as element(ns0:InputParameters) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:pagoTCPAOut($inputParameters,
    $outputParameters)