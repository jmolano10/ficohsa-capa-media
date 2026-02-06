xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccionResponse" element="ns1:consultaDetalleTransaccionResponse" location="../ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionAbanksOut/";

declare function xf:consultaDetalleCompletoTransaccionAbanksOut($consultaDetalleTransaccionResponse as element(ns1:consultaDetalleTransaccionResponse))
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
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
                    <DEBIT_AMOUNT>{ data($AMOUNT) }</DEBIT_AMOUNT>
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
                for $DETAILS in $consultaDetalleTransaccionResponse/DETAILS
                return
                    <DETAILS>
                        {
                            for $DETAIL_RECORD in $DETAILS/DETAIL_RECORD
                            return
                                <DETAIL_RECORD>
                                    {
                                        for $LABEL in $DETAIL_RECORD/LABEL
                                        return
                                            <LABEL>{ data($LABEL) }</LABEL>
                                    }
                                    {
                                        for $VALUE in $DETAIL_RECORD/VALUE
                                        return
                                            <VALUE>{ data($VALUE) }</VALUE>
                                    }
                                </DETAIL_RECORD>
                        }
                    </DETAILS>
            }
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultaDetalleTransaccionResponse as element(ns1:consultaDetalleTransaccionResponse) external;

xf:consultaDetalleCompletoTransaccionAbanksOut($consultaDetalleTransaccionResponse)