xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaDetalleCobroTSP/xsd/consultaDetalleCobroTSP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleCobroTSP";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCobroTSP/consultaDetalleCobroTSPIn/";

declare function xf:consultaDetalleCobroTSPIn($string1 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:REFERENCIA>{ $string1 }</ns0:REFERENCIA>
        </ns0:InputParameters>
};

declare variable $string1 as xs:string external;

xf:consultaDetalleCobroTSPIn($string1)