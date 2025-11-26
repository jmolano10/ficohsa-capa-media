(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MapeoErrores/xsd/mapeodeErrores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:mapeoErroresResponse" location="../wsdl/mapeoErroresProxy.wsdl" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/mapeodeErrores";
declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresOut/";

declare function xf:mapeoErroresOut($outputParameters1 as element(ns1:OutputParameters),
    $msjId as xs:string?)
    as element(ns0:mapeoErroresResponse) {
        <ns0:mapeoErroresResponse>
            <MENSAJE_MAPEADO>{ fn:concat("(MsjId:", $msjId, ") ", fn:string($outputParameters1/ns1:MENSAJE_MAPEADO/text())) }</MENSAJE_MAPEADO>
            <CODIGO_ERROR>{ data($outputParameters1/ns1:CODIGO_ERROR) }</CODIGO_ERROR>
            <DESCRIPCION_ERROR>{ data($outputParameters1/ns1:DESCRIPCION_ERROR) }</DESCRIPCION_ERROR>
            <CODIGO_RETORNO>{ data($outputParameters1/ns1:CODIGO_RETORNO) }</CODIGO_RETORNO>
        </ns0:mapeoErroresResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $msjId as xs:string? external;

xf:mapeoErroresOut($outputParameters1,
    $msjId)