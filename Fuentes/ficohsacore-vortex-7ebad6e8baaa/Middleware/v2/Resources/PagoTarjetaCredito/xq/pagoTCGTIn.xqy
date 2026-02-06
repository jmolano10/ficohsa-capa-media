xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito1" element="ns1:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/pagoTarjetaCredito/xsd/PagoTarjetaCredito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoTarjetaCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/pagoTarjetaCredito/xq/pagoTarjetaCreditoIn/";

declare function xf:pagoTarjetaCreditoIn($pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito),
    $usuarioCanal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CREDIT_CARD_NUMBER>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</ns0:CREDIT_CARD_NUMBER>
            <ns0:BALANCE_CURRENCY>{ data($pagoTarjetaCredito1/BALANCE_CURRENCY) }</ns0:BALANCE_CURRENCY>
            <ns0:PAYMENT_AMOUNT>{ data($pagoTarjetaCredito1/PAYMENT_AMOUNT) }</ns0:PAYMENT_AMOUNT>
            <ns0:DEBIT_ACCOUNT>{ data($pagoTarjetaCredito1/DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
            {
                for $INTERFACE_REFERENCE_NO in $pagoTarjetaCredito1/INTERFACE_REFERENCE_NO
                return
                    <ns0:INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            }
            <ns0:USERNAME>{ $usuarioCanal }</ns0:USERNAME>
        </ns0:InputParameters>
};

declare variable $pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito) external;
declare variable $usuarioCanal as xs:string external;

xf:pagoTarjetaCreditoIn($pagoTarjetaCredito1,
    $usuarioCanal)