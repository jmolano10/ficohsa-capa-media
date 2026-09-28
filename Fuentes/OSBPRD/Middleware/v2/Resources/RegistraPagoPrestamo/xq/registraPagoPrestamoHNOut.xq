(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/RegistraPagoPrestamo/xsd/registraPagoPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registraPagoPrestamoResponse" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoPrestamo/xq/registraPagoPrestamoHNOut/";

declare function xf:registraPagoPrestamoHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:registraPagoPrestamoResponse) {
        <ns0:registraPagoPrestamoResponse>
            <DATE_TIME>{ data($outputParameters/ns1:DATE_TIME) }</DATE_TIME>
            {
                for $LOAN_NUMBER in $outputParameters/ns1:LOAN_NUMBER
                return
                    <LOAN_NUMBER>{ data($LOAN_NUMBER) }</LOAN_NUMBER>
            }
            {
                for $DUE_ID in $outputParameters/ns1:DUE_ID
                return
                    <DUE_ID>{ data($DUE_ID) }</DUE_ID>
            }
            {
                for $PAYMENT_AMOUNT in $outputParameters/ns1:PAYMENT_AMOUNT
                return
                    <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            }
        </ns0:registraPagoPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:registraPagoPrestamoHNOut($outputParameters)