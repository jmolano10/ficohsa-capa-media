(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasResponse" element="ns0:TransferenciaentrecuentasResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/RegistraTransferencia/xsd/registraTransCuenta_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTransCuenta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/RegistraTransferencias/registraTransEntreCuentasIn/";

declare function xf:registraTransEntreCuentasIn($transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $DEBITACCTNO in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <ns1:PV_SOURCE_ACCOUNT>{ data($DEBITACCTNO) }</ns1:PV_SOURCE_ACCOUNT>
            }
            {
                for $DEBITCURRENCY in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <ns1:PV_SOURCE_CURRENCY>{ data($DEBITCURRENCY) }</ns1:PV_SOURCE_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <ns1:PN_SOURCE_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</ns1:PN_SOURCE_AMOUNT>
            }
            {
                for $DEBITCUSTOMER in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <ns1:PV_SOURCE_ACCOUNT_NAME>{ data($DEBITCUSTOMER) }</ns1:PV_SOURCE_ACCOUNT_NAME>
            }
            {
                for $CREDITACCTNO in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <ns1:PV_DESTINATION_ACCOUNT>{ data($CREDITACCTNO) }</ns1:PV_DESTINATION_ACCOUNT>
            }
            {
                for $CREDITCURRENCY in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <ns1:PV_DESTINATION_CURRENCY>{ data($CREDITCURRENCY) }</ns1:PV_DESTINATION_CURRENCY>
            }
            {
                for $AMOUNTCREDITED in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <ns1:PN_DESTINATION_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</ns1:PN_DESTINATION_AMOUNT>
            }
            {
                for $CREDITCUSTOMER in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <ns1:PV_DESTINATION_ACCOUNT_NAME>{ data($CREDITCUSTOMER) }</ns1:PV_DESTINATION_ACCOUNT_NAME>
            }
            {
                for $CUSTOMERRATE in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CUSTOMERRATE
                return
                    <ns1:PN_SOURCE_EXCHANGE_RATE>{ data($CUSTOMERRATE) }</ns1:PN_SOURCE_EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $PAYMENTDETAILS in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/gPAYMENTDETAILS/PAYMENTDETAILS
                    return
                        <ns1:PV_TRANSFER_DETAILS>{ data($PAYMENTDETAILS) }</ns1:PV_TRANSFER_DETAILS>
                return
                    $result[1]
            }
            {
                for $transactionId in $transferenciaentrecuentasResponse/Status/transactionId
                return
                    <ns1:PV_TRANSACTION_ID>{ data($transactionId) }</ns1:PV_TRANSACTION_ID>
            }
            {
                for $BENACCTNO in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/BENACCTNO
                return
                    <ns1:PV_BEN_ACCOUNT>{ data($BENACCTNO) }</ns1:PV_BEN_ACCOUNT>
            }
        </ns1:InputParameters>
};

declare variable $transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse) external;

xf:registraTransEntreCuentasIn($transferenciaentrecuentasResponse)
