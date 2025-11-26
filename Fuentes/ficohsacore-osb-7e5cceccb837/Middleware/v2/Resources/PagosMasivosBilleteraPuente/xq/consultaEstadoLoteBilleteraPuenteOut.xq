(:: pragma bea:global-element-parameter parameter="$consultaEstadoLoteBilleteraResponse" element="ns1:consultaEstadoLoteBilleteraResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoLoteBilleteraResponse" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaEstadoLoteBilleteraPuenteOut/";

declare function xf:consultaEstadoLoteBilleteraPuenteOut($consultaEstadoLoteBilleteraResponse as element(ns1:consultaEstadoLoteBilleteraResponse))
    as element(ns0:consultaEstadoLoteBilleteraResponse) {
        <ns0:consultaEstadoLoteBilleteraResponse>
            <BATCH_DATE>{ data($consultaEstadoLoteBilleteraResponse/BATCH_DATE) }</BATCH_DATE>
            <DEBIT_WALLET>{ data($consultaEstadoLoteBilleteraResponse/DEBIT_WALLET) }</DEBIT_WALLET>
            <DEBIT_WALLET_NAME>{ data($consultaEstadoLoteBilleteraResponse/DEBIT_WALLET_NAME) }</DEBIT_WALLET_NAME>
            <STATUS>{ data($consultaEstadoLoteBilleteraResponse/STATUS) }</STATUS>
            <STATUS_DESCRIPTION>{ data($consultaEstadoLoteBilleteraResponse/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
            <TOTAL_AMOUNT>{ data($consultaEstadoLoteBilleteraResponse/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($consultaEstadoLoteBilleteraResponse/TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
            <NUMBER_OF_TRANSACTIONS>{ data($consultaEstadoLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($consultaEstadoLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS_SUCCESS) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($consultaEstadoLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS_ERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
        </ns0:consultaEstadoLoteBilleteraResponse>
};

declare variable $consultaEstadoLoteBilleteraResponse as element(ns1:consultaEstadoLoteBilleteraResponse) external;

xf:consultaEstadoLoteBilleteraPuenteOut($consultaEstadoLoteBilleteraResponse)
