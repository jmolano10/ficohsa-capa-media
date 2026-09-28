(:: pragma bea:global-element-parameter parameter="$opBuscarTasaCambioRespuesta" element="ns1:opBuscarTasaCambioRespuesta" location="../../../BusinessServices/CTS/tesoreria/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioResponse" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns2 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns1 = "http://service.srvaplcobistesoreria.ecobis.cobiscorp";
declare namespace ns4 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns3 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/consultaTasaCambioNIOut/";

declare function xf:consultaTasaCambioNIOut($opBuscarTasaCambioRespuesta as element(ns1:opBuscarTasaCambioRespuesta))
    as element(ns0:consultaTasaCambioResponse) {
        <ns0:consultaTasaCambioResponse>
            <ns0:consultaTasaCambioResponseType>
                <ns0:consultaTasaCambioResponseRecordType>
                    <BUY_RATE>{ data($opBuscarTasaCambioRespuesta/ns3:tasaCambio/ns3:tipoCambioCompra/ns3:valMonto) }</BUY_RATE>
                    <SELL_RATE>{ data($opBuscarTasaCambioRespuesta/ns3:tasaCambio/ns3:tipoCambioVenta/ns3:valMonto) }</SELL_RATE>
                </ns0:consultaTasaCambioResponseRecordType>
            </ns0:consultaTasaCambioResponseType>
        </ns0:consultaTasaCambioResponse>
};

declare variable $opBuscarTasaCambioRespuesta as element(ns1:opBuscarTasaCambioRespuesta) external;

xf:consultaTasaCambioNIOut($opBuscarTasaCambioRespuesta)