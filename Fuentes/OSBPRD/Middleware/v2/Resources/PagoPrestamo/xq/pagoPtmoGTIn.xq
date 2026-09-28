(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns2:pagoPrestamo" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/pagoPrestamo/xsd/PagoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/pagoPrestamo/xq/pagoPrestamoIn/";

declare function xf:pagoPrestamoIn($pagoPrestamo1 as element(ns2:pagoPrestamo),
    $requestHeader1 as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_NUMBER>{ data($pagoPrestamo1/LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            <ns1:PAYMENT_AMOUNT>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</ns1:PAYMENT_AMOUNT>
            {
                for $DEBIT_ACCOUNT in $pagoPrestamo1/DEBIT_ACCOUNT
                return
                    <ns1:DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            }
            {
                for $INTERFACE_REFERENCE_NO in $pagoPrestamo1/INTERFACE_REFERENCE_NO
                return
                    <ns1:INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            }
            <ns1:USERNAME>{ data($requestHeader1/Authentication/UserName) }</ns1:USERNAME>
        </ns1:InputParameters>
};

declare variable $pagoPrestamo1 as element(ns2:pagoPrestamo) external;
declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:pagoPrestamoIn($pagoPrestamo1,
    $requestHeader1)