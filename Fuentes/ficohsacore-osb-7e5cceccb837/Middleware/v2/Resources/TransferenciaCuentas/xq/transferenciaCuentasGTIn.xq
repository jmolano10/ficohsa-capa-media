(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest1" element="ns1:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/transferenciaCuentas/xsd/TransferenciaCuentas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaCuentas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/transferenciaCuentas/xq/transferenciaCuentasIn/";

declare function xf:transferenciaCuentasIn($transferenciaCuentasRequest1 as element(ns1:transferenciaCuentasRequest),
    $usuarioCanalRequest1 as xs:string)
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
            <ns0:USERNAME>{ $usuarioCanalRequest1 }</ns0:USERNAME>
            {
                for $AUTHORIZATION_TICKET in $transferenciaCuentasRequest1/AUTHORIZATION_TICKET
                return
                    <ns0:AUTHORIZATION_TICKET>{ data($AUTHORIZATION_TICKET) }</ns0:AUTHORIZATION_TICKET>
            }
        </ns0:InputParameters>
};

declare variable $transferenciaCuentasRequest1 as element(ns1:transferenciaCuentasRequest) external;
declare variable $usuarioCanalRequest1 as xs:string external;

xf:transferenciaCuentasIn($transferenciaCuentasRequest1,
    $usuarioCanalRequest1)