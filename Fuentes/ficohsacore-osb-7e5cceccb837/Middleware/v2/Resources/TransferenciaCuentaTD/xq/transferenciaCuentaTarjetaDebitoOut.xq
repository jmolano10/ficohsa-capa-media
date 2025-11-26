(:: pragma bea:global-element-parameter parameter="$transferenciaCuentaTarjetaDebitoResponse" element="ns1:TransferenciaCuentaTarjetaDebitoResponse" location="../../../BusinessServices/T24/svcTransferenciasTD/xsd/XMLSchema_-207313410.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaCuentaTDResponse" location="../xsd/transferenciaCuentaTDTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaCuentaTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentaTD/xq/transferenciaCuentaTarjetaDebitoOut/";

declare function xf:transferenciaCuentaTarjetaDebitoOut($transferenciaCuentaTarjetaDebitoResponse as element(ns1:TransferenciaCuentaTarjetaDebitoResponse))
    as element(ns0:transferenciaCuentaTDResponse) {
        <ns0:transferenciaCuentaTDResponse>
            {
                for $DEBITACCTNO in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $CREDITCUSTOMER in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $CREDITCURRENCY in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTCREDITED in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED),4) }</CREDIT_AMOUNT>
            }
            {
                for $LRCUSTRATE in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/LRCUSTRATE
                return
                    <EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $DATETIME in $transferenciaCuentaTarjetaDebitoResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns0:transferenciaCuentaTDResponse>
};

declare variable $transferenciaCuentaTarjetaDebitoResponse as element(ns1:TransferenciaCuentaTarjetaDebitoResponse) external;

xf:transferenciaCuentaTarjetaDebitoOut($transferenciaCuentaTarjetaDebitoResponse)