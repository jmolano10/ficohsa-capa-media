(:: pragma bea:global-element-parameter parameter="$validaBulkResponse" element="ns1:ValidaBulkResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaLoteBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaLoteBilletera/xq/validaLoteBilleteraOut/";

declare function xf:validaLoteBilleteraOut($validaBulkResponse as element(ns1:ValidaBulkResponse))
    as element(ns0:validaLoteBilleteraResponse) {
        <ns0:validaLoteBilleteraResponse>
            {
                let $billeteras := $validaBulkResponse/return/billeteras
                return
                    <WALLET_DETAILS>
                        {
                            for $billetera in $billeteras/billetera
                            return
                                <WALLET>
                                    <RECORD>{ data($billetera/linea) }</RECORD>
                                    <ID>{ data($billetera/credBilletera) }</ID>
                                    <DESCRIPTION>{ data($billetera/concepto) }</DESCRIPTION>
                                    <STATUS>{ data($billetera/codEstado) }</STATUS>
                                    <STATUS_DESCRIPTION>{ data($billetera/desEstado) }</STATUS_DESCRIPTION>
                                    <LEGAL_ID>{ data($billetera/identidad) }</LEGAL_ID>
                                    <NAME>{ data($billetera/nombreTitular) }</NAME>
                                    <PRODUCT_TYPE>{ data($billetera/tipoProducto) }</PRODUCT_TYPE>
                                    <AMOUNT>{ data($billetera/monto) }</AMOUNT>
                                    <ERROR_ID>{ data($billetera/codError) }</ERROR_ID>
                                    <ERROR_DESCRIPTION>{ data($billetera/desError) }</ERROR_DESCRIPTION>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns0:validaLoteBilleteraResponse>
};

declare variable $validaBulkResponse as element(ns1:ValidaBulkResponse) external;

xf:validaLoteBilleteraOut($validaBulkResponse)
