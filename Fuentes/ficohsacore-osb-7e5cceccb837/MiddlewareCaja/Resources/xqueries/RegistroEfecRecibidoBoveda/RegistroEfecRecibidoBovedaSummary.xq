xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$movimientoefecdesdebovedaResponse" element="ns0:MovimientoefecdesdebovedaResponse" location="../../xsds/MovEfectivo/XMLSchema_1763986007.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroEfecRecibidoBoveda/RegistroEfecRecibidoBovedaSummary/";
declare namespace ns0 = "T24WebServicesImpl";

(: Se encarga de procesar el campo narrative y retornar su contenido en el formato solicitado :)
declare function getValue($narrative as xs:string) 
	as element(*)? {
	let $nodeName := fn:replace(fn:replace(fn-bea:trim(fn:substring-before($narrative, "-")), " ", "_"),"\.","")
	let $nodeValue := number(fn:substring-after($narrative, "-")) div 100
	return
		if(fn:contains($nodeName, "TOTAL")) then (
			fn-bea:inlinedXML(concat("<", $nodeName, ">", fn-bea:format-number($nodeValue,"######0.00"), "</", $nodeName, ">"))
			
		) else (
			fn-bea:inlinedXML(concat("<", "HNL", $nodeName, ">", fn-bea:format-number($nodeValue,"######0.00"), "</", "HNL", $nodeName, ">"))
			
		)
};

declare function xf:RegistroEfecRecibidoBovedaSummary($movimientoefecdesdebovedaResponse as element(ns0:MovimientoefecdesdebovedaResponse))
    as element(*) {
        <SUMMARY>	
    	{
    		for $narrative in $movimientoefecdesdebovedaResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/sgNARRATIVE1/NARRATIVE1
    		return
    			getValue($narrative)
    	}
        </SUMMARY>  
};

declare variable $movimientoefecdesdebovedaResponse as element(ns0:MovimientoefecdesdebovedaResponse) external;

xf:RegistroEfecRecibidoBovedaSummary($movimientoefecdesdebovedaResponse)