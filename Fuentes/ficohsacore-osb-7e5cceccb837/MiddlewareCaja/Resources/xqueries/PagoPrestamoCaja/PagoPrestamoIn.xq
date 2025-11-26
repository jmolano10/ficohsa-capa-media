(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/PagoPrestamoCaja/pagoPrestamoCajaAbanks/ORA_BANK_OSB_K_PAGO_PRESTAMO_TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_PAGO_PRESTAMO/TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoIn/";

declare function xf:PagoPrestamoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $transactionID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_NUMBER>{ data($pagoPrestamo/LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</ns1:PAYMENT_AMOUNT>
            <ns1:DEBIT_ACCOUNT>{ data($pagoPrestamo/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ data($pagoPrestamo/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:DESCRIPTION>{ data($pagoPrestamo/DESCRIPTION) }</ns1:DESCRIPTION>
            <ns1:USERNAME>{ data($autenticacionRequestHeader/UserName) }</ns1:USERNAME>
            <ns1:TRANSACTIONID>{ $transactionID }</ns1:TRANSACTIONID>
            <ns1:PAYMENT_METHOD>{ data($pagoPrestamo/PAYMENT_TYPE) }</ns1:PAYMENT_METHOD>
            <ns1:PAYMENT_TYPE>
            {
                if (string($pagoPrestamo/REPAY_TYPE) = "" or empty($pagoPrestamo/REPAY_TYPE)) then 
                    "FEE"
                else
                	data($pagoPrestamo/REPAY_TYPE)
            }
            </ns1:PAYMENT_TYPE>
        </ns1:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $transactionID as xs:string external;

xf:PagoPrestamoIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $transactionID)
