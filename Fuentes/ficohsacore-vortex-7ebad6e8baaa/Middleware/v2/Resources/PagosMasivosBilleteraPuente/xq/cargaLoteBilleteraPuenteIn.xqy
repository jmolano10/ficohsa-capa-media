xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cargaLoteBilletera" element="ns0:cargaLoteBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaLoteBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/cargaLoteBilleteraPuenteIn/";

declare function xf:cargaLoteBilleteraPuenteIn($cargaLoteBilletera as element(ns0:cargaLoteBilletera))
    as element(ns1:cargaLoteBilletera) {
        <ns1:cargaLoteBilletera>
            <USERNAME>{ data($cargaLoteBilletera/USERNAME) }</USERNAME>
            <PASSWORD>{ data($cargaLoteBilletera/PASSWORD) }</PASSWORD>
            <DEBIT_WALLET>{ data($cargaLoteBilletera/DEBIT_WALLET) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($cargaLoteBilletera/BANK_BATCH_ID) }</BANK_BATCH_ID>
            <BATCH_DESCRIPTION>{ data($cargaLoteBilletera/BATCH_DESCRIPTION) }</BATCH_DESCRIPTION>
            <MESSAGE>{ data($cargaLoteBilletera/MESSAGE) }</MESSAGE>
            {
                let $WALLET_DETAILS := $cargaLoteBilletera/WALLET_DETAILS
                return
                    <WALLET_DETAILS>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <WALLET>
                                    <RECORD>{ data($WALLET/RECORD) }</RECORD>
                                    <ID>{ data($WALLET/ID) }</ID>
                                    <LEGAL_ID>{ data($WALLET/LEGAL_ID) }</LEGAL_ID>
                                    <NAME>{ data($WALLET/NAME) }</NAME>
                                    <AMOUNT>{ data($WALLET/AMOUNT) }</AMOUNT>
                                    <PRODUCT_TYPE>{ data($WALLET/PRODUCT_TYPE) }</PRODUCT_TYPE>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns1:cargaLoteBilletera>
};

declare variable $cargaLoteBilletera as element(ns0:cargaLoteBilletera) external;

xf:cargaLoteBilleteraPuenteIn($cargaLoteBilletera)