<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";


(:: OracleAnnotationVersion "1.0" ::)



declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerParametrizacionMiddleware";
(:: import schema at "../../../BusinessServices/ObtenerParametrizacionMiddleware/xsd/ObtenerParametrizacionMiddleware_sp.xsd" ::)



declare function local:ObtenerParametrizacionMiddlewareIn($NombreParametro as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
        <ns1:InputParameters>
            <PARAMETRIZACIONES>
            {
                if(normalize-space(($NombreParametro)) != "") then (
                        	<ns1:PARAMETRIZACIONES_ITEM>{ $NombreParametro }</ns1:PARAMETRIZACIONES_ITEM>
                        ) else()
            }
            </PARAMETRIZACIONES>
         </ns1:InputParameters>
        
};


declare variable $NombreParametro as xs:string external;
local:ObtenerParametrizacionMiddlewareIn($NombreParametro)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/ObtenerParametrizacionMiddleware/xsd/ObtenerParametrizacionMiddleware_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ObtenerParametrizacionMiddleware/xsd/ObtenerParametrizacionMiddleware_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>