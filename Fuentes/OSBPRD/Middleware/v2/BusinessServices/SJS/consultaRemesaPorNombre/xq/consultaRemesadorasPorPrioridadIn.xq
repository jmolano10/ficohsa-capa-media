(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../MDW/consultaRemesadorasPorPrioridad/xsd/consultaRemesadorasPorPrioridad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesadorasPorPrioridad";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesaPorNombre/xq/sjConsultaRemesadorasPorPrioridad/";

declare function xf:sjConsultaRemesadorasPorPrioridad($string as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PRIORIDAD>{ data($string) }</ns0:PRIORIDAD>
        </ns0:InputParameters>
};

declare variable $string as xs:string external;

xf:sjConsultaRemesadorasPorPrioridad($string)