(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciasACHRecibidasResponse" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/transferenciaACHRecibidasOut/";

declare function xf:transferenciaACHRecibidasOut($transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas),
    $valueDate as xs:string,
    $transactionId as xs:string,
    $errorCode as xs:string,
    $errorMessage as xs:string,
    $beneficiaryId as xs:string)
    as element(ns0:transferenciasACHRecibidasResponse) {
        <ns0:transferenciasACHRecibidasResponse>
            <VALUE_DATE>{ $valueDate }</VALUE_DATE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <TRANSACTION_TYPE>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/BANK_ID) }</BANK_ID>
                        {
                            for $ACCOUNT in $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT
                            return
                                <ACCOUNT>{ data($ACCOUNT) }</ACCOUNT>
                        }
                        {
                            for $REFERENCE_NUMBER in $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/REFERENCE_NUMBER
                            return
                                <REFERENCE_NUMBER>{ data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        }
                        {
                            for $CUSTOMER_NAME in $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/CUSTOMER_NAME
                            return
                                <CUSTOMER_NAME>{ data($CUSTOMER_NAME) }</CUSTOMER_NAME>
                        }
                        {
                            for $DESCRIPTION in $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/DESCRIPTION
                            return
                                <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                        }
                    </ORIGINATOR_INFO>
                    <TRANSACTION_RESULT>
                        <SUCCESS_INDICATOR>{ $errorCode }</SUCCESS_INDICATOR>
                        <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
                        <ERROR_CODE>{ $errorCode }</ERROR_CODE>
                        <ERROR_MESSAGE>{ fn:string-join($errorMessage,";") }</ERROR_MESSAGE>
                    </TRANSACTION_RESULT>
                    <BENEFICIARY_ID>{ $beneficiaryId }</BENEFICIARY_ID>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns0:transferenciasACHRecibidasResponse>
};

declare variable $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas) external;
declare variable $valueDate as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $errorMessage as xs:string external;
declare variable $beneficiaryId as xs:string external;

xf:transferenciaACHRecibidasOut($transferenciasACHRecibidas,
    $valueDate,
    $transactionId,
    $errorCode,
    $errorMessage,
    $beneficiaryId)
