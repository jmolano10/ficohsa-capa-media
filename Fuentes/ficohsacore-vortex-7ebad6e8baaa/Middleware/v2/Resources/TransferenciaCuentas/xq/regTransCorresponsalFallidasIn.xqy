xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns0:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/regTransCorresponsalFallidas/xsd/regTransCorresponsalFallidas_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/regTransCorresponsalFallidas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/regTransCorresponsalFallidasIn/";

declare function xf:regTransCorresponsalFallidasIn($transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest),
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $uuid as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_SOURCE_COUNTRY>{ $sourceBank }</ns1:PV_SOURCE_COUNTRY>
            <ns1:PV_DESTINATION_COUNTRY>{ $destinationBank }</ns1:PV_DESTINATION_COUNTRY>
            <ns1:PV_DEBIT_ACCOUNT>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</ns1:PV_DEBIT_ACCOUNT>
            <ns1:PV_CREDIT_ACCOUNT>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</ns1:PV_CREDIT_ACCOUNT>
            {
                for $CURRENCY in $transferenciaCuentasRequest/CURRENCY
                return
                    <ns1:PV_CURRENCY>{ data($CURRENCY) }</ns1:PV_CURRENCY>
            }
            <ns1:PV_TRANSFER_AMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</ns1:PV_TRANSFER_AMOUNT>
            {
                for $DEBIT_CREDIT in $transferenciaCuentasRequest/DEBIT_CREDIT
                return
                    <ns1:PV_DEBIT_CREDIT>{ data($DEBIT_CREDIT) }</ns1:PV_DEBIT_CREDIT>
            }
            {
                for $DESCRIPTION in $transferenciaCuentasRequest/DESCRIPTION
                return
                    <ns1:PV_DESCRIPTION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPTION>
            }
            {
                for $TRANSFER_DETAILS in $transferenciaCuentasRequest/TRANSFER_DETAILS
                return
                    <ns1:PV_TRANSFER_DETAILS>{ data($TRANSFER_DETAILS) }</ns1:PV_TRANSFER_DETAILS>
            }
            {
                for $INTERFACE_REFERENCE_NO in $transferenciaCuentasRequest/INTERFACE_REFERENCE_NO
                return
                    <ns1:PV_INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns1:PV_INTERFACE_REFERENCE_NO>
            }
            {
                for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
                return
                    <ns1:PV_FINANCIAL_SECTOR_CATEGORY>{ data($ITEM_LEVEL_1) }</ns1:PV_FINANCIAL_SECTOR_CATEGORY>
            }
            {
                for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
                return
                    <ns1:PV_FINANCIAL_SECTOR_SUBCAT>{ data($ITEM_LEVEL_2) }</ns1:PV_FINANCIAL_SECTOR_SUBCAT>
            }
            <ns1:PV_UID>{ $uuid }</ns1:PV_UID>
            <ns1:PV_TYPETRANS>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="MODE"]/VALUE) }</ns1:PV_TYPETRANS>
        </ns1:InputParameters>
};

declare variable $transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $uuid as xs:string external;

xf:regTransCorresponsalFallidasIn($transferenciaCuentasRequest,
    $sourceBank,
    $destinationBank,
    $uuid)