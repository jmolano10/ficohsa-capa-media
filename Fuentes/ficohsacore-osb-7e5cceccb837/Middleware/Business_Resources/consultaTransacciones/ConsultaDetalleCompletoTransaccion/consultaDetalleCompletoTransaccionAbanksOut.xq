(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccionResponse" element="ns1:consultaDetalleTransaccionResponse" location="../ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionAbanksOut/";

declare function xf:consultaDetalleCompletoTransaccionAbanksOut($consultaDetalleTransaccionResponse as element(ns1:consultaDetalleTransaccionResponse),
    $accountNumber as xs:string)
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
            <DEBIT_ACCOUNT>
                {
                    if (number(data($consultaDetalleTransaccionResponse/AMOUNT)) = abs(number($consultaDetalleTransaccionResponse/AMOUNT)) * -1) then
                        (data($accountNumber))
                    else 
                        ""
                }
</DEBIT_ACCOUNT>
            {
                for $AMOUNT in $consultaDetalleTransaccionResponse/AMOUNT
                return
                    <DEBIT_AMOUNT>
                        {
                            if (number(data($AMOUNT)) < abs(number(data($AMOUNT)))) then
                                (abs(number(data($AMOUNT))))
                            else 
                                ""
                        }
</DEBIT_AMOUNT>
            }
            <DEBIT_CURRENCY>
                {
                    if (number(data($consultaDetalleTransaccionResponse/AMOUNT)) = abs(number(data($consultaDetalleTransaccionResponse/AMOUNT))) * -1) then
                        (data($consultaDetalleTransaccionResponse/CURRENCY))
                    else 
                        ""
                }
</DEBIT_CURRENCY>
            <CREDIT_ACCOUNT>
                {
                    if (abs(number($consultaDetalleTransaccionResponse/AMOUNT)) = number($consultaDetalleTransaccionResponse/AMOUNT)) then
                        (data($accountNumber))
                    else 
                        ""
                }
</CREDIT_ACCOUNT>
            {
                for $AMOUNT1 in $consultaDetalleTransaccionResponse/AMOUNT
                return
                    <CREDIT_AMOUNT>
                        {
                            if (number(data($AMOUNT1)) = abs(number(data($AMOUNT1)))) then
                                (number(data($AMOUNT1)))
                            else 
                                ""
                        }
</CREDIT_AMOUNT>
            }
            <CREDIT_CURRENCY>
                {
                    if (number($consultaDetalleTransaccionResponse/AMOUNT) = abs(number($consultaDetalleTransaccionResponse/AMOUNT))) then
                        (data($consultaDetalleTransaccionResponse/CURRENCY))
                    else 
                        ""
                }
</CREDIT_CURRENCY>
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
            <TRANSACTION_AMOUNT>{ abs(data($consultaDetalleTransaccionResponse/AMOUNT)) }</TRANSACTION_AMOUNT>
{
                for $COMMISSION_AMOUNT in $consultaDetalleTransaccionResponse/COMMISSION_AMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSION_AMOUNT) }</COMMISSION_AMOUNT>
            }
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultaDetalleTransaccionResponse as element(ns1:consultaDetalleTransaccionResponse) external;
declare variable $accountNumber as xs:string external;

xf:consultaDetalleCompletoTransaccionAbanksOut($consultaDetalleTransaccionResponse,
    $accountNumber)