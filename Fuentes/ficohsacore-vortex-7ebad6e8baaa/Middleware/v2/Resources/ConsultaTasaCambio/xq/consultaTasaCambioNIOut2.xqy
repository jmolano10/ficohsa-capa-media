xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opBuscarTasaCambioRespuesta1" element="ns2:opBuscarTasaCambioRespuesta" location="../../../BusinessServices/CTS/tesoreria/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaTasaCambioResponse" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistesoreria.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/consultaTasaCambioNIOut2/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";

declare function xf:consultaTasaCambioNIOut2($successIndicator as xs:string,
    $opBuscarTasaCambioRespuesta1 as element(ns2:opBuscarTasaCambioRespuesta))
    as element(ns3:consultaTasaCambioResponse) {
        <ns3:consultaTasaCambioResponse>
	        {
				if ($successIndicator="SUCCESS") then (
		            <ns3:consultaTasaCambioResponseType>
		                <ns3:consultaTasaCambioResponseRecordType>
		                	{
			                	for $montoCompra in $opBuscarTasaCambioRespuesta1/ns0:tasaCambio/ns0:tipoCambioCompra/ns0:valMonto
			                	return
			                		<BUY_RATE>{ fn:string(data($montoCompra)) }</BUY_RATE>
		                	}
		                	{
			                	for $montoVenta in $opBuscarTasaCambioRespuesta1/ns0:tasaCambio/ns0:tipoCambioVenta/ns0:valMonto
			                	return
			                		<SELL_RATE>{ fn:string(data($montoVenta)) }</SELL_RATE>
		                	}
		                </ns3:consultaTasaCambioResponseRecordType>
		            </ns3:consultaTasaCambioResponseType>
	            ) else ()
            }
        </ns3:consultaTasaCambioResponse>
};

declare variable $successIndicator as xs:string external;
declare variable $opBuscarTasaCambioRespuesta1 as element(ns2:opBuscarTasaCambioRespuesta) external;

xf:consultaTasaCambioNIOut2($successIndicator,
    $opBuscarTasaCambioRespuesta1)