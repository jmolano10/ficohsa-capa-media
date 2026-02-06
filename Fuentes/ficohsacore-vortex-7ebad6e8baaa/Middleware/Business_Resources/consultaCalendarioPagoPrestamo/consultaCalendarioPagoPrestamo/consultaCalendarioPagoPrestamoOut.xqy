xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCalendarioPagoPrestamoResponse" location="consultaCalendarioPagoPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAPLANPAGOPRESTAMO/TOPLEVEL-24OSB_CON_PLAN_PAGO_PR/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoOut/";

declare function xf:consultaCalendarioPagoPrestamoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaCalendarioPagoPrestamoResponse) {
        <ns0:consultaCalendarioPagoPrestamoResponse>
            <ns0:consultaCalendarioPagoPrestamoResponseType>
            {
                for $i in (1 to max( (	count($outputParameters/ns1:BILL_REFERENCE/ns1:ITEM),
                						count($outputParameters/ns1:BILL_NUMBER/ns1:ITEM),
                						count($outputParameters/ns1:BILL_DATE/ns1:ITEM),
                						count($outputParameters/ns1:DESCRIPTION/ns1:ITEM),
                						count($outputParameters/ns1:PRINCIPAL_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:INTEREST_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:OVERDUE_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:OTHER_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:BILL_TOTAL_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:BILL_OUTSTANDING_AMOUNT/ns1:ITEM),
                						count($outputParameters/ns1:BILL_STATUS/ns1:ITEM))))
                return
                    <ns0:consultaCalendarioPagoPrestamoResponseRecordType>
                        <BILL_REFERENCE>{ data($outputParameters/ns1:BILL_REFERENCE/ns1:ITEM[$i]) }</BILL_REFERENCE>
                        <BILL_NUMBER>{ data($outputParameters/ns1:BILL_NUMBER/ns1:ITEM[$i]) }</BILL_NUMBER>
                        <BILL_DATE>{ data($outputParameters/ns1:BILL_DATE/ns1:ITEM[$i]) }</BILL_DATE>
                        <DESCRIPTION>{ data($outputParameters/ns1:DESCRIPTION/ns1:ITEM[$i]) }</DESCRIPTION>
                        <PRINCIPAL_AMOUNT>{ data($outputParameters/ns1:PRINCIPAL_AMOUNT/ns1:ITEM[$i]) }</PRINCIPAL_AMOUNT>
                        <INTEREST_AMOUNT>{ data($outputParameters/ns1:INTEREST_AMOUNT/ns1:ITEM[$i]) }</INTEREST_AMOUNT>
                        <OVERDUE_AMOUNT>{ data($outputParameters/ns1:OVERDUE_AMOUNT/ns1:ITEM[$i]) }</OVERDUE_AMOUNT>
                        <OTHER_AMOUNT>{ data($outputParameters/ns1:OTHER_AMOUNT/ns1:ITEM[$i]) }</OTHER_AMOUNT>
                        <BILL_TOTAL_AMOUNT>{ data($outputParameters/ns1:BILL_TOTAL_AMOUNT/ns1:ITEM[$i]) }</BILL_TOTAL_AMOUNT>
                        <BILL_OUTSTANDING_AMOUNT>{ data($outputParameters/ns1:BILL_OUTSTANDING_AMOUNT/ns1:ITEM[$i]) }</BILL_OUTSTANDING_AMOUNT>
                        <BILL_STATUS>{ data($outputParameters/ns1:BILL_STATUS/ns1:ITEM[$i]) }</BILL_STATUS>
                    </ns0:consultaCalendarioPagoPrestamoResponseRecordType>
            }
            </ns0:consultaCalendarioPagoPrestamoResponseType>
        </ns0:consultaCalendarioPagoPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaCalendarioPagoPrestamoOut($outputParameters)