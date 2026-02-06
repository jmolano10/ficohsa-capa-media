xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/transferenciasACH/xsd/transferenciasACH_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciasACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/transferenciasACH/xq/transferenciasACHIn/";

declare function xf:transferenciasACHIn($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:DEBIT_ACCOUNT>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:DESTINATION_BANK>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</ns1:DESTINATION_BANK>
            <ns1:ACCOUNT_TYPE>{ data($transferenciasACHRequest1/ACCOUNT_TYPE) }</ns1:ACCOUNT_TYPE>
            <ns1:CREDIT_ACCOUNT>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ns1:CREDIT_ACCOUNT>
            <ns1:BENEFICIARY_NAME>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ns1:BENEFICIARY_NAME>
            <ns1:TRANSFER_AMOUNT>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</ns1:TRANSFER_AMOUNT>
            <ns1:TRANSACTION_DESCRIPTION>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</ns1:TRANSACTION_DESCRIPTION>
            <ns1:INTERFACE_REFERENCE_NO>{ data($transferenciasACHRequest1/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;

xf:transferenciasACHIn($transferenciasACHRequest1)