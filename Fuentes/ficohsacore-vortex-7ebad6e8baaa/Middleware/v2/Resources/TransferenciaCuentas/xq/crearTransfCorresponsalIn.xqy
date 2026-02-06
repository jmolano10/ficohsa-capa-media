xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest1" element="ns1:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/crearTransfCorresponsal/xsd/crearTransfCorresponsal_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/crearTransfCorresponsal";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/crearTransfCorresponsal/";

declare function xf:crearTransfCorresponsal($transferenciaCuentasRequest1 as element(ns1:transferenciaCuentasRequest),
    $uuid as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEBIT_ACCOUNT>{ data($transferenciaCuentasRequest1/DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
            <ns0:CREDIT_ACCOUNT>{ data($transferenciaCuentasRequest1/CREDIT_ACCOUNT) }</ns0:CREDIT_ACCOUNT>
            {
                for $CURRENCY in $transferenciaCuentasRequest1/CURRENCY
                return
                    <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
            }
            <ns0:TRANSFER_AMOUNT>{ data($transferenciaCuentasRequest1/TRANSFER_AMOUNT) }</ns0:TRANSFER_AMOUNT>
            {
                for $DEBIT_CREDIT in $transferenciaCuentasRequest1/DEBIT_CREDIT
                return
                    <ns0:DEBIT_CREDIT>{ data($DEBIT_CREDIT) }</ns0:DEBIT_CREDIT>
            }
            {
                for $DESCRIPTION in $transferenciaCuentasRequest1/DESCRIPTION
                return
                    <ns0:DESCRIPTION>{ data($DESCRIPTION) }</ns0:DESCRIPTION>
            }
            {
                for $TRANSFER_DETAILS in $transferenciaCuentasRequest1/TRANSFER_DETAILS
                return
                    <ns0:TRANSFER_DETAILS>{ data($TRANSFER_DETAILS) }</ns0:TRANSFER_DETAILS>
            }
            {
                for $INTERFACE_REFERENCE_NO in $transferenciaCuentasRequest1/INTERFACE_REFERENCE_NO
                return
                    <ns0:INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            }
            {
                for $ITEM_LEVEL_1 in $transferenciaCuentasRequest1/ITEM_LEVEL_1
                return
                    <ns0:FINANCIAL_SECTOR_CATEGORY>{ data($ITEM_LEVEL_1) }</ns0:FINANCIAL_SECTOR_CATEGORY>
            }
            {
                for $ITEM_LEVEL_2 in $transferenciaCuentasRequest1/ITEM_LEVEL_2
                return
                    <ns0:FINANCIAL_SECTOR_SUBCATEGORY>{ data($ITEM_LEVEL_2) }</ns0:FINANCIAL_SECTOR_SUBCATEGORY>
            }
            <ns0:PV_UID>{ $uuid }</ns0:PV_UID>
            <ns0:PV_TYPETRANS>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="MODE"]/VALUE) }</ns0:PV_TYPETRANS>
            <ns0:REGISTRATION_DATE>{current-dateTime()}</ns0:REGISTRATION_DATE>
            <ns0:PV_SOURCE_COUNTRY>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="BANK"]/VALUE) }</ns0:PV_SOURCE_COUNTRY>
            <ns0:SOURCE_ACCOUNT>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="DEBIT_ACCOUNT"]/VALUE) }</ns0:SOURCE_ACCOUNT>
            <ns0:SOURCE_CURRENCY>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="DEBIT_ACCOUNT_CURRENCY"]/VALUE) }</ns0:SOURCE_CURRENCY>
            <ns0:SOURCE_AMOUNT>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="DEBIT_AMOUNT"]/VALUE) }</ns0:SOURCE_AMOUNT>
            <ns0:SOURCE_ACCOUNT_NAME>{fn-bea:trim(xs:string(data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="ACCOUNT_OWNER"]/VALUE)))}</ns0:SOURCE_ACCOUNT_NAME>            
            <ns0:PV_DESTINATION_COUNTRY>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="BANK"]/VALUE) }</ns0:PV_DESTINATION_COUNTRY>
            <ns0:DESTINATION_ACCOUNT>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="CREDIT_ACCOUNT"]/VALUE) }</ns0:DESTINATION_ACCOUNT>
            <ns0:DESTINATION_CURRENCY>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="CREDIT_CURRENCY"]/VALUE) }</ns0:DESTINATION_CURRENCY>
            <ns0:DESTINATION_AMOUNT>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="CREDIT_AMOUNT"]/VALUE) }</ns0:DESTINATION_AMOUNT>
            <ns0:DESTINATION_ACCOUNT_NAME>{fn-bea:trim(xs:string(data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="ACCOUNT_OWNER"]/VALUE))) }</ns0:DESTINATION_ACCOUNT_NAME>
            <ns0:SOURCE_EXCHANGE_RATE>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="EXCHANGE_RATE"]/VALUE) }</ns0:SOURCE_EXCHANGE_RATE>
            <ns0:DESTINATION_EXCHANGE_RATE>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="EXCHANGE_RATE"]/VALUE) }</ns0:DESTINATION_EXCHANGE_RATE>
            <ns0:SOURCE_REFERENCE>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="TRANSACTION_ID"]/VALUE) }</ns0:SOURCE_REFERENCE>
            <ns0:DESTINATION_REFERENCE>{ data($transferenciaCuentasRequest1/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY="TRANSACTION_ID"]/VALUE) }</ns0:DESTINATION_REFERENCE>
        </ns0:InputParameters>
};

declare variable $transferenciaCuentasRequest1 as element(ns1:transferenciaCuentasRequest) external;
declare variable $uuid as xs:string external;

xf:crearTransfCorresponsal($transferenciaCuentasRequest1,
    $uuid)