xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns2:pagoPrestamo" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";

declare function xf:pagoPrestamoIn($requestHeader as element(ns0:RequestHeader),
    $pagoPrestamo as element(ns2:pagoPrestamo),
    $transactionID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_NUMBER>{ data($pagoPrestamo/LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</ns1:PAYMENT_AMOUNT>
            <ns1:DEBIT_ACCOUNT>{ data($pagoPrestamo/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ data($pagoPrestamo/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns1:USERNAME>
            <ns1:TRANSACTIONID>{ $transactionID }</ns1:TRANSACTIONID>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoPrestamo as element(ns2:pagoPrestamo) external;
declare variable $transactionID as xs:string external;

xf:pagoPrestamoIn($requestHeader,
    $pagoPrestamo,
    $transactionID)