(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/pagoPrestamo/xsd/PagoPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoPrestamoResponse" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/pagoPrestamo/xq/pagoPrestamoOut/";

declare function xf:pagoPrestamoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:pagoPrestamoResponse) {
        <ns1:pagoPrestamoResponse>
            <DATE_TIME>{ data($outputParameters1/ns0:DATE_TIME) }</DATE_TIME>
            <LOAN_NUMBER>{ data($outputParameters1/ns0:LOAN_NUMBER) }</LOAN_NUMBER>
            <DUE_ID>{ data($outputParameters1/ns0:DUE_ID) }</DUE_ID>
            <PAYMENT_AMOUNT>{ data($outputParameters1/ns0:PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
        </ns1:pagoPrestamoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:pagoPrestamoOut($outputParameters1)