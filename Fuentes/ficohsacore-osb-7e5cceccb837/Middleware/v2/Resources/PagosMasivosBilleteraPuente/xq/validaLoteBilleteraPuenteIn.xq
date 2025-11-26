(:: pragma bea:global-element-parameter parameter="$validaLoteBilletera" element="ns0:validaLoteBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaLoteBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/validaLoteBilleteraPuenteIn/";

declare function xf:validaLoteBilleteraPuenteIn($validaLoteBilletera as element(ns0:validaLoteBilletera))
    as element(ns1:validaLoteBilletera) {
        <ns1:validaLoteBilletera>
            <USERNAME>{ data($validaLoteBilletera/USERNAME) }</USERNAME>
            {
                let $WALLET_DETAILS := $validaLoteBilletera/WALLET_DETAILS
                return
                    <WALLET_DETAILS>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <WALLET>
                                    <RECORD>{ data($WALLET/RECORD) }</RECORD>
                                    <ID>{ data($WALLET/ID) }</ID>
                                    <DESCRIPTION>{ data($WALLET/DESCRIPTION) }</DESCRIPTION>
                                    <LEGAL_ID>{ data($WALLET/LEGAL_ID) }</LEGAL_ID>
                                    <NAME>{ data($WALLET/NAME) }</NAME>
                                    <AMOUNT>{ data($WALLET/AMOUNT) }</AMOUNT>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns1:validaLoteBilletera>
};

declare variable $validaLoteBilletera as element(ns0:validaLoteBilletera) external;

xf:validaLoteBilleteraPuenteIn($validaLoteBilletera)
