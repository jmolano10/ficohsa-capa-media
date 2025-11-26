(:: pragma bea:global-element-parameter parameter="$transaccionesACHRecibidas1" element="ns0:transaccionesACHRecibidas" location="../xsd/transaccionesACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciasACHDebitos" location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transaccionesACHRecibidasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesACHRecibidas/xq/transferenciasACHDebitosIn/";

declare function xf:transferenciasACHDebitosIn($transaccionesACHRecibidas1 as element(ns0:transaccionesACHRecibidas))
    as element(ns1:transferenciasACHDebitos) {
        <ns1:transferenciasACHDebitos>
            <GLOBAL_REFERENCE>{ data($transaccionesACHRecibidas1/GLOBAL_REFERENCE) }</GLOBAL_REFERENCE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <CONTRACT_ID>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CONTRACT_ID) }</CONTRACT_ID>
                    <TRANSACTION_TYPE>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/BANK_ID) }</BANK_ID>
                        <ACCOUNT>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT) }</ACCOUNT>
                        <REFERENCE_NUMBER>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        <CUSTOMER_NAME>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/CUSTOMER_NAME) }</CUSTOMER_NAME>
                        <DESCRIPTION>{ data($transaccionesACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/DESCRIPTION) }</DESCRIPTION>
                    </ORIGINATOR_INFO>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns1:transferenciasACHDebitos>
};

declare variable $transaccionesACHRecibidas1 as element(ns0:transaccionesACHRecibidas) external;

xf:transferenciasACHDebitosIn($transaccionesACHRecibidas1)