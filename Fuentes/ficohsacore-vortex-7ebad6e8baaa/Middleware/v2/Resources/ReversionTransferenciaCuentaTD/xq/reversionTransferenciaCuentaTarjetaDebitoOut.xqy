xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reversionTransferenciaCuentaTDResponse" element="ns0:ReversionTransferenciaCuentaTDResponse" location="../../../BusinessServices/T24/svcTransferenciasTD/xsd/XMLSchema_-207313410.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversionTransferenciaCuentaTDResponse" location="../xsd/reversionTransferenciaCuentaTDTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionTransferenciaCuentaTDTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionTransferenciaCuentaTD/xq/reversionTransferenciaCuentaTarjetaDebitoOut/";

declare function xf:reversionTransferenciaCuentaTarjetaDebitoOut($reversionTransferenciaCuentaTDResponse as element(ns0:ReversionTransferenciaCuentaTDResponse))
    as element(ns1:reversionTransferenciaCuentaTDResponse) {
        <ns1:reversionTransferenciaCuentaTDResponse>
            {
                for $DEBITACCTNO in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $CREDITCUSTOMER in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $CREDITCURRENCY in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTCREDITED in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED),4) }</CREDIT_AMOUNT>
            }
            {
                for $LRCUSTRATE in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/LRCUSTRATE
                return
                    <EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $DATETIME in $reversionTransferenciaCuentaTDResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:reversionTransferenciaCuentaTDResponse>
};

declare variable $reversionTransferenciaCuentaTDResponse as element(ns0:ReversionTransferenciaCuentaTDResponse) external;

xf:reversionTransferenciaCuentaTarjetaDebitoOut($reversionTransferenciaCuentaTDResponse)