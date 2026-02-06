xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleTransaccion/xsd/ORA_BANK_OSB_CON_DETALLE_MOV.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleTransaccionResponse" location="../../../../Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_DETALLE_MOV/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTransaccionAbanks/xq/consultaDetalleTransaccionGTOut/";

declare function xf:consultaDetalleTransaccionGTOut($outputParameters1 as element(ns1:OutputParameters),
    $details as xs:string)
    as element(ns0:consultaDetalleTransaccionResponse) {
        <ns0:consultaDetalleTransaccionResponse>
            {
                for $TRANSACTION_TYPE in $outputParameters1/ns1:TRANSACTION_TYPE
                return
                    <TYPE>{ data($TRANSACTION_TYPE) }</TYPE>
            }
            {
                for $TRANSACTION_DESCRIPTION in $outputParameters1/ns1:TRANSACTION_DESCRIPTION
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTION_DESCRIPTION) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $CUSTOMER_DESCRIPTION in $outputParameters1/ns1:CUSTOMER_DESCRIPTION
                return
                    <CUSTOMER_DESCRIPTION>{ data($CUSTOMER_DESCRIPTION) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $BOOKING_DATE in $outputParameters1/ns1:BOOKING_DATE
                return
                    <BOOKING_DATE>{ data($BOOKING_DATE) }</BOOKING_DATE>
            }
            {
                for $VALUE_DATE in $outputParameters1/ns1:VALUE_DATE
                return
                    <VALUE_DATE>{ data($VALUE_DATE) }</VALUE_DATE>
            }
            {
                for $CHEQUE_NUMBER in $outputParameters1/ns1:CHEQUE_NUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            }
            {
                for $CURRENCY in $outputParameters1/ns1:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $AMOUNT in $outputParameters1/ns1:AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $PV_COMISION in $outputParameters1/ns1:PV_COMISION
                return
                    <COMMISSION_AMOUNT>{ data($PV_COMISION) }</COMMISSION_AMOUNT>
            }
            {
                for $INPUTTER in $outputParameters1/ns1:INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORIZER in $outputParameters1/ns1:AUTHORIZER
                return
                    <AUTHORIZER>{ data($AUTHORIZER) }</AUTHORIZER>
            }
            <DETAILS>{ fn-bea:inlinedXML($details) }</DETAILS>
        </ns0:consultaDetalleTransaccionResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $details as xs:string external;

xf:consultaDetalleTransaccionGTOut($outputParameters1,
    $details)