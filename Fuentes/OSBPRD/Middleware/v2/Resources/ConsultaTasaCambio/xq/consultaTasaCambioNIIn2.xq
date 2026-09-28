(:: pragma bea:global-element-parameter parameter="$consultaTasaCambio1" element="ns1:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opBuscarTasaCambioSolicitud" location="../../../BusinessServices/CTS/tesoreria/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistesoreria.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/consultaTasaCambioNIIn2/";

declare function convertirMoneda($moneda as xs:string) as xs:integer {
	
	if($moneda='NIO')then
		0
	else if($moneda='USD')then
		1
	else if($moneda='EUR')then
		8
	else
		-1	
};

declare function xf:consultaTasaCambioNIIn2($consultaTasaCambio1 as element(ns1:consultaTasaCambio))
    as element(ns2:opBuscarTasaCambioSolicitud) {
        <ns2:opBuscarTasaCambioSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:monedaCompra>{ convertirMoneda(fn:string($consultaTasaCambio1/TARGET_CURRENCY/text())) }</ns0:monedaCompra>
            <ns0:indicador>3</ns0:indicador>
        </ns2:opBuscarTasaCambioSolicitud>
};

declare variable $consultaTasaCambio1 as element(ns1:consultaTasaCambio) external;

xf:consultaTasaCambioNIIn2($consultaTasaCambio1)