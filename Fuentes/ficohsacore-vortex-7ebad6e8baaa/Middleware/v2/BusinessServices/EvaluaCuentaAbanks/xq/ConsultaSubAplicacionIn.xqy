xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../consultaSubaplicacionValida/xsd/CONS_SUBAPP_VALIDA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_SUBAPP_VALIDA";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluaCuentaAbanks/ConsultaSubAplicacionIn/";

declare function xf:ConsultaSubAplicacionIn($subApplicacion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:VA_SUBAPLICACION>{ $subApplicacion }</ns0:VA_SUBAPLICACION>
        </ns0:InputParameters>
};

declare variable $subApplicacion as xs:string external;

xf:ConsultaSubAplicacionIn($subApplicacion)