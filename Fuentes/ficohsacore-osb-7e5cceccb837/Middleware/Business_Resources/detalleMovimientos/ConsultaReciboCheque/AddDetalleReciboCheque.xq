(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccionResponse" element="ns0:consultaDetalleTransaccionResponse" location="../../consultaTransacciones/ConsultaDetalleTransaccion/consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleTransaccionResponse" location="../../consultaTransacciones/ConsultaDetalleTransaccion/consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientos/ConsultaReciboCheque/AddDetalleReciboCheque/";

declare function xf:AddDetalleReciboCheque($consultaDetalleTransaccionResponse as element(ns0:consultaDetalleTransaccionResponse),
    $details as xs:string)
    as element(ns0:consultaDetalleTransaccionResponse) {
        <ns0:consultaDetalleTransaccionResponse>
            {
                for $TYPE in $consultaDetalleTransaccionResponse/TYPE
                return
                    <TYPE>{ data($TYPE) }</TYPE>
            }
            {
                for $TRANSACTION_DESCRIPTION in $consultaDetalleTransaccionResponse/TRANSACTION_DESCRIPTION
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTION_DESCRIPTION) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $CUSTOMER_DESCRIPTION in $consultaDetalleTransaccionResponse/CUSTOMER_DESCRIPTION
                return
                    <CUSTOMER_DESCRIPTION>{ data($CUSTOMER_DESCRIPTION) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $BOOKING_DATE in $consultaDetalleTransaccionResponse/BOOKING_DATE
                return
                    <BOOKING_DATE>{ data($BOOKING_DATE) }</BOOKING_DATE>
            }
            {
                for $VALUE_DATE in $consultaDetalleTransaccionResponse/VALUE_DATE
                return
                    <VALUE_DATE>{ data($VALUE_DATE) }</VALUE_DATE>
            }
            {
                for $CHEQUE_NUMBER in $consultaDetalleTransaccionResponse/CHEQUE_NUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            }
            {
                for $AMOUNT in $consultaDetalleTransaccionResponse/AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $INPUTTER in $consultaDetalleTransaccionResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORIZER in $consultaDetalleTransaccionResponse/AUTHORIZER
                return
                    <AUTHORIZER>{ data($AUTHORIZER) }</AUTHORIZER>
            }
            {
                for $TRANSACTION_AMOUNT in $consultaDetalleTransaccionResponse/TRANSACTION_AMOUNT
                return
                    <TRANSACTION_AMOUNT>{ data($TRANSACTION_AMOUNT) }</TRANSACTION_AMOUNT>
            }
            {
                for $COMMISSION_AMOUNT in $consultaDetalleTransaccionResponse/COMMISSION_AMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSION_AMOUNT) }</COMMISSION_AMOUNT>
            }
            <DETAILS>{ fn-bea:inlinedXML($details) }</DETAILS>
        </ns0:consultaDetalleTransaccionResponse>
};

declare variable $consultaDetalleTransaccionResponse as element(ns0:consultaDetalleTransaccionResponse) external;
declare variable $details as xs:string external;

xf:AddDetalleReciboCheque($consultaDetalleTransaccionResponse,
    $details)