(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns1:transferenciaInternacionalH2HRequest" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjTransferenciaInternacionalICBRequest" location="../../../BusinessServices/SJS/TransferenciaInternacionalH2HICB/xsd/sjTransferenciaInternacionalH2HICB.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HICBTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/transferenciaInternacionalH2HICBIN/";

declare function xf:transferenciaInternacionalH2HICBIN($transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest),
    $USERNAME as xs:string,
    $PASSWORD as xs:string,
    $SOURCEBANK as xs:string,
    $AUTHORIZATION as xs:string,
    $REFERENCECODE as xs:string,
    $PROCESSDATE as xs:string,
    $EXCHANGERATE as xs:string,
    $AMOUNTDEBIT as xs:string,
    $CURRENCY as xs:string)
    as element(ns0:sjTransferenciaInternacionalICBRequest) {
        <ns0:sjTransferenciaInternacionalICBRequest>
            <CUSTOMER_ID>{ data($transferenciaInternacionalH2HRequest/CUSTOMER_ID) }</CUSTOMER_ID>
            <USER_NAME>{ $USERNAME }</USER_NAME>
            <PASSWORD>{ $PASSWORD }</PASSWORD>
            <SOURCE_BANK>{ $SOURCEBANK }</SOURCE_BANK>
            <TRANSFERS_INT>
                {
                    for $transferInt in $transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT
                    return
                        <TRANSFER_INT>
                            <TRACE>{ data($transferInt/TRACE) }</TRACE>
                            <DEBIT_ACCOUNT>{ data($transferInt/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                            <DEBIT_CURRENCY>{  $CURRENCY }</DEBIT_CURRENCY>
                            <TRANSFER_AMOUNT>{ data($transferInt/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
                            <DESTINATION_COUNTRY>{ data($transferInt/DESTINATION_COUNTRY) }</DESTINATION_COUNTRY>
                            <DESTINATION_CURRENCY>{ data($transferInt/DESTINATION_CURRENCY) }</DESTINATION_CURRENCY>
                            <INTERMEDIARY_BANK_CODE>{ data($transferInt/INTERMEDIARY_BANK_CODE) }</INTERMEDIARY_BANK_CODE>
                            <INTERMEDIARY_BANK_CODE_TYPE>{ data($transferInt/INTERMEDIARY_BANK_CODE_TYPE) }</INTERMEDIARY_BANK_CODE_TYPE>
                            <INTERMEDIARY_BANK_INSTRUCTIONS>{ data($transferInt/INTERMEDIARY_BANK_INSTRUCTIONS) }</INTERMEDIARY_BANK_INSTRUCTIONS>
                            <BENEF_BANK_CODE>{ data($transferInt/BENEF_BANK_CODE) }</BENEF_BANK_CODE>
                            <BENEF_BANK_CODE_TYPE>{ data($transferInt/BENEF_BANK_CODE_TYPE) }</BENEF_BANK_CODE_TYPE>
                            <BENEF_BANK_INT_ACCOUNT>{ data($transferInt/BENEF_BANK_INT_ACCOUNT) }</BENEF_BANK_INT_ACCOUNT>
                            <BENEF_BANK_NAME>{ data($transferInt/BENEF_BANK_NAME) }</BENEF_BANK_NAME>
                            <BENEF_BANK_ADDRESS>{ data($transferInt/BENEF_BANK_ADDRESS) }</BENEF_BANK_ADDRESS>
                            <BENEF_BANK_CITY>{ data($transferInt/BENEF_BANK_CITY) }</BENEF_BANK_CITY>
                            <BENEF_BANK_STATE>{ data($transferInt/BENEF_BANK_STATE) }</BENEF_BANK_STATE>
                            <BENEF_BANK_POSTAL_CODE>{ data($transferInt/BENEF_BANK_POSTAL_CODE) }</BENEF_BANK_POSTAL_CODE>
                            <BENEF_BANK_COUNTRY>{ data($transferInt/BENEF_BANK_COUNTRY) }</BENEF_BANK_COUNTRY>
                            <BENEFICIARY_NAME>{ data($transferInt/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                            <BENEFICIARY_ACCOUNT>{ data($transferInt/BENEFICIARY_ACCOUNT) }</BENEFICIARY_ACCOUNT>
                            <BENEFICIARY_ADDRESS>{ data($transferInt/BENEFICIARY_ADDRESS) }</BENEFICIARY_ADDRESS>
                            <BENEFICIARY_CITY>{ data($transferInt/BENEFICIARY_CITY) }</BENEFICIARY_CITY>
                            <BENEFICIARY_STATE>{ data($transferInt/BENEFICIARY_STATE) }</BENEFICIARY_STATE>
                            <BENEFICIARY_POSTAL_CODE>{ data($transferInt/BENEFICIARY_POSTAL_CODE) }</BENEFICIARY_POSTAL_CODE>
                            <BENEFICIARY_COUNTRY>{ data($transferInt/BENEFICIARY_COUNTRY) }</BENEFICIARY_COUNTRY>
                            <BENEFICIARY_INFO>{ data($transferInt/BENEFICIARY_INFO) }</BENEFICIARY_INFO>
                            <INTERFACE_REFERENCE_NO>{ data($transferInt/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
                            <DESCRIPTION>{ data($transferInt/DESCRIPTION) }</DESCRIPTION>
                            <AUTHORIZATION>{ $AUTHORIZATION }</AUTHORIZATION>
                            {
                            let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('yyyyMMdd', $PROCESSDATE))
            
                              return
                               <PROCESSDATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-dd",fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", string($date))) }</PROCESSDATE>
                              }
                            
                            <REFERENCECODE>{ $REFERENCECODE }</REFERENCECODE>
                            <AMOUNT_DEBIT>{ $AMOUNTDEBIT }</AMOUNT_DEBIT>
                            <EXCHANGERATE>{ $EXCHANGERATE }</EXCHANGERATE>
                        </TRANSFER_INT>
                }
            </TRANSFERS_INT>
        </ns0:sjTransferenciaInternacionalICBRequest>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest) external;
declare variable $USERNAME as xs:string external;
declare variable $PASSWORD as xs:string external;
declare variable $SOURCEBANK as xs:string external;
declare variable $AUTHORIZATION as xs:string external;
declare variable $REFERENCECODE as xs:string external;
declare variable $PROCESSDATE as xs:string external;
declare variable $EXCHANGERATE as xs:string external;
declare variable $AMOUNTDEBIT as xs:string external;
declare variable $CURRENCY as xs:string external;
xf:transferenciaInternacionalH2HICBIN($transferenciaInternacionalH2HRequest,
    $USERNAME,
    $PASSWORD,
    $SOURCEBANK,
    $AUTHORIZATION,
    $REFERENCECODE,
    $PROCESSDATE,
    $EXCHANGERATE,
    $AMOUNTDEBIT,
    $CURRENCY)