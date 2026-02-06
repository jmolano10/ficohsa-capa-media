xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaTransaccionBancaria1" element="ns1:creaTransaccionBancaria" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciasACHDebitos" location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionACHDebitosIn/";

declare function xf:creaTransaccionACHDebitosIn($creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria))
    as element(ns0:transferenciasACHDebitos) {
        <ns0:transferenciasACHDebitos>
            <GLOBAL_REFERENCE>{ data($creaTransaccionBancaria1/GLOBAL_REFERENCE) }</GLOBAL_REFERENCE>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <CONTRACT_ID>{ data($creaTransaccionBancaria1/CONTRACT_ID) }</CONTRACT_ID>
                    <TRANSACTION_TYPE>{ data($creaTransaccionBancaria1/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <CURRENCY>{ data($creaTransaccionBancaria1/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($creaTransaccionBancaria1/TRANSFER_AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($creaTransaccionBancaria1/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>
                        <BANK_ID>{ data($creaTransaccionBancaria1/BANK_ID) }</BANK_ID>
                        <ACCOUNT>{ data($creaTransaccionBancaria1/DEBIT_ACCOUNT) }</ACCOUNT>
                        <REFERENCE_NUMBER>{ data($creaTransaccionBancaria1/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                    </ORIGINATOR_INFO>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns0:transferenciasACHDebitos>
};

declare variable $creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria) external;

xf:creaTransaccionACHDebitosIn($creaTransaccionBancaria1)