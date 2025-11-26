(:: pragma bea:global-element-parameter parameter="$opTransferenciaIndividualACHRespuesta" element="ns3:opTransferenciaIndividualACHRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciasACHResponse" location="../xsd/transferenciasACHType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/transferenciasACHNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function numIsNull($item as item()?) as xs:string {
	if (fn:string($item/text()) != '' ) then (
		string(round-half-to-even( xs:decimal(data($item)), 2 ))
	) else ('')
};

declare function xf:transferenciasACHNIOut($opTransferenciaIndividualACHRespuesta as element(ns3:opTransferenciaIndividualACHRespuesta))
    as element(ns0:transferenciasACHResponse) {
        <ns0:transferenciasACHResponse>
        	{
        		for $tasa in $opTransferenciaIndividualACHRespuesta/ns1:salienteIndividualACHRespuesta/ns1:tipoCambio
        		return
        			<EXCHANGE_RATE>{ numIsNull($tasa)}</EXCHANGE_RATE>
        	}
            {
                for $valorMontoCuenta in $opTransferenciaIndividualACHRespuesta/ns1:salienteIndividualACHRespuesta/ns1:valorMontoCuenta
                return
                    <DEBIT_AMOUNT>{ numIsNull($valorMontoCuenta) }</DEBIT_AMOUNT>
            }
            {
                for $valorMontoMonedaDestino in $opTransferenciaIndividualACHRespuesta/ns1:salienteIndividualACHRespuesta/ns1:valorMontoMonedaDestino
                return
                    <CREDIT_AMOUNT>{ numIsNull($valorMontoMonedaDestino) }</CREDIT_AMOUNT>
            }
        </ns0:transferenciasACHResponse>
};

declare variable $opTransferenciaIndividualACHRespuesta as element(ns3:opTransferenciaIndividualACHRespuesta) external;

xf:transferenciasACHNIOut($opTransferenciaIndividualACHRespuesta)