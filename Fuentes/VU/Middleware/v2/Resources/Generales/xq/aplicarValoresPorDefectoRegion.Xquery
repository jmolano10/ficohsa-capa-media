<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion/";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare function local:origenPorDefecto($origen as xs:string?) as xs:string {
	let $data := replace(replace($origen,'\s+$',''),'^\s+','')
		return
			if ( $data = "" ) then (
				"HN01"
			) else (
				$data
			)
	
};

declare function local:destinoPorDefecto($origen as xs:string?, $destino as xs:string?) as xs:string {
	let $origenTemp := xq:origenPorDefecto($origen)
	let $data := replace(replace($destino,'\s+$',''),'^\s+','')
		return
			if ( $data = "" ) then (
				$origenTemp
			) else (
				$data
			)
	
};

declare function xf:aplicarValoresPorDefectoRegion($requestHeader as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>{ $requestHeader/Authentication/@* , $requestHeader/Authentication/node() }</Authentication>
            <Region>
            	{
            		let $origen := fn:string($requestHeader/Region/SourceBank/text())
            		let $destino := fn:string($requestHeader/Region/DestinationBank/text())
            			return (
                			<SourceBank>{ xq:origenPorDefecto($origen) }</SourceBank>,
                			<DestinationBank>{ xq:destinoPorDefecto($origen, $destino) }</DestinationBank>
                			)
				}
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:aplicarValoresPorDefectoRegion($requestHeader)]]></con:xquery>
</con:xqueryEntry>