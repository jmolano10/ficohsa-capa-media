(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns0:pagoPrestamo" location="../../../BusinessServices/OSB/PagoPrestamoCB/xsd/XMLSchema_-541390746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamo" location="../../../../../MiddlewareCaja/Resources/xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamoCB/xq/PagoPrestamoCBIn/";

declare function xf:PagoPrestamoCBIn($pagoPrestamo1 as element(ns0:pagoPrestamo))
    as element(ns0:pagoPrestamo) {
        <ns0:pagoPrestamo>
            <LOAN_NUMBER>{ data($pagoPrestamo1/LOAN_NUMBER) }</LOAN_NUMBER>
            <PAYMENT_AMOUNT>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            <PAYMENT_CURRENCY>{ data($pagoPrestamo1/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
            <PAYMENT_TYPE>{ data($pagoPrestamo1/PAYMENT_TYPE) }</PAYMENT_TYPE>
            {
                for $DEBIT_ACCOUNT in $pagoPrestamo1/DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $CHEQUE_NUMBER in $pagoPrestamo1/CHEQUE_NUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            }
            {
                for $BANK_CODE in $pagoPrestamo1/BANK_CODE
                return
                    <BANK_CODE>{ data($BANK_CODE) }</BANK_CODE>
            }
            {
                for $INTERFACE_REFERENCE_NO in $pagoPrestamo1/INTERFACE_REFERENCE_NO
                return
                    <INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
            }
            <DESCRIPTION>{ "CODIGO_CORRESPONSAL" }</DESCRIPTION>
            <REPAY_TYPE>{ data($pagoPrestamo1/TRANSACTION_ID_BC) }</REPAY_TYPE>
        </ns0:pagoPrestamo>
};

declare variable $pagoPrestamo1 as element(ns0:pagoPrestamo) external;

xf:PagoPrestamoCBIn($pagoPrestamo1)
