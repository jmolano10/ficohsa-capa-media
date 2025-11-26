(:: pragma bea:global-element-parameter parameter="$cargaLoteBilleteraResponse" element="ns1:cargaLoteBilleteraResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cargaLoteBilleteraResponse" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/cargaLoteBilleteraPuenteOut/";

declare function xf:cargaLoteBilleteraPuenteOut($cargaLoteBilleteraResponse as element(ns1:cargaLoteBilleteraResponse))
    as element(ns0:cargaLoteBilleteraResponse) {
        <ns0:cargaLoteBilleteraResponse>
            <USERNAME>{ data($cargaLoteBilleteraResponse/USERNAME) }</USERNAME>
            <DEBIT_WALLET>{ data($cargaLoteBilleteraResponse/DEBIT_WALLET) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($cargaLoteBilleteraResponse/BANK_BATCH_ID) }</BANK_BATCH_ID>
            <STATUS>{ data($cargaLoteBilleteraResponse/STATUS) }</STATUS>
            <STATUS_DESCRIPTION>{ data($cargaLoteBilleteraResponse/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
            <NUMBER_OF_TRANSACTIONS>{ data($cargaLoteBilleteraResponse/NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
            <TOTAL_AMOUNT>{ data($cargaLoteBilleteraResponse/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            {
                let $WALLET_DETAILS := $cargaLoteBilleteraResponse/WALLET_DETAILS
                return
                    <WALLET_DETAILS>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <WALLET>
                                    <RECORD>{ data($WALLET/RECORD) }</RECORD>
                                    <REFERENCE_NUMBER>{ data($WALLET/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                                    <DESCRIPTION>{ data($WALLET/DESCRIPTION) }</DESCRIPTION>
                                    <ID>{ data($WALLET/ID) }</ID>
                                    <LEGAL_ID>{ data($WALLET/LEGAL_ID) }</LEGAL_ID>
                                    <NAME>{ data($WALLET/NAME) }</NAME>
                                    <STATUS>{ data($WALLET/STATUS) }</STATUS>
                                    <STATUS_DESCRIPTION>{ data($WALLET/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
                                    {
                                        for $ERROR_CODE in $WALLET/ERROR_CODE
                                        return
                                            <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
                                    }
                                    {
                                        for $ERROR_DESCRIPTION in $WALLET/ERROR_DESCRIPTION
                                        return
                                            <ERROR_DESCRIPTION>{ data($ERROR_DESCRIPTION) }</ERROR_DESCRIPTION>
                                    }
                                    <AMOUNT>{ data($WALLET/AMOUNT) }</AMOUNT>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns0:cargaLoteBilleteraResponse>
};

declare variable $cargaLoteBilleteraResponse as element(ns1:cargaLoteBilleteraResponse) external;

xf:cargaLoteBilleteraPuenteOut($cargaLoteBilleteraResponse)
