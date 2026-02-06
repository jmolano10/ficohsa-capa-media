xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTranferResponse" element="ns1:PagoTranferResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cargaLoteBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaLoteBilletera/xq/cargaLoteBilleteraOut/";

declare function xf:cargaLoteBilleteraOut($pagoTranferResponse as element(ns1:PagoTranferResponse))
    as element(ns0:cargaLoteBilleteraResponse) {
        <ns0:cargaLoteBilleteraResponse>
            <USERNAME>{ data($pagoTranferResponse/return/usuario) }</USERNAME>
            <DEBIT_WALLET>{ data($pagoTranferResponse/return/debBilletera) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($pagoTranferResponse/return/correlativo) }</BANK_BATCH_ID>
            <STATUS>{ xs:int(data($pagoTranferResponse/return/codEstado)) }</STATUS>
            <STATUS_DESCRIPTION>{ data($pagoTranferResponse/return/desEstado) }</STATUS_DESCRIPTION>
            <NUMBER_OF_TRANSACTIONS>{ xs:int(data($pagoTranferResponse/return/numeroTransacciones)) }</NUMBER_OF_TRANSACTIONS>
            <TOTAL_AMOUNT>{ data($pagoTranferResponse/return/montoTotal) }</TOTAL_AMOUNT>
            {
                let $billeteras0 := $pagoTranferResponse/return/billeteras
                return
                    <WALLET_DETAILS>
                        {
                            for $billeteras in $billeteras0/billeteras
                            return
                                <WALLET>
                                    <RECORD>{ data($billeteras/linea) }</RECORD>
                                    <REFERENCE_NUMBER>{ data($billeteras/numeroRef) }</REFERENCE_NUMBER>
                                    <DESCRIPTION>{ data($billeteras/descripcion) }</DESCRIPTION>
                                    <ID>{ data($billeteras/credBilletera) }</ID>
                                    <LEGAL_ID>{ data($billeteras/identidad) }</LEGAL_ID>
                                    <NAME>{ data($billeteras/nombreTitular) }</NAME>
                                    <STATUS>{ xs:int(data($billeteras/codEstado)) }</STATUS>
                                    <STATUS_DESCRIPTION>{ data($billeteras/desEstado) }</STATUS_DESCRIPTION>
                                    <ERROR_CODE>
                                    { 
                                    	let $data := data($billeteras/codError)
                                    	return
                                    	if ( $data = '') then (
                                    		$data
                                    	)else(
                                    	xs:int($data)
                                    	) 
                                    }
                                    </ERROR_CODE>
                                    <ERROR_DESCRIPTION>{ data($billeteras/desError) }</ERROR_DESCRIPTION>
                                    <AMOUNT>{ data($billeteras/monto) }</AMOUNT>
                                </WALLET>
                        }
                    </WALLET_DETAILS>
            }
        </ns0:cargaLoteBilleteraResponse>
};

declare variable $pagoTranferResponse as element(ns1:PagoTranferResponse) external;

xf:cargaLoteBilleteraOut($pagoTranferResponse)