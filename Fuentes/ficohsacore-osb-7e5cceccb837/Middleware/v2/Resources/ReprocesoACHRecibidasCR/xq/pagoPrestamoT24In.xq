(:: pragma bea:global-element-parameter parameter="$reprocesoACHRecibidasCR" element="ns0:reprocesoACHRecibidasCR" location="../xsd/reprocesoACHRecibidasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHRecibidasCRTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHRecibidasCR/xq/pagoPrestamoT24In/";

declare function xf:pagoPrestamoT24In($reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR),
    $username as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $BEN_ACCOUNT in $reprocesoACHRecibidasCR/BEN_ACCOUNT
                return
                    <ns1:LOAN_NUMBER>{ data($BEN_ACCOUNT) }</ns1:LOAN_NUMBER>
            }
            <ns1:PAYMENT_AMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($reprocesoACHRecibidasCR/BEN_AMOUNT)), 2) }</ns1:PAYMENT_AMOUNT>
            <ns1:INTERFACE_REFERENCE_NO>{ data($reprocesoACHRecibidasCR/ACH_SEQUENCE) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ $username }</ns1:USERNAME>
            {
                for $T24_TRANSACTION_REF in $reprocesoACHRecibidasCR/T24_TRANSACTION_REF
                return
                    <ns1:TRANSACTIONID>{ data($T24_TRANSACTION_REF) }</ns1:TRANSACTIONID>
            }
        </ns1:InputParameters>
};

declare variable $reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR) external;
declare variable $username as xs:string external;

xf:pagoPrestamoT24In($reprocesoACHRecibidasCR,
    $username)