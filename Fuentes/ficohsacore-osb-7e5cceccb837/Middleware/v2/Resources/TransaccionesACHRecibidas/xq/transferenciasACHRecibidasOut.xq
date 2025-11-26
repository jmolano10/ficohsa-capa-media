(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidasResponse1" element="ns0:transferenciasACHRecibidasResponse" location="../../TransferenciasACHRecibidas/xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transaccionesACHRecibidasResponse" location="../xsd/transaccionesACHRecibidasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionesACHRecibidasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesACHRecibidas/xq/transferenciasACHRecibidasOut/";

declare function xf:transferenciasACHRecibidasOut($transferenciasACHRecibidasResponse1 as element(ns0:transferenciasACHRecibidasResponse))
    as element(ns1:transaccionesACHRecibidasResponse) {
        <ns1:transaccionesACHRecibidasResponse>
            <VALUE_DATE>{ data($transferenciasACHRecibidasResponse1/VALUE_DATE) }</VALUE_DATE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <TRANSACTION_TYPE>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/BANK_ID) }</BANK_ID>
                        <ACCOUNT>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT) }</ACCOUNT>
                        <REFERENCE_NUMBER>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        <CUSTOMER_NAME>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/CUSTOMER_NAME) }</CUSTOMER_NAME>
                        <DESCRIPTION>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/DESCRIPTION) }</DESCRIPTION>
                    </ORIGINATOR_INFO>
                    <TRANSACTION_RESULT>
                        <SUCCESS_INDICATOR>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                        <TRANSACTION_ID>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/TRANSACTION_ID) }</TRANSACTION_ID>
                        <ERROR_CODE>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_CODE) }</ERROR_CODE>
                        <ERROR_MESSAGE>{ data($transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_MESSAGE) }</ERROR_MESSAGE>
                    </TRANSACTION_RESULT>
                    {
                        for $BENEFICIARY_ID in $transferenciasACHRecibidasResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_ID
                        return
                            <BENEFICIARY_ID>{ data($BENEFICIARY_ID) }</BENEFICIARY_ID>
                    }
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns1:transaccionesACHRecibidasResponse>
};

declare variable $transferenciasACHRecibidasResponse1 as element(ns0:transferenciasACHRecibidasResponse) external;

xf:transferenciasACHRecibidasOut($transferenciasACHRecibidasResponse1)
