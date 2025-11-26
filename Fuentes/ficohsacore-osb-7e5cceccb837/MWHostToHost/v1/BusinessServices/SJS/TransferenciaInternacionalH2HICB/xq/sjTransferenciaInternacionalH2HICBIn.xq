(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalICBRequest" element="ns0:sjTransferenciaInternacionalICBRequest" location="../xsd/sjTransferenciaInternacionalH2HICB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalH2HRequest" location="../../../../Resources/TransferenciaInternacionalH2HICB/xsd/transferenciaInternacionalH2HICBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HICBTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HICBType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciaInternacionalH2HICB/xq/sjTransferenciaInternacionalH2HICBIn/";

declare function xf:sjTransferenciaInternacionalH2HICBIn($sjTransferenciaInternacionalICBRequest as element(ns0:sjTransferenciaInternacionalICBRequest),
	$transferIndex as xs:integer)
    as element(ns1:transferenciaInternacionalH2HRequest) {
        <ns1:transferenciaInternacionalH2HRequest>
            <CUSTOMER_ID>{ data($sjTransferenciaInternacionalICBRequest/CUSTOMER_ID) }</CUSTOMER_ID>
            <TRANSFERS_INT>
                <TRANSFER_INT>
                    <TRACE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/TRACE) }</TRACE>
                    <DEBIT_ACCOUNT>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                    <DEBIT_CURRENCY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_CURRENCY) }</DEBIT_CURRENCY>
                    <TRANSFER_AMOUNT>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
                    <DESTINATION_COUNTRY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESTINATION_COUNTRY) }</DESTINATION_COUNTRY>
                    {
                        for $DESTINATION_CURRENCY in $sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESTINATION_CURRENCY
                        return
                            <DESTINATION_CURRENCY>{ data($DESTINATION_CURRENCY) }</DESTINATION_CURRENCY>
                    }                   
                    <INTERMEDIARY_BANK_CODE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_CODE) }</INTERMEDIARY_BANK_CODE>
                    <INTERMEDIARY_BANK_CODE_TYPE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_CODE_TYPE) }</INTERMEDIARY_BANK_CODE_TYPE>
                    <INTERMEDIARY_BANK_INSTRUCTIONS>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_INSTRUCTIONS) }</INTERMEDIARY_BANK_INSTRUCTIONS>
                    {
                        for $INTERMEDIARY_BANK_NAME in $sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_NAME
                        return
                            <INTERMEDIARY_BANK_NAME>{ data($INTERMEDIARY_BANK_NAME) }</INTERMEDIARY_BANK_NAME>
                    }
                    {
                        for $INTERMEDIARY_BANK_ADDRESS in $sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERMEDIARY_BANK_ADDRESS
                        return
                            <INTERMEDIARY_BANK_ADDRESS>{ data($INTERMEDIARY_BANK_ADDRESS) }</INTERMEDIARY_BANK_ADDRESS>
                    }
                    <BENEF_BANK_CODE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CODE) }</BENEF_BANK_CODE>
                    <BENEF_BANK_CODE_TYPE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CODE_TYPE) }</BENEF_BANK_CODE_TYPE>
                    <BENEF_BANK_INT_ACCOUNT>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_INT_ACCOUNT) }</BENEF_BANK_INT_ACCOUNT>
                    <BENEF_BANK_NAME>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_NAME) }</BENEF_BANK_NAME>
                    <BENEF_BANK_ADDRESS>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_ADDRESS) }</BENEF_BANK_ADDRESS>
                    <BENEF_BANK_CITY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_CITY) }</BENEF_BANK_CITY>
                    <BENEF_BANK_STATE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_STATE) }</BENEF_BANK_STATE>
                    <BENEF_BANK_POSTAL_CODE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_POSTAL_CODE) }</BENEF_BANK_POSTAL_CODE>
                    <BENEF_BANK_COUNTRY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEF_BANK_COUNTRY) }</BENEF_BANK_COUNTRY>
                    <BENEFICIARY_NAME>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <BENEFICIARY_ACCOUNT>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_ACCOUNT) }</BENEFICIARY_ACCOUNT>
                    <BENEFICIARY_ADDRESS>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_ADDRESS) }</BENEFICIARY_ADDRESS>
                    <BENEFICIARY_CITY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_CITY) }</BENEFICIARY_CITY>
                    <BENEFICIARY_STATE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_STATE) }</BENEFICIARY_STATE>
                    <BENEFICIARY_POSTAL_CODE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_POSTAL_CODE) }</BENEFICIARY_POSTAL_CODE>
                    <BENEFICIARY_COUNTRY>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_COUNTRY) }</BENEFICIARY_COUNTRY>
                    <BENEFICIARY_INFO>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/BENEFICIARY_INFO) }</BENEFICIARY_INFO>
                    <INTERFACE_REFERENCE_NO>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
                    {
                        for $DESCRIPTION in $sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESCRIPTION
                        return
                            <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                    }
                    {
                        for $AUTHORIZATION in $sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/AUTHORIZATION
                        return
                            <AUTHORIZATION>{ data($AUTHORIZATION) }</AUTHORIZATION>
                    }
                    
                    <PROCESSDATE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/PROCESSDATE) }</PROCESSDATE>
                    <REFERENCECODE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/REFERENCECODE) }</REFERENCECODE>
                     <EXCHANGERATE>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/EXCHANGERATE) }</EXCHANGERATE>
                      <AMOUNT_DEBIT>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/AMOUNT_DEBIT) }</AMOUNT_DEBIT>
                </TRANSFER_INT>
            </TRANSFERS_INT>
        </ns1:transferenciaInternacionalH2HRequest>
};

declare variable $sjTransferenciaInternacionalICBRequest as element(ns0:sjTransferenciaInternacionalICBRequest) external;
declare variable $transferIndex as xs:integer external;

xf:sjTransferenciaInternacionalH2HICBIn($sjTransferenciaInternacionalICBRequest,
$transferIndex)