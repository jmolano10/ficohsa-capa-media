(:: pragma bea:global-element-parameter parameter="$consultaDetalleLoteBilleteraResponse" element="ns1:consultaDetalleLoteBilleteraResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleLoteBilleteraResponse" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaDetalleLoteBilleteraPuenteOut/";

declare function xf:consultaDetalleLoteBilleteraPuenteOut($consultaDetalleLoteBilleteraResponse as element(ns1:consultaDetalleLoteBilleteraResponse))
    as element(ns0:consultaDetalleLoteBilleteraResponse) {
        <ns0:consultaDetalleLoteBilleteraResponse>
            <DEBIT_WALLET>{ data($consultaDetalleLoteBilleteraResponse/DEBIT_WALLET) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($consultaDetalleLoteBilleteraResponse/BANK_BATCH_ID) }</BANK_BATCH_ID>
            <DEBIT_WALLET_NAME>{ data($consultaDetalleLoteBilleteraResponse/DEBIT_WALLET_NAME) }</DEBIT_WALLET_NAME>
            <DATE>{ data($consultaDetalleLoteBilleteraResponse/DATE) }</DATE>
            <NUMBER_OF_TRANSACTIONS>{ data($consultaDetalleLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($consultaDetalleLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS_SUCCESS) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($consultaDetalleLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS_ERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
            <TOTAL_AMOUNT>{ data($consultaDetalleLoteBilleteraResponse/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($consultaDetalleLoteBilleteraResponse/TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
            <STATUS>{ data($consultaDetalleLoteBilleteraResponse/STATUS) }</STATUS>
            <STATUS_DESCRIPTION>{ data($consultaDetalleLoteBilleteraResponse/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
            {
                let $WALLET_DETAILS := $consultaDetalleLoteBilleteraResponse/WALLET_DETAILS
                return
                    <WALLET_DETAILS>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <WALLET>
                                    <RECORD>{ data($WALLET/RECORD) }</RECORD>
                                    <ID>{ data($WALLET/ID) }</ID>
                                    <DESCRIPTION>{ data($WALLET/DESCRIPTION) }</DESCRIPTION>
                                    <AMOUNT>{ data($WALLET/AMOUNT) }</AMOUNT>
                                    <NAME>{ data($WALLET/NAME) }</NAME>
                                    <PRODUCT_TYPE>{ data($WALLET/PRODUCT_TYPE) }</PRODUCT_TYPE>
                                    <STATUS>{ data($WALLET/STATUS) }</STATUS>
                                    <STATUS_DESCRIPTION>{ data($WALLET/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns0:consultaDetalleLoteBilleteraResponse>
};

declare variable $consultaDetalleLoteBilleteraResponse as element(ns1:consultaDetalleLoteBilleteraResponse) external;

xf:consultaDetalleLoteBilleteraPuenteOut($consultaDetalleLoteBilleteraResponse)
