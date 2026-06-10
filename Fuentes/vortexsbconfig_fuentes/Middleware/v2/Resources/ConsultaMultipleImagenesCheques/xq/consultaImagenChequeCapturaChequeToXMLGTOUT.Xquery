<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma  type="anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaImagenCheque/xq/consultaImagenChequeCapturaChequeToXMLGTOUT/";
declare namespace ns0 = "http://www.w3.org/2001/XMLSchema";

declare function xf:consultaImagenChequeCapturaChequeToXMLGTOUT($ResponseString as xs:string,
    $ParamtroConversion as xs:string)
    as element(*) {
&lt;ns0:anyType xmlns:ns0="http://www.w3.org/2001/XMLSchema">{ fn-bea:inlinedXML(fn:substring-after($ResponseString,
             $ParamtroConversion)) }&lt;/ns0:anyType>
        
};

declare variable $ResponseString as xs:string external;
declare variable $ParamtroConversion as xs:string external;

xf:consultaImagenChequeCapturaChequeToXMLGTOUT($ResponseString, $ParamtroConversion)</con:xquery>
</con:xqueryEntry>