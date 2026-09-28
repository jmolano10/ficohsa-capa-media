(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccionResponse1" element="ns0:consultaDetalleCompletoTransaccionResponse" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MDW/obtenerDescripcion/xsd/ObtenerDescripcion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerDescripcion";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleCompletoTransaccion/xq/consultaDetallecompletoTransaccionOUT/";

declare function xf:consultaDetallecompletoTransaccionOUT($consultaDetalleCompletoTransaccionResponse1 as element(ns0:consultaDetalleCompletoTransaccionResponse),
    $outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
            {
                for $TYPE in $consultaDetalleCompletoTransaccionResponse1/TYPE
                return
                    <TYPE>{ data($TYPE) }</TYPE>
            }
            {
                for $TRANSACTION_CODE in $consultaDetalleCompletoTransaccionResponse1/TRANSACTION_CODE
                return
                    <TRANSACTION_CODE>{ data($TRANSACTION_CODE) }</TRANSACTION_CODE>
            }
            {
                for $PV_TRX_DESCRIPTION in $outputParameters1/ns1:PV_TRX_DESCRIPTION
                return
                    <TRANSACTION_DESCRIPTION>{ data($PV_TRX_DESCRIPTION) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $PV_CUSTOMER_DESCRIPTION in $outputParameters1/ns1:PV_CUSTOMER_DESCRIPTION
                return
                    <CUSTOMER_DESCRIPTION>{ data($PV_CUSTOMER_DESCRIPTION) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $BOOKING_DATE in $consultaDetalleCompletoTransaccionResponse1/BOOKING_DATE
                return
                    <BOOKING_DATE>{ data($BOOKING_DATE) }</BOOKING_DATE>
            }
            {
                for $VALUE_DATE in $consultaDetalleCompletoTransaccionResponse1/VALUE_DATE
                return
                    <VALUE_DATE>{ data($VALUE_DATE) }</VALUE_DATE>
            }
            {
                for $CHEQUE_NUMBER in $consultaDetalleCompletoTransaccionResponse1/CHEQUE_NUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            }
            {
                for $DEBIT_ACCOUNT in $consultaDetalleCompletoTransaccionResponse1/DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $DEBIT_AMOUNT in $consultaDetalleCompletoTransaccionResponse1/DEBIT_AMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBIT_AMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $DEBIT_CURRENCY in $consultaDetalleCompletoTransaccionResponse1/DEBIT_CURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBIT_CURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDIT_ACCOUNT in $consultaDetalleCompletoTransaccionResponse1/CREDIT_ACCOUNT
                return
                    <CREDIT_ACCOUNT>{ data($CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
            }
            {
                for $CREDIT_AMOUNT in $consultaDetalleCompletoTransaccionResponse1/CREDIT_AMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDIT_AMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $CREDIT_CURRENCY in $consultaDetalleCompletoTransaccionResponse1/CREDIT_CURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDIT_CURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $INPUTTER in $consultaDetalleCompletoTransaccionResponse1/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORIZER in $consultaDetalleCompletoTransaccionResponse1/AUTHORIZER
                return
                    <AUTHORIZER>{ data($AUTHORIZER) }</AUTHORIZER>
            }
            {
                for $DETAILS in $consultaDetalleCompletoTransaccionResponse1/DETAILS
                return
                    <DETAILS>{ $DETAILS/@* , $DETAILS/node() }</DETAILS>
            }
            {
                for $EXTERNAL_BEN_ACCOUNT in $consultaDetalleCompletoTransaccionResponse1/EXTERNAL_BEN_ACCOUNT
                return
                    <EXTERNAL_BEN_ACCOUNT>{ data($EXTERNAL_BEN_ACCOUNT) }</EXTERNAL_BEN_ACCOUNT>
            }
            {
                for $CONTRACT_ID in $consultaDetalleCompletoTransaccionResponse1/CONTRACT_ID
                return
                    <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
            }
            {
                for $TRANSACTION_AMOUNT in $consultaDetalleCompletoTransaccionResponse1/TRANSACTION_AMOUNT
                return
                    <TRANSACTION_AMOUNT>{ data($TRANSACTION_AMOUNT) }</TRANSACTION_AMOUNT>
            }
            {
                for $COMMISSION_AMOUNT in $consultaDetalleCompletoTransaccionResponse1/COMMISSION_AMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSION_AMOUNT) }</COMMISSION_AMOUNT>
            }
            {
                for $REMITTANCE_ID in $consultaDetalleCompletoTransaccionResponse1/REMITTANCE_ID
                return
                    <REMITTANCE_ID>{ data($REMITTANCE_ID) }</REMITTANCE_ID>
            }
            {
                for $COLL_PAY_CODE in $consultaDetalleCompletoTransaccionResponse1/COLL_PAY_CODE
                return
                    <COLL_PAY_CODE>{ data($COLL_PAY_CODE) }</COLL_PAY_CODE>
            }
            {
                for $CREDIT_CARD_NUMBER in $consultaDetalleCompletoTransaccionResponse1/CREDIT_CARD_NUMBER
                return
                    <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
            }
            {
                for $PARENT_REFERENCE in $consultaDetalleCompletoTransaccionResponse1/PARENT_REFERENCE
                return
                    <PARENT_REFERENCE>{ data($PARENT_REFERENCE) }</PARENT_REFERENCE>
            }
            {
                for $LOAN_NUMBER in $consultaDetalleCompletoTransaccionResponse1/LOAN_NUMBER
                return
                    <LOAN_NUMBER>{ data($LOAN_NUMBER) }</LOAN_NUMBER>
            }
            {
                for $EXTERNAL_REMITTER_INFO in $consultaDetalleCompletoTransaccionResponse1/EXTERNAL_REMITTER_INFO
                return
                    <EXTERNAL_REMITTER_INFO>{ data($EXTERNAL_REMITTER_INFO) }</EXTERNAL_REMITTER_INFO>
            }
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultaDetalleCompletoTransaccionResponse1 as element(ns0:consultaDetalleCompletoTransaccionResponse) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaDetallecompletoTransaccionOUT($consultaDetalleCompletoTransaccionResponse1,
    $outputParameters1)