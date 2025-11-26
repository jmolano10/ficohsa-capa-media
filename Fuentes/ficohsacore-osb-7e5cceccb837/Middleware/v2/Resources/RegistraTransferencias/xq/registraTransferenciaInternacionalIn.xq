(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalResponse" element="ns0:TransferenciaInternacionalResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OSB/RegistraTransferencia/xsd/registraTransferencias_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTransferencias";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraTransferencias/xq/registraTransferenciaInternacionalIn/";

declare function xf:registraTransferenciaInternacionalIn($paisOrigen,
$transferenciaInternacionalResponse as element(ns0:TransferenciaInternacionalResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:PV_SOURCE_COUNTRY>{ $paisOrigen }</ns1:PV_SOURCE_COUNTRY>
            {
                for $DEBITACCTNO in $transferenciaInternacionalResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <ns1:PV_SOURCE_ACCOUNT>{ data($DEBITACCTNO) }</ns1:PV_SOURCE_ACCOUNT>
            }
            {
                for $DEBITCURRENCY in $transferenciaInternacionalResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <ns1:PV_SOURCE_CURRENCY>{ data($DEBITCURRENCY) }</ns1:PV_SOURCE_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $transferenciaInternacionalResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <ns1:PN_SOURCE_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</ns1:PN_SOURCE_AMOUNT>
            }
            {
                for $DEBITCUSTOMER in $transferenciaInternacionalResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <ns1:PV_SOURCE_ACCOUNT_NAME>{ data($DEBITCUSTOMER) }</ns1:PV_SOURCE_ACCOUNT_NAME>
            }
            {
                for $LRDESTCNTRY in $transferenciaInternacionalResponse/FUNDSTRANSFERType/LRDESTCNTRY
                return
                    <ns1:PV_DESTINATION_COUNTRY>{ data($LRDESTCNTRY) }</ns1:PV_DESTINATION_COUNTRY>
            }
            {
                for $CREDITACCTNO in $transferenciaInternacionalResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <ns1:PV_DESTINATION_ACCOUNT>{ data($CREDITACCTNO) }</ns1:PV_DESTINATION_ACCOUNT>
            }
            {
                for $CREDITCURRENCY in $transferenciaInternacionalResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <ns1:PV_DESTINATION_CURRENCY>{ data($CREDITCURRENCY) }</ns1:PV_DESTINATION_CURRENCY>
            }
            {
                for $AMOUNTCREDITED in $transferenciaInternacionalResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <ns1:PN_DESTINATION_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</ns1:PN_DESTINATION_AMOUNT>
            }
            {
                for $CREDITCUSTOMER in $transferenciaInternacionalResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <ns1:PV_DESTINATION_ACCOUNT_NAME>{ data($CREDITCUSTOMER) }</ns1:PV_DESTINATION_ACCOUNT_NAME>
            }
            {
                for $CUSTOMERRATE in $transferenciaInternacionalResponse/FUNDSTRANSFERType/CUSTOMERRATE
                return
                    <ns1:PN_SOURCE_EXCHANGE_RATE>{ data($CUSTOMERRATE) }</ns1:PN_SOURCE_EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $PAYMENTDETAILS in $transferenciaInternacionalResponse/FUNDSTRANSFERType/gPAYMENTDETAILS/PAYMENTDETAILS
                    return
                        <ns1:PV_TRANSFER_DETAILS>{ data($PAYMENTDETAILS) }</ns1:PV_TRANSFER_DETAILS>
                return
                    $result[1]
            }
            {
                for $transactionId in $transferenciaInternacionalResponse/Status/transactionId
                return
                    <ns1:PV_TRANSACTION_ID>{ data($transactionId) }</ns1:PV_TRANSACTION_ID>
            }
            {
                for $BENACCTNO in $transferenciaInternacionalResponse/FUNDSTRANSFERType/BENACCTNO
                return
                    <ns1:PV_BEN_ACCOUNT>{ data($BENACCTNO) }</ns1:PV_BEN_ACCOUNT>
            }
        </ns1:InputParameters>
};


declare variable $paisOrigen as xs:string external;
declare variable $transferenciaInternacionalResponse as element(ns0:TransferenciaInternacionalResponse) external;

xf:registraTransferenciaInternacionalIn($paisOrigen,$transferenciaInternacionalResponse)
