xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHDebitos" element="ns1:transferenciasACHDebitos" location="../xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciasACHDebitosResponse" location="../xsd/transferenciasACHDebitosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHDebitos/xq/transfACHDebitoOut/";

declare function xf:transfACHDebitoOut($transferenciasACHDebitos as element(ns1:transferenciasACHDebitos),
    $responseHeader as element(ns0:ResponseHeader))
    as element(ns1:transferenciasACHDebitosResponse) {
        <ns1:transferenciasACHDebitosResponse>
            <VALUE_DATE>{ data($responseHeader/valueDate) }</VALUE_DATE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <CONTRACT_ID>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CONTRACT_ID) }</CONTRACT_ID>
                    <TRANSACTION_TYPE>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/BANK_ID) }</BANK_ID>
                        {
                            for $ACCOUNT in $transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT
                            return
                                <ACCOUNT>{ data($ACCOUNT) }</ACCOUNT>
                        }
                        {
                            for $REFERENCE_NUMBER in $transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/REFERENCE_NUMBER
                            return
                                <REFERENCE_NUMBER>{ data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        }
                        {
                            for $CUSTOMER_NAME in $transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/CUSTOMER_NAME
                            return
                                <CUSTOMER_NAME>{ data($CUSTOMER_NAME) }</CUSTOMER_NAME>
                        }
                        {
                            for $DESCRIPTION in $transferenciasACHDebitos/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/DESCRIPTION
                            return
                                <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                        }
                    </ORIGINATOR_INFO>
                    <TRANSACTION_RESULT>
                        {
                            for $successIndicator in $responseHeader/successIndicator
                            return
                                <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>
                        }
                        {
                            for $transactionId in $responseHeader/transactionId
                            return
                                <TRANSACTION_ID>{ data($transactionId) }</TRANSACTION_ID>
                        }
                        {
                            for $successIndicator in $responseHeader/successIndicator
                            return
                                <ERROR_CODE>{ data($successIndicator) }</ERROR_CODE>
                        }
                        <ERROR_MESSAGE>{ fn:string-join($responseHeader/messages, ". ") }</ERROR_MESSAGE>
                    </TRANSACTION_RESULT>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns1:transferenciasACHDebitosResponse>
};

declare variable $transferenciasACHDebitos as element(ns1:transferenciasACHDebitos) external;
declare variable $responseHeader as element(ns0:ResponseHeader) external;

xf:transfACHDebitoOut($transferenciasACHDebitos,
    $responseHeader)