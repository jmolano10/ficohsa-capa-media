(:: pragma bea:global-element-parameter parameter="$transferenciasACHDebitosResponse1" element="ns1:transferenciasACHDebitosResponse" location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transaccionesACHRecibidasResponse" location="../xsd/transaccionesACHRecibidasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transaccionesACHRecibidasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesACHRecibidas/xq/transferenciasACHDebitosOut/";

declare function xf:transferenciasACHDebitosOut($transferenciasACHDebitosResponse1 as element(ns1:transferenciasACHDebitosResponse))
    as element(ns0:transaccionesACHRecibidasResponse) {
        <ns0:transaccionesACHRecibidasResponse>
            <VALUE_DATE>{ data($transferenciasACHDebitosResponse1/VALUE_DATE) }</VALUE_DATE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <CONTRACT_ID>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CONTRACT_ID) }</CONTRACT_ID>
                    <TRANSACTION_TYPE>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/BANK_ID) }</BANK_ID>
                        <ACCOUNT>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT) }</ACCOUNT>
                        <REFERENCE_NUMBER>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        <CUSTOMER_NAME>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/CUSTOMER_NAME) }</CUSTOMER_NAME>
                        <DESCRIPTION>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/DESCRIPTION) }</DESCRIPTION>
                    </ORIGINATOR_INFO>
                    <TRANSACTION_RESULT>
                        <SUCCESS_INDICATOR>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                        <TRANSACTION_ID>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/TRANSACTION_ID) }</TRANSACTION_ID>
                        <ERROR_CODE>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_CODE) }</ERROR_CODE>
                        <ERROR_MESSAGE>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_MESSAGE) }</ERROR_MESSAGE>
                    </TRANSACTION_RESULT>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns0:transaccionesACHRecibidasResponse>
};

declare variable $transferenciasACHDebitosResponse1 as element(ns1:transferenciasACHDebitosResponse) external;

xf:transferenciasACHDebitosOut($transferenciasACHDebitosResponse1)