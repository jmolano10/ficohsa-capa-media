(:: pragma bea:global-element-parameter parameter="$registraPagoPrestamo" element="ns0:registraPagoPrestamo" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RegistraPagoPrestamo/xsd/registraPagoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoPrestamo/xq/registraPagoPrestamoHNIn/";

declare function xf:registraPagoPrestamoHNIn($registraPagoPrestamo as element(ns0:registraPagoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:GV_TICKET>{ data($registraPagoPrestamo/TICKET) }</ns1:GV_TICKET>
            <ns1:LOAN_NUMBER>{ data($registraPagoPrestamo/LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ data($registraPagoPrestamo/PAYMENT_AMOUNT) }</ns1:PAYMENT_AMOUNT>
            <ns1:DEBIT_ACCOUNT>{ data($registraPagoPrestamo/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ data($registraPagoPrestamo/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ data($registraPagoPrestamo/USERNAME) }</ns1:USERNAME>
            <ns1:TRANSACTIONID>{ data($registraPagoPrestamo/TRANSACTION_ID) }</ns1:TRANSACTIONID>
        </ns1:InputParameters>
};

declare variable $registraPagoPrestamo as element(ns0:registraPagoPrestamo) external;

xf:registraPagoPrestamoHNIn($registraPagoPrestamo)
