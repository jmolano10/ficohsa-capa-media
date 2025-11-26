(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/pagoPrestamoT24In/";

declare function xf:pagoPrestamoT24In($transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas),
    $interfaceReferenceNo as xs:string,
    $username as xs:string,
    $transactionId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_NUMBER>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT)), 2) }</ns1:PAYMENT_AMOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ $interfaceReferenceNo }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ $username }</ns1:USERNAME>
            <ns1:TRANSACTIONID>{ $transactionId }</ns1:TRANSACTIONID>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas) external;
declare variable $interfaceReferenceNo as xs:string external;
declare variable $username as xs:string external;
declare variable $transactionId as xs:string external;

xf:pagoPrestamoT24In($transferenciasACHRecibidas,
    $interfaceReferenceNo,
    $username,
    $transactionId)