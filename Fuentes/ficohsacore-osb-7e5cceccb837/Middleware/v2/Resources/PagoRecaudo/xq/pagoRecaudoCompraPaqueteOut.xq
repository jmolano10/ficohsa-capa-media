(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse" element="ns2:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$compraPaqueteResponse" element="ns0:compraPaqueteResponse" location="../../CompraPaquete/xsd/compraPaqueteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoCompraPaqueteOut/";

declare function xf:pagoRecaudoCompraPaqueteOut($consultaDetalleContratoRecaudosResponse as element(ns2:consultaDetalleContratoRecaudosResponse),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $compraPaqueteResponse as element(ns0:compraPaqueteResponse))
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $CONTRACT_NAME in $consultaDetalleContratoRecaudosResponse/ns2:consultaDetalleContratoRecaudosResponseType/ns2:consultaDetalleContratoRecaudosResponseRecordType[1]/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTOR_NAME in $compraPaqueteResponse/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $INPUTTER in $compraPaqueteResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $DATE_TIME in $compraPaqueteResponse/DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $BRANCH_NAME in $compraPaqueteResponse/BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $PAYMENT_AMOUNT in $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                    return
                        <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                }
            </PAYMENT_INFORMATION>
        </ns1:pagoRecaudoResponse>
};

declare variable $consultaDetalleContratoRecaudosResponse as element(ns2:consultaDetalleContratoRecaudosResponse) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $compraPaqueteResponse as element(ns0:compraPaqueteResponse) external;

xf:pagoRecaudoCompraPaqueteOut($consultaDetalleContratoRecaudosResponse,
    $pagoRecaudo,
    $compraPaqueteResponse)