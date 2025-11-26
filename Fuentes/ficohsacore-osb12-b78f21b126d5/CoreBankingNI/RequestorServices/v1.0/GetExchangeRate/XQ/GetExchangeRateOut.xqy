xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://service.srvaplcobistesoreria.ecobis.cobiscorp";
(:: import schema at "../../../../ProviderServices/XSD/ExchangeRateCTS/services.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare namespace dto = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare variable $RSPOpBuscarTasaCambio as element() (:: schema-element(ns1:opBuscarTasaCambioRespuesta) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($RSPOpBuscarTasaCambio as element() (:: schema-element(ns1:opBuscarTasaCambioRespuesta) ::), 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:getExchangeRateResponse) ::) {
    <ns2:getExchangeRateResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:getExchangeRateResponseType>
            <ns2:getExchangeRateRecordType>
                {
                    if ($RSPOpBuscarTasaCambio/dto:tasaCambio/dto:tipoCambioCompra/dto:valMonto)
                    then <ns2:BuyRate>{fn:data($RSPOpBuscarTasaCambio/dto:tasaCambio/dto:tipoCambioCompra/dto:valMonto)}</ns2:BuyRate>
                    else ()
                }
                {
                    if ($RSPOpBuscarTasaCambio/dto:tasaCambio/dto:tipoCambioVenta/dto:valMonto)
                    then <ns2:SellRate>{fn:data($RSPOpBuscarTasaCambio/dto:tasaCambio/dto:tipoCambioVenta/dto:valMonto)}</ns2:SellRate>
                    else ()
                }
            </ns2:getExchangeRateRecordType>
        </ns2:getExchangeRateResponseType>
    </ns2:getExchangeRateResponse>
};

local:func($RSPOpBuscarTasaCambio, $uuid)