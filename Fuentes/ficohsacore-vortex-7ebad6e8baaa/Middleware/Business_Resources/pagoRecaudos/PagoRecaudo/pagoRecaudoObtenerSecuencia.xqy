xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/obtenerSecuencia/xsd/obtenerSecuencia_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSecuencia";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoObtenerSecuencia/";

declare function xf:pagoRecaudoObtenerSecuencia($tipoSecuencia as xs:string,
    $semilla as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_SECUENCIA>{ $tipoSecuencia }</ns0:PV_TIPO_SECUENCIA>
            <ns0:PV_SEMILLA>{ $semilla }</ns0:PV_SEMILLA>
        </ns0:InputParameters>
};

declare variable $tipoSecuencia as xs:string external;
declare variable $semilla as xs:string external;

xf:pagoRecaudoObtenerSecuencia($tipoSecuencia,
    $semilla)