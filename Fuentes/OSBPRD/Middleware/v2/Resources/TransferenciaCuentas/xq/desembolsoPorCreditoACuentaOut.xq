(:: pragma bea:global-element-parameter parameter="$desembolsoporcreditoacuentaResponse" element="ns0:DesembolsoporcreditoacuentaResponse" location="../../../BusinessServices/T24/DesembolsoPrestamoCreditoCuenta/xsd/svcDesembolsoPrestamoCredCtaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/desembolsoPorCreditoACuentaOut/";

declare function xf:desembolsoPorCreditoACuentaOut($desembolsoporcreditoacuentaResponse as element(ns0:DesembolsoporcreditoacuentaResponse))
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCURRENCY in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $DEBITAMOUNT in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/DEBITAMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBITAMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $CREDITAMOUNT in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDITAMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $LRCOMMDETAILS in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/LRCOMMDETAILS
                return
                    <TRANSFER_DETAILS>{ data($LRCOMMDETAILS) }</TRANSFER_DETAILS>
            }
            {
                for $TREASURYRATE in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/TREASURYRATE
                return
                    <EXCHANGE_RATE>{ data($TREASURYRATE) }</EXCHANGE_RATE>
            }
            {
                for $PROCESSINGDATE in $desembolsoporcreditoacuentaResponse/FUNDSTRANSFERType/PROCESSINGDATE
                return
                    <DATE_TIME>{ data($PROCESSINGDATE) }</DATE_TIME>
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $desembolsoporcreditoacuentaResponse as element(ns0:DesembolsoporcreditoacuentaResponse) external;

xf:desembolsoPorCreditoACuentaOut($desembolsoporcreditoacuentaResponse)