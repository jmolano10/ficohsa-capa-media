xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalRequest1" element="ns1:transferenciaInternacionalRequest" location="../xsd/transferenciaInternacionalType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaInternacional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/transferenciaInternacional/xq/transferenciaInternacionalIn/";

declare function xf:transferenciaInternacionalIn($transferenciaInternacionalRequest1 as element(ns1:transferenciaInternacionalRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEBIT_ACCOUNT>{ data($transferenciaInternacionalRequest1/DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
            <ns0:DEBIT_CURRENCY>{ data($transferenciaInternacionalRequest1/DEBIT_CURRENCY) }</ns0:DEBIT_CURRENCY>
            <ns0:TRANSFER_AMOUNT>{ data($transferenciaInternacionalRequest1/TRANSFER_AMOUNT) }</ns0:TRANSFER_AMOUNT>
            <ns0:DESTINATION_COUNTRY>{ data($transferenciaInternacionalRequest1/DESTINATION_COUNTRY) }</ns0:DESTINATION_COUNTRY>
            {
                for $DESTINATION_CURRENCY in $transferenciaInternacionalRequest1/DESTINATION_CURRENCY
                return
                    <ns0:DESTINATION_CURRENCY>{ data($DESTINATION_CURRENCY) }</ns0:DESTINATION_CURRENCY>
            }
            <ns0:INTERMEDIARY_BANK_CODE>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_CODE) }</ns0:INTERMEDIARY_BANK_CODE>
            <ns0:INTERMEDIARY_BANK_CODE_TYPE>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_CODE_TYPE) }</ns0:INTERMEDIARY_BANK_CODE_TYPE>
            <ns0:INTERMEDIARY_BANK_INSTRUCTIONS>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_INSTRUCTIONS) }</ns0:INTERMEDIARY_BANK_INSTRUCTIONS>
            <ns0:BENEF_BANK_CODE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CODE) }</ns0:BENEF_BANK_CODE>
            <ns0:BENEF_BANK_CODE_TYPE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CODE_TYPE) }</ns0:BENEF_BANK_CODE_TYPE>
            <ns0:BENEF_BANK_INT_ACCOUNT>{ data($transferenciaInternacionalRequest1/BENEF_BANK_INT_ACCOUNT) }</ns0:BENEF_BANK_INT_ACCOUNT>
            <ns0:BENEF_BANK_NAME>{ data($transferenciaInternacionalRequest1/BENEF_BANK_NAME) }</ns0:BENEF_BANK_NAME>
            <ns0:BENEF_BANK_ADDRESS>{ data($transferenciaInternacionalRequest1/BENEF_BANK_ADDRESS) }</ns0:BENEF_BANK_ADDRESS>
            <ns0:BENEF_BANK_CITY>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CITY) }</ns0:BENEF_BANK_CITY>
            <ns0:BENEF_BANK_STATE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_STATE) }</ns0:BENEF_BANK_STATE>
            <ns0:BENEF_BANK_POSTAL_CODE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_POSTAL_CODE) }</ns0:BENEF_BANK_POSTAL_CODE>
            <ns0:BENEF_BANK_COUNTRY>{ data($transferenciaInternacionalRequest1/BENEF_BANK_COUNTRY) }</ns0:BENEF_BANK_COUNTRY>
            <ns0:BENEFICIARY_NAME>{ data($transferenciaInternacionalRequest1/BENEFICIARY_NAME) }</ns0:BENEFICIARY_NAME>
            <ns0:BENEFICIARY_ACCOUNT>{ data($transferenciaInternacionalRequest1/BENEFICIARY_ACCOUNT) }</ns0:BENEFICIARY_ACCOUNT>
            <ns0:BENEFICIARY_ADDRESS>{ data($transferenciaInternacionalRequest1/BENEFICIARY_ADDRESS) }</ns0:BENEFICIARY_ADDRESS>
            <ns0:BENEFICIARY_CITY>{ data($transferenciaInternacionalRequest1/BENEFICIARY_CITY) }</ns0:BENEFICIARY_CITY>
            <ns0:BENEFICIARY_STATE>{ data($transferenciaInternacionalRequest1/BENEFICIARY_STATE) }</ns0:BENEFICIARY_STATE>
            <ns0:BENEFICIARY_POSTAL_CODE>{ data($transferenciaInternacionalRequest1/BENEFICIARY_POSTAL_CODE) }</ns0:BENEFICIARY_POSTAL_CODE>
            <ns0:BENEFICIARY_INFO>{ data($transferenciaInternacionalRequest1/BENEFICIARY_INFO) }</ns0:BENEFICIARY_INFO>
            <ns0:BENEFICIARY_COUNTRY>{ data($transferenciaInternacionalRequest1/BENEFICIARY_COUNTRY) }</ns0:BENEFICIARY_COUNTRY>
            <ns0:INTERFACE_REFERENCE_NO>{ data($transferenciaInternacionalRequest1/INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            <ns0:DESCRIPTION>{ data($transferenciaInternacionalRequest1/DESCRIPTION) }</ns0:DESCRIPTION>
            <ns0:CHANNEL>{ data($transferenciaInternacionalRequest1/CHANNEL) }</ns0:CHANNEL>
        </ns0:InputParameters>
};

declare variable $transferenciaInternacionalRequest1 as element(ns1:transferenciaInternacionalRequest) external;

xf:transferenciaInternacionalIn($transferenciaInternacionalRequest1)