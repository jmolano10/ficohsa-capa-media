(:: pragma bea:global-element-parameter parameter="$pagodeTCenFTResponse" element="ns0:PagodeTCenFTResponse" location="../../../../v2/BusinessServices/T24/svcPagoTarjetaCredito_DebitoCuenta/xsd/PagoTarjetaCredito_DebitoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCHNOut/";

declare function xf:pagoTCHNOut($pagodeTCenFTResponse as element(ns0:PagodeTCenFTResponse))
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            {
                for $DEBITAMOUNT in $pagodeTCenFTResponse/FUNDSTRANSFERType/DEBITAMOUNT
                return
                    <LCY_PAYMENT>{ data($DEBITAMOUNT) }</LCY_PAYMENT>
            }
            {
                for $DEBITCURRENCY in $pagodeTCenFTResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <PAYMENT_CURRENCY>{ data($DEBITCURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                for $LRCRAMT in $pagodeTCenFTResponse/FUNDSTRANSFERType/LRCRAMT
                return
                    <BALANCE_PAYMENT>{ data($LRCRAMT) }</BALANCE_PAYMENT>
            }
            {
                for $LRCCARDCCY in $pagodeTCenFTResponse/FUNDSTRANSFERType/LRCCARDCCY
                return
                    <BALANCE_CURRENCY>{ data($LRCCARDCCY) }</BALANCE_CURRENCY>
            }
            {
                for $LREXCHRTBR in $pagodeTCenFTResponse/FUNDSTRANSFERType/LREXCHRTBR
                return
                    <EXCHANGE_RATE>{ data($LREXCHRTBR) }</EXCHANGE_RATE>
            }
            {
                for $DEBITACCTNO in $pagodeTCenFTResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                let $result :=
                    for $DATETIME in $pagodeTCenFTResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat('20', $DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $DEBITCURRENCY in $pagodeTCenFTResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            <DEBIT_AMOUNT>{ data($pagodeTCenFTResponse/FUNDSTRANSFERType/DEBITAMOUNT) }</DEBIT_AMOUNT>
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $pagodeTCenFTResponse as element(ns0:PagodeTCenFTResponse) external;

xf:pagoTCHNOut($pagodeTCenFTResponse)
