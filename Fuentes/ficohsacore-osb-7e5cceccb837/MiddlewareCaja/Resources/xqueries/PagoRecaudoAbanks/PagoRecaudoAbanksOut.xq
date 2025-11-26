(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/PagoRecaudoAbanks/pagoRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_PAGO_COBRANZA_ABANKS.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoAbanksResponse" location="../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/PAGO_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/PagoRecaudoAbanksOut/";

declare function xf:PagoRecaudoAbanksOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:pagoRecaudoAbanksResponse) {
        <ns1:pagoRecaudoAbanksResponse>
            {
                for $CONTRACT_NAME in $outputParameters/ns0:CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTOR_CODE in $outputParameters/ns0:DEBTOR_CODE
                return
                    <DEBTOR_CODE>{ data($DEBTOR_CODE) }</DEBTOR_CODE>
            }
            {
                for $DEBTOR_NAME in $outputParameters/ns0:DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $PAYMENT_CURRENCY in $outputParameters/ns0:PAYMENT_CURRENCY
                return
                    <PAYMENT_CURRENCY>{ data($PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                for $EXCHANGE_RATE in $outputParameters/ns0:EXCHANGE_RATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
            {
                for $INPUTTER in $outputParameters/ns0:INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $DATE_TIME in $outputParameters/ns0:DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $BRANCH_NAME in $outputParameters/ns0:BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
            }
            {
                for $RTEFORM in $outputParameters/ns0:RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }
            {
                for $TOTAL_AMOUNT in $outputParameters/ns0:TOTAL_AMOUNT
                return
                    <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            }
            {
                for $BILL_DETAIL in $outputParameters/ns0:BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($BILL_DETAIL) }</BILL_DETAIL>
            }
        </ns1:pagoRecaudoAbanksResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:PagoRecaudoAbanksOut($outputParameters)