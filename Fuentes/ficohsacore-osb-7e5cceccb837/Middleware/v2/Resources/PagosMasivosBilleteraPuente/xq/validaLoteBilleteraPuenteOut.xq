(:: pragma bea:global-element-parameter parameter="$validaLoteBilleteraResponse" element="ns1:validaLoteBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaLoteBilleteraResponse" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/validaLoteBilleteraPuenteOut/";

declare function xf:validaLoteBilleteraPuenteOut($validaLoteBilleteraResponse as element(ns1:validaLoteBilleteraResponse))
    as element(ns0:validaLoteBilleteraResponse) {
        <ns0:validaLoteBilleteraResponse>
            <WALLET_DETAILS>
                <WALLET>
                    <RECORD>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/RECORD) }</RECORD>
                    <ID>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/ID) }</ID>
                    <DESCRIPTION>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/DESCRIPTION) }</DESCRIPTION>
                    <STATUS>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/STATUS) }</STATUS>
                    <STATUS_DESCRIPTION>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/STATUS_DESCRIPTION) }</STATUS_DESCRIPTION>
                    <LEGAL_ID>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/LEGAL_ID) }</LEGAL_ID>
                    <NAME>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/NAME) }</NAME>
                    <PRODUCT_TYPE>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/PRODUCT_TYPE) }</PRODUCT_TYPE>
                    <AMOUNT>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/AMOUNT) }</AMOUNT>
                    <ERROR_ID>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/ERROR_ID) }</ERROR_ID>
                    <ERROR_DESCRIPTION>{ data($validaLoteBilleteraResponse/WALLET_DETAILS/WALLET[1]/ERROR_DESCRIPTION) }</ERROR_DESCRIPTION>
                </WALLET>
            </WALLET_DETAILS>
        </ns0:validaLoteBilleteraResponse>
};

declare variable $validaLoteBilleteraResponse as element(ns1:validaLoteBilleteraResponse) external;

xf:validaLoteBilleteraPuenteOut($validaLoteBilleteraResponse)
