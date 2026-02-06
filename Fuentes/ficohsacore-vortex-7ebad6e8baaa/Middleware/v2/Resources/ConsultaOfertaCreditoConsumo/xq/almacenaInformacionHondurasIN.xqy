xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AlmacenaInformacionOfertaHonduras";
(:: import schema at "../../../BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/xsd/AlmacenaInformacionOfertaHonduras_sp.xsd" ::)

declare variable $identidad as xs:string external;
declare variable $xml as xs:string external;

declare function local:func($identidad as xs:string, 
                            $xml as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:IDENTIDAD>{fn:data($identidad)}</ns1:IDENTIDAD>
        <ns1:XML>{fn:data($xml)}</ns1:XML>
    </ns1:InputParameters>
};

local:func($identidad, $xml)