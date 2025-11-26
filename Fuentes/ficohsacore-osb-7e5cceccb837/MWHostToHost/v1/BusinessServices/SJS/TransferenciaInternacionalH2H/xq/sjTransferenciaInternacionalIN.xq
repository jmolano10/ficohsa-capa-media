xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$sjTransferenciaInternacionalRequest" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaInternacionalRequest" location="../../../../../../Middleware/v2/Resources/TransferenciaInternacional/xsd/transferenciaInternacionalType.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciaInternacionalH2H/xq/sjTransferenciaInternacional/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";

declare function xf:sjTransferenciaInternacional($sjTransferenciaInternacionalRequest as element(*),
    $transferIndex as xs:integer)
    as element(ns0:transferenciaInternacionalRequest) {
        <ns0:transferenciaInternacionalRequest>
            <DEBIT_ACCOUNT>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            <DEBIT_CURRENCY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_CURRENCY) }</DEBIT_CURRENCY>
            <TRANSFER_AMOUNT>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
            <DESTINATION_COUNTRY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESTINATION_COUNTRY) }</DESTINATION_COUNTRY>
            {
                for $DESTINATION_CURRENCY in $sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESTINATION_CURRENCY
                return
                    <DESTINATION_CURRENCY>{ data($DESTINATION_CURRENCY) }</DESTINATION_CURRENCY>
            }
            <INTERMEDIARY_BANK_CODE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_CODE) }</INTERMEDIARY_BANK_CODE>
            <INTERMEDIARY_BANK_CODE_TYPE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_CODE_TYPE) }</INTERMEDIARY_BANK_CODE_TYPE>
            <INTERMEDIARY_BANK_INSTRUCTIONS>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_INSTRUCTIONS) }</INTERMEDIARY_BANK_INSTRUCTIONS>
            {
                for $INTERMEDIARY_BANK_NAME in $sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_NAME
                return
                    <INTERMEDIARY_BANK_NAME>{ data($INTERMEDIARY_BANK_NAME) }</INTERMEDIARY_BANK_NAME>
            }
            {
                for $INTERMEDIARY_BANK_ADDRESS in $sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_ADDRESS
                return
                    <INTERMEDIARY_BANK_ADDRESS>{ data($INTERMEDIARY_BANK_ADDRESS) }</INTERMEDIARY_BANK_ADDRESS>
            }
            <BENEF_BANK_CODE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CODE) }</BENEF_BANK_CODE>
            <BENEF_BANK_CODE_TYPE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CODE_TYPE) }</BENEF_BANK_CODE_TYPE>
            <BENEF_BANK_INT_ACCOUNT>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_INT_ACCOUNT) }</BENEF_BANK_INT_ACCOUNT>
            <BENEF_BANK_NAME>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_NAME) }</BENEF_BANK_NAME>
            <BENEF_BANK_ADDRESS>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_ADDRESS) }</BENEF_BANK_ADDRESS>
            <BENEF_BANK_CITY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CITY) }</BENEF_BANK_CITY>
            <BENEF_BANK_STATE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_STATE) }</BENEF_BANK_STATE>
            <BENEF_BANK_POSTAL_CODE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_POSTAL_CODE) }</BENEF_BANK_POSTAL_CODE>
            <BENEF_BANK_COUNTRY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_COUNTRY) }</BENEF_BANK_COUNTRY>
            <BENEFICIARY_NAME>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
            <BENEFICIARY_ACCOUNT>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_ACCOUNT) }</BENEFICIARY_ACCOUNT>
            <BENEFICIARY_ADDRESS>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_ADDRESS) }</BENEFICIARY_ADDRESS>
            <BENEFICIARY_CITY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_CITY) }</BENEFICIARY_CITY>
            <BENEFICIARY_STATE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_STATE) }</BENEFICIARY_STATE>
            <BENEFICIARY_POSTAL_CODE>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_POSTAL_CODE) }</BENEFICIARY_POSTAL_CODE>
            <BENEFICIARY_COUNTRY>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_COUNTRY) }</BENEFICIARY_COUNTRY>
            <BENEFICIARY_INFO>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_INFO) }</BENEFICIARY_INFO>
            <INTERFACE_REFERENCE_NO>{ data($sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
            {
                for $DESCRIPTION in $sjTransferenciaInternacionalRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESCRIPTION
                return
                    <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
            }
        </ns0:transferenciaInternacionalRequest>
};

declare variable $sjTransferenciaInternacionalRequest as element(*) external;
declare variable $transferIndex as xs:integer external;

xf:sjTransferenciaInternacional($sjTransferenciaInternacionalRequest,
    $transferIndex)