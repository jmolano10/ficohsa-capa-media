(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse" element="ns2:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$compraRecargaResponse" element="ns1:compraRecargaResponse" location="../../CompraRecarga/xsd/compraRecargaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoCompraRecargaOut/";

declare function xf:pagoRecaudoCompraRecargaOut($consultaDetalleContratoRecaudosResponse as element(ns2:consultaDetalleContratoRecaudosResponse),
    $compraRecargaResponse as element(ns1:compraRecargaResponse))
    as element(ns0:pagoRecaudoResponse) {
        <ns0:pagoRecaudoResponse>
            {
                for $CONTRACT_NAME in $consultaDetalleContratoRecaudosResponse/ns2:consultaDetalleContratoRecaudosResponseType/ns2:consultaDetalleContratoRecaudosResponseRecordType[1]/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTOR_NAME in $compraRecargaResponse/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $INPUTTER in $compraRecargaResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $DATE_TIME in $compraRecargaResponse/DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $BRANCH_NAME in $compraRecargaResponse/BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($compraRecargaResponse/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($compraRecargaResponse/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $PAYMENT_AMOUNT in $compraRecargaResponse/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    for $DEBIT_ACCOUNT in $compraRecargaResponse/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                    return
                        <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                }
            </PAYMENT_INFORMATION>
            {
                for $BILL_DETAIL in $compraRecargaResponse/BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($BILL_DETAIL) }</BILL_DETAIL>
            }
        </ns0:pagoRecaudoResponse>
};

declare variable $consultaDetalleContratoRecaudosResponse as element(ns2:consultaDetalleContratoRecaudosResponse) external;
declare variable $compraRecargaResponse as element(ns1:compraRecargaResponse) external;

xf:pagoRecaudoCompraRecargaOut($consultaDetalleContratoRecaudosResponse,
    $compraRecargaResponse)