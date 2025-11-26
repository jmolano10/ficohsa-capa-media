(:: pragma bea:global-element-parameter parameter="$sjTransferenciaEntreCuentasResponseIN" element="ns0:sjTransferenciaEntreCuentasResponse" location="../../../BusinessServices/SJS/TransferenciasEntreCuentaH2H/xsd/sjTransferenciaEntreCuentasH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaEntreCuentaH2HResponse" location="../xsd/transferenciaCuentasH2HType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaEntreCuentaH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TranferenciasEntreCuentasH2H/xq/TransferenciaEntreCuentaH2HOUT/";

declare function xf:TransferenciaEntreCuentaH2HOUT($sjTransferenciaEntreCuentasResponseIN as element(ns0:sjTransferenciaEntreCuentasResponse))
    as element(ns1:transferenciaEntreCuentaH2HResponse) {
        <ns1:transferenciaEntreCuentaH2HResponse>
           <TRANSFERS_INT>
           {
                    for $transfer in $sjTransferenciaEntreCuentasResponseIN/TRANSFERS_INT/TRANSFER_INT
                    return
                        <TRANSFER_INT>
                            <SUCCESS_INDICATOR>{ data($transfer/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                            {
                             if (data($transfer/SUCCESS_INDICATOR)!='SUCCESS') then (
                            <ERROR_MESSAGE>{ data($transfer/ERROR_MESSAGE) }</ERROR_MESSAGE>
                            )
                            else()
                            }
                            <TRACE>{ data($transfer/TRACE) }</TRACE>
                            <TRANSACTION_ID>{ data($transfer/TRANSACTION_ID) }</TRANSACTION_ID>
                            <DEBIT_ACCOUNT>{ data($transfer/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                            <CREDIT_ACCOUNT>{ data($transfer/CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
                            <DEBIT_CUSTOMER>{ data($transfer/DEBIT_CUSTOMER) }</DEBIT_CUSTOMER>
                            <CREDIT_CUSTOMER>{ data($transfer/CREDIT_CUSTOMER) }</CREDIT_CUSTOMER>
                            <DEBIT_CURRENCY>{ data($transfer/DEBIT_CURRENCY) }</DEBIT_CURRENCY>
                            <CREDIT_CURRENCY>{ data($transfer/CREDIT_CURRENCY) }</CREDIT_CURRENCY>
                            <DEBIT_AMOUNT>{ data($transfer/DEBIT_AMOUNT) }</DEBIT_AMOUNT>
                            <CREDIT_AMOUNT>{ data($transfer/CREDIT_AMOUNT) }</CREDIT_AMOUNT>
                            <EXCHANGE_RATE>{ data($transfer/EXCHANGE_RATE) }</EXCHANGE_RATE>
                        </TRANSFER_INT>
                }
             </TRANSFERS_INT>
        </ns1:transferenciaEntreCuentaH2HResponse>
};

declare variable $sjTransferenciaEntreCuentasResponseIN as element(ns0:sjTransferenciaEntreCuentasResponse) external;

xf:TransferenciaEntreCuentaH2HOUT($sjTransferenciaEntreCuentasResponseIN)
