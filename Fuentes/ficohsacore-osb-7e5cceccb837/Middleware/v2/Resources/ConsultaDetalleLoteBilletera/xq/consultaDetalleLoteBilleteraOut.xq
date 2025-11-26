(:: pragma bea:global-element-parameter parameter="$historicoPagoIdResponse" element="ns1:HistoricoPagoIdResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleLoteBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLoteBilletera/xq/consultaDetalleLoteBilleteraOut/";

declare function xf:consultaDetalleLoteBilleteraOut($historicoPagoIdResponse as element(ns1:HistoricoPagoIdResponse))
    as element(ns0:consultaDetalleLoteBilleteraResponse) {
        <ns0:consultaDetalleLoteBilleteraResponse>
            <DEBIT_WALLET>{ data($historicoPagoIdResponse/return/debBilletera) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($historicoPagoIdResponse/return/correlativo) }</BANK_BATCH_ID>
            <DEBIT_WALLET_NAME>{ data($historicoPagoIdResponse/return/nombreTitular) }</DEBIT_WALLET_NAME>
            <DATE>{ data($historicoPagoIdResponse/return/fecha) }</DATE>
            <NUMBER_OF_TRANSACTIONS>{ data($historicoPagoIdResponse/return/numTrx) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($historicoPagoIdResponse/return/numTrxSuccess) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($historicoPagoIdResponse/return/numTrxError) }</NUMBER_OF_TRANSACTIONS_ERROR>
            <TOTAL_AMOUNT>{ data($historicoPagoIdResponse/return/montoTotal) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($historicoPagoIdResponse/return/montoTotalError) }</TOTAL_AMOUNT_ERROR>
            <STATUS>{ xs:int(data($historicoPagoIdResponse/return/codEstado)) }</STATUS>
            <STATUS_DESCRIPTION>{ data($historicoPagoIdResponse/return/desEstado) }</STATUS_DESCRIPTION>
            {
                let $billeteras := $historicoPagoIdResponse/return/billeteras
                return
                    <WALLET_DETAILS>
                        {
                            for $listaHistoricoId in $billeteras/listaHistoricoId
                            return
                                <WALLET>
                                    <RECORD>{ data($listaHistoricoId/linea) }</RECORD>
                                    <ID>{ data($listaHistoricoId/credBilletera) }</ID>
                                    <DESCRIPTION>{ data($listaHistoricoId/descripcion) }</DESCRIPTION>
                                    <AMOUNT>{ data($listaHistoricoId/monto) }</AMOUNT>
                                    <NAME>{ data($listaHistoricoId/nombreTitular) }</NAME>
                                    <PRODUCT_TYPE>{ data($listaHistoricoId/tipo) }</PRODUCT_TYPE>
                                    <STATUS>{ xs:int(data($historicoPagoIdResponse/return/billeteras/listaHistoricoId[1]/codEstado)) }</STATUS>
                                    <STATUS_DESCRIPTION>{ data($listaHistoricoId/desEstado) }</STATUS_DESCRIPTION>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns0:consultaDetalleLoteBilleteraResponse>
};

declare variable $historicoPagoIdResponse as element(ns1:HistoricoPagoIdResponse) external;

xf:consultaDetalleLoteBilleteraOut($historicoPagoIdResponse)
