(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns3:opConsultaFlotanteRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns3 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleBloqueosTD/xq/consultaDetBloqueosTDNIHeaderOut/";

declare function xf:consultaDetBloqueosTDNIHeaderOut($outputParameters1 as element(ns3:opConsultaFlotanteRespuesta))
    as element(ns4:ResponseHeader) {
        <ns4:ResponseHeader>
        {
            for $ERROR_CODE in $outputParameters1/ns1:contextoRespuesta/ns1:codTipoRespuesta
            return
            if(fn:string(data($ERROR_CODE))="0")then (
                <successIndicator>Success</successIndicator>
            )else(
                <successIndicator>{ data($outputParameters1/ns1:contextoRespuesta/ns1:codTipoRespuesta) }</successIndicator>,
                <messages>{ data($outputParameters1/ns1:contextoRespuesta/ns1:valDescripcionRespuesta) }</messages>
            )
        }
        </ns4:ResponseHeader>
};

declare variable $outputParameters1 as element(ns3:opConsultaFlotanteRespuesta) external;

xf:consultaDetBloqueosTDNIHeaderOut($outputParameters1)