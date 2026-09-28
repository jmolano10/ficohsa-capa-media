(:: pragma bea:global-element-parameter parameter="$opConsultaMovimientosTarjetaCreditoRespuesta" element="ns3:opConsultaMovimientosTarjetaCreditoRespuesta" location="../../../CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:sjConsultaMovsRecientesTCNIResponse" location="../xsd/sjConsultaMovsRecientesTCNI.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMovsRecientesTC/xq/consultaMovsRecientesTCNIGeneralOut/";

declare function xf:consultaMovsRecientesTCNIGeneralOut($opConsultaMovimientosTarjetaCreditoRespuesta as element(ns3:opConsultaMovimientosTarjetaCreditoRespuesta))
    as element(ns4:sjConsultaMovsRecientesTCNIResponse) {
        <ns4:sjConsultaMovsRecientesTCNIResponse>
            {
                for $codTipoRespuesta in $opConsultaMovimientosTarjetaCreditoRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta
                return
                	
                	if (fn:string(data($codTipoRespuesta)) = '0') then
                	(
                        <SUCCESS_INDICATOR>{"Success"}</SUCCESS_INDICATOR>
                    )else(
                    	<SUCCESS_INDICATOR>{"ERROR"}</SUCCESS_INDICATOR>,                	
		                <ERROR_MESSAGE>{ data($opConsultaMovimientosTarjetaCreditoRespuesta/ns0:messages[1]/ns2:message) }</ERROR_MESSAGE>
                    )
                
            }
            {
                for $valNombreTitular in $opConsultaMovimientosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valNombreTitular
                return
                    <OWNER_NAME>{ data($valNombreTitular) }</OWNER_NAME>
            }
            {
                for $codTipoProducto in $opConsultaMovimientosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valNumeroTC/ns1:codTipoProducto
                return
                    <CARD_NUMBER>{ data($codTipoProducto) }</CARD_NUMBER>
            }
            <MOVS/>
            
        </ns4:sjConsultaMovsRecientesTCNIResponse>
};

declare variable $opConsultaMovimientosTarjetaCreditoRespuesta as element(ns3:opConsultaMovimientosTarjetaCreditoRespuesta) external;

xf:consultaMovsRecientesTCNIGeneralOut($opConsultaMovimientosTarjetaCreditoRespuesta)