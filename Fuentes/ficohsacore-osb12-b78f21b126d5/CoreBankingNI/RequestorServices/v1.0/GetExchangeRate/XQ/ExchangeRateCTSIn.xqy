xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://service.srvaplcobistesoreria.ecobis.cobiscorp";
(:: import schema at "../../../../ProviderServices/XSD/ExchangeRateCTS/services.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)

declare namespace dto = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare variable $GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::) external;

declare function local:convertirMoneda($moneda as xs:string) as xs:integer {
	
	if($moneda='NIO')then(
            0
	)else if($moneda='USD')then(
            1
	)else if($moneda='EUR')then(
            8
	)else(
            -1	
        )
};

declare function local:func($GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::)) as element() (:: schema-element(ns2:opBuscarTasaCambioSolicitud) ::) {
    <ns2:opBuscarTasaCambioSolicitud>
        <dto:contextoTransaccional>
            <dto:codCanalOriginador>1</dto:codCanalOriginador>
        </dto:contextoTransaccional>
        <dto:monedaCompra>{ local:convertirMoneda(fn:string($GetExchangeRateRequest/ns1:SourceCurrency/text())) }</dto:monedaCompra>
        <dto:indicador>3</dto:indicador>
        <dto:codMonedaDebito>{local:convertirMoneda(fn:string($GetExchangeRateRequest/ns1:TargetCurrency/text())) }</dto:codMonedaDebito>
    </ns2:opBuscarTasaCambioSolicitud>
};

local:func($GetExchangeRateRequest)