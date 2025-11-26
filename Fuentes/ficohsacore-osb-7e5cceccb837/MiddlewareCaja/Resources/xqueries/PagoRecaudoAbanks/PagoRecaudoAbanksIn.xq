(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks" element="ns1:pagoRecaudoAbanks" location="../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/PagoRecaudoAbanks/pagoRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_PAGO_COBRANZA_ABANKS.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/PAGO_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/PagoRecaudoAbanksIn/";

declare function xf:PagoRecaudoAbanksIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAbanks as element(ns1:pagoRecaudoAbanks))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($pagoRecaudoAbanks/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($pagoRecaudoAbanks/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            {
                for $NUMBER_OF_BILLS in $pagoRecaudoAbanks/NUMBER_OF_BILLS
                return
                    <ns0:NUMBER_OF_BILLS>{ data($NUMBER_OF_BILLS) }</ns0:NUMBER_OF_BILLS>
            }
            {
                for $BILL_NUMBER in $pagoRecaudoAbanks/BILL_NUMBER
                return
                    <ns0:BILL_NUMBER>{ data($BILL_NUMBER) }</ns0:BILL_NUMBER>
            }
            {
                for $AMOUNT in $pagoRecaudoAbanks/AMOUNT
                return
                    <ns0:AMOUNT>{ data($AMOUNT) }</ns0:AMOUNT>
            }
            <ns0:CURRENCY>{ data($pagoRecaudoAbanks/CURRENCY) }</ns0:CURRENCY>
            <ns0:USERNAME>{ data($autenticacionRequestHeader/UserName) }</ns0:USERNAME>
            <ns0:PASSWORD>{ data($autenticacionRequestHeader/Password) }</ns0:PASSWORD>
            <ns0:PAYMENT_METHOD>{ data($pagoRecaudoAbanks/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns0:PAYMENT_METHOD>
            <ns0:PAYMENT_CURRENCY>{ data($pagoRecaudoAbanks/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PAYMENT_CURRENCY>
            {
                for $DEBIT_ACCOUNT in $pagoRecaudoAbanks/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns0:DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
            }
            {
                for $CHEQUE_NUMBER in $pagoRecaudoAbanks/PAYMENT_INFORMATION/CHEQUE_NUMBER
                return
                    <ns0:CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns0:CHEQUE_NUMBER>
            }
            {
                for $BANK_CODE in $pagoRecaudoAbanks/PAYMENT_INFORMATION/BANK_CODE
                return
                    <ns0:BANK_CODE>{ data($BANK_CODE) }</ns0:BANK_CODE>
            }
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudoAbanks/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns0:CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</ns0:CREDIT_CARD_NUMBER>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudoAbanks/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns0:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
            }
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAbanks as element(ns1:pagoRecaudoAbanks) external;

xf:PagoRecaudoAbanksIn($autenticacionRequestHeader,
    $pagoRecaudoAbanks)