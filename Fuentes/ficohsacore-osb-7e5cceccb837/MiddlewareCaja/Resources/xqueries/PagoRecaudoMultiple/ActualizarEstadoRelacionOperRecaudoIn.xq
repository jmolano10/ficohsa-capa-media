xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ActualizarEstadoRelacionOperacionRecaudo/FLINK_OSB_ACT_ESTADO_OPER_RECAUDO.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/ActualizarEstadoRelacionOperRecaudoIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_ACT_ESTADO_OPER_RECAUDO/";

declare function xf:ActualizarEstadoRelacionOperRecaudoIn($codigoContrato as xs:string,
    $codigoDeudor as xs:string,
    $estadoAnterior as xs:string,
    $estadoNuevo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_CONTRATO>{ $codigoContrato }</ns0:CODIGO_CONTRATO>
            <ns0:CODIGO_DEUDOR>{ $codigoDeudor }</ns0:CODIGO_DEUDOR>
            <ns0:ESTADO_ANTERIOR>{ $estadoAnterior }</ns0:ESTADO_ANTERIOR>
            <ns0:ESTADO_NUEVO>{ $estadoNuevo }</ns0:ESTADO_NUEVO>
        </ns0:InputParameters>
};

declare variable $codigoContrato as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $estadoAnterior as xs:string external;
declare variable $estadoNuevo as xs:string external;

xf:ActualizarEstadoRelacionOperRecaudoIn($codigoContrato,
    $codigoDeudor,
    $estadoAnterior,
    $estadoNuevo)