xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_PORC_LEVENSTEIN";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ConsultaPorcentajeLevensteinOut/";

declare function xf:ConsultaPorcentajeLevensteinOut($outputParameters1 as element(ns0:OutputParameters))
    as xs:string {   
        data($outputParameters1/ns0:VA_PORCENTAJE)
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaPorcentajeLevensteinOut($outputParameters1)