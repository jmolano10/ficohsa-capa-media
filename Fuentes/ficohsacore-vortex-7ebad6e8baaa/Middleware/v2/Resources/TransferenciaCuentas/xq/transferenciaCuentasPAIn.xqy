xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest1" element="ns0:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/transferenciaCuentas/xsd/transferenciaCuentas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/transferenciaCuentas/xq/transferenciaCuentasIn/";

declare function xf:transferenciaCuentasIn($transferenciaCuentasRequest1 as element(ns0:transferenciaCuentasRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:DEBIT_ACCOUNT>{ data($transferenciaCuentasRequest1/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:CREDIT_ACCOUNT>{ data($transferenciaCuentasRequest1/CREDIT_ACCOUNT) }</ns1:CREDIT_ACCOUNT>
            {
                for $CURRENCY in $transferenciaCuentasRequest1/CURRENCY
                return
                    <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
            }
            <ns1:TRANSFER_AMOUNT>{ data($transferenciaCuentasRequest1/TRANSFER_AMOUNT) }</ns1:TRANSFER_AMOUNT>
            {
                for $DEBIT_CREDIT in $transferenciaCuentasRequest1/DEBIT_CREDIT
                return
                    <ns1:DEBIT_CREDIT>{ data($DEBIT_CREDIT) }</ns1:DEBIT_CREDIT>
            }
            {
                for $DESCRIPTION in $transferenciaCuentasRequest1/DESCRIPTION
                return
                    <ns1:DESCRIPTION>{ data($DESCRIPTION) }</ns1:DESCRIPTION>
            }
            {
           		if (string($transferenciaCuentasRequest1/REGIONAL_DETAILS)) then
	            (
	            	if (string($transferenciaCuentasRequest1/TRANSFER_DETAILS)) then 
	            	<TRANSFER_DETAILS>{ fn:concat("#INTGRP#", data($transferenciaCuentasRequest1/TRANSFER_DETAILS)) }</TRANSFER_DETAILS>
	            	else
	            	<TRANSFER_DETAILS>#INTGRP#</TRANSFER_DETAILS>
	            )
	            else
	            ()
            }
            {
                for $INTERFACE_REFERENCE_NO in $transferenciaCuentasRequest1/INTERFACE_REFERENCE_NO
                return
                    <ns1:INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            }
            {
                for $ITEM_LEVEL_1 in $transferenciaCuentasRequest1/ITEM_LEVEL_1
                return
                    <ns1:FINANCIAL_SECTOR_CATEGORY>{ data($ITEM_LEVEL_1) }</ns1:FINANCIAL_SECTOR_CATEGORY>
            }
            {
                for $ITEM_LEVEL_2 in $transferenciaCuentasRequest1/ITEM_LEVEL_2
                return
                    <ns1:FINANCIAL_SECTOR_SUBCATEGORY>{ data($ITEM_LEVEL_2) }</ns1:FINANCIAL_SECTOR_SUBCATEGORY>
            }
        </ns1:InputParameters>
};

declare variable $transferenciaCuentasRequest1 as element(ns0:transferenciaCuentasRequest) external;

xf:transferenciaCuentasIn($transferenciaCuentasRequest1)