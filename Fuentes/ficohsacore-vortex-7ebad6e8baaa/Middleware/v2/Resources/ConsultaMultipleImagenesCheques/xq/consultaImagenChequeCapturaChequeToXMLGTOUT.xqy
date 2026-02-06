xquery version "2004-draft";
(:: pragma  type="anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaImagenCheque/xq/consultaImagenChequeCapturaChequeToXMLGTOUT/";
declare namespace ns0 = "http://www.w3.org/2001/XMLSchema";

declare function xf:consultaImagenChequeCapturaChequeToXMLGTOUT($ResponseString as xs:string,
    $ParamtroConversion as xs:string)
    as element(*) {
<ns0:anyType xmlns:ns0="http://www.w3.org/2001/XMLSchema">{ fn-bea:inlinedXML(fn:substring-after($ResponseString,
             $ParamtroConversion)) }</ns0:anyType>
        
};

declare variable $ResponseString as xs:string external;
declare variable $ParamtroConversion as xs:string external;

xf:consultaImagenChequeCapturaChequeToXMLGTOUT($ResponseString, $ParamtroConversion)