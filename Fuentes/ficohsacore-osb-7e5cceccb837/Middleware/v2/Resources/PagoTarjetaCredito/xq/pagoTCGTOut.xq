(:: pragma bea:global-element-parameter parameter="$inputParameters1" element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/pagoTarjetaCredito/xsd/PagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/pagoTarjetaCredito/xsd/PagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/pagoTCGTOut/";

declare function xf:pagoTCGTOut($inputParameters1 as element(ns0:InputParameters),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:pagoTarjetaCreditoResponse) {
    
	if (fn:upper-case($outputParameters1/ns0:ERROR_CODE) = "SUCCESS") then ( 
        <ns1:pagoTarjetaCreditoResponse>
            {
                for $PAYMENT_AMOUNT in $inputParameters1/ns0:PAYMENT_AMOUNT
                return
                    <LCY_PAYMENT>{ data($PAYMENT_AMOUNT) }</LCY_PAYMENT>
            }
            {
                for $PAYMENT_CURRENCY in $outputParameters1/ns0:PAYMENT_CURRENCY
                return
                    <PAYMENT_CURRENCY>{ data($PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                for $PAID_AMOUNT in $outputParameters1/ns0:PAID_AMOUNT
                return
                    <BALANCE_PAYMENT>{ data($PAID_AMOUNT) }</BALANCE_PAYMENT>
            }
            {
                for $BALANCE_CURRENCY in $inputParameters1/ns0:BALANCE_CURRENCY
                return
                    <BALANCE_CURRENCY>{ data($BALANCE_CURRENCY) }</BALANCE_CURRENCY>
            }
            {
                for $EXCHANGE_RATE in $outputParameters1/ns0:EXCHANGE_RATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
            {
                for $DEBIT_ACCOUNT in $inputParameters1/ns0:DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $DATETIME in $outputParameters1/ns0:DATETIME
                return
                    <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
            }
        </ns1:pagoTarjetaCreditoResponse>
      ) else (
      	<ns1:pagoTarjetaCreditoResponse/>
      )
};

declare variable $inputParameters1 as element(ns0:InputParameters) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:pagoTCGTOut($inputParameters1,
    $outputParameters1)