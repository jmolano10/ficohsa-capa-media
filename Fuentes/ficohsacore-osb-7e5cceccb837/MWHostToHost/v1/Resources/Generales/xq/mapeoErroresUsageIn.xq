(:: pragma bea:global-element-return element="ns0:mapeoErrores" location="../../../BusinessServices/OSB/mapeoErrores/wsdl/MapeoErrores.wsdl" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn/";

declare function xf:mapeoErroresUsageIn($MENSAJE_ERROR as xs:string,
    $CODIGO_ERROR as xs:string)
    as element(ns0:mapeoErrores) {
        <ns0:mapeoErrores>
            <TEXTO_ERROR>{ $MENSAJE_ERROR }</TEXTO_ERROR>
            <CODIGO_ERROR>{ $CODIGO_ERROR }</CODIGO_ERROR>
        </ns0:mapeoErrores>
};

declare variable $MENSAJE_ERROR as xs:string external;
declare variable $CODIGO_ERROR as xs:string external;

xf:mapeoErroresUsageIn($MENSAJE_ERROR,
    $CODIGO_ERROR)
