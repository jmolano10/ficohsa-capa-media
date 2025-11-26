(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoIn/";

declare function xf:pagoPrestamoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $transactionID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_NUMBER>{ data($pagoPrestamo/LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</ns1:PAYMENT_AMOUNT>
            <ns1:DEBIT_ACCOUNT>{ data($pagoPrestamo/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ data($pagoPrestamo/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ data($autenticacionRequestHeader/UserName) }</ns1:USERNAME>
            <ns1:TRANSACTIONID>{ $transactionID }</ns1:TRANSACTIONID>
        </ns1:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $transactionID as xs:string external;

xf:pagoPrestamoIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $transactionID)