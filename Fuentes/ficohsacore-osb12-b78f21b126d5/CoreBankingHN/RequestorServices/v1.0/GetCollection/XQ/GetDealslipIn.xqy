xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/QueryThirdPartyResponse";
(:: import schema at "../../../../ProviderServices/XSD/QueryThirdPartyResponse/QueryThirdPartyResponse_sp.xsd" ::)

declare variable $QueryThirdPartyResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

(:: Equivalente a un NVL en Oracle:)
declare function local:if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
 
(:: Realiza un replcae multiple :)
declare function local:replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then local:replace-multi(
          replace($arg, $changeFrom[1],
                     local:if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;

declare function local:func($QueryThirdPartyResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as xs:string {
    
    let $response := fn-bea:inlinedXML($QueryThirdPartyResponse/ns1:RESPUESTA_TERCERO)
    	return
    		local:replace-multi(fn:string($response//moreParameters/data[@fieldName="dealslip"]/text()), ('&amp;#61', '&amp;#44'), ('=',','))
};

local:func($QueryThirdPartyResponse)