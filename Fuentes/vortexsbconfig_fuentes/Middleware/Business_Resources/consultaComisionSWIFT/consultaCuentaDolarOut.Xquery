<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteResponse" element="ns0:consultaActivosClienteResponse" location="../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaComisionSWIFT/consultaCuentaDolarOut/";

declare function xf:consultaCuentaDolarOut($consultaActivosClienteResponse as element(ns0:consultaActivosClienteResponse), $currency as xs:string)
    as xs:string? {
		let $result := (    
	        for $cuenta in ($consultaActivosClienteResponse/ns0:consultaActivosClienteAhorrosResponseType/ns0:consultaActivosClienteResponseRecordType, 
	        				 $consultaActivosClienteResponse/ns0:consultaActivosClienteCorrienteResponseType/ns0:consultaActivosClienteResponseRecordType)
	        where $cuenta/ASSET_CURRENCY = $currency and $cuenta/ASSET_AVAILABLE_BALANCE >= 20 
	        return
	            $cuenta/ASSET_NUMBER
	    ) return $result[1]
};

declare variable $consultaActivosClienteResponse as element(ns0:consultaActivosClienteResponse) external;
declare variable $currency as xs:string external;

xf:consultaCuentaDolarOut($consultaActivosClienteResponse, $currency)</con:xquery>
    <con:dependency location="../consultasCliente/Resources/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes"/>
    </con:dependency>
</con:xqueryEntry>