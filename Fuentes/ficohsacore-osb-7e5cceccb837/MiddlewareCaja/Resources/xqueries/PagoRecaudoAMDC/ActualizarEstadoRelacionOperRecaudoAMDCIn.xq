(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ActualizarEstadoRelacionOperacionRecaudoAMDC/FLINK_OSB_ACT_EST_OPER_REC_AMDC.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_ACT_EST_OPER_REC_AMDC/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/ActualizarEstadoRelacionOperRecaudoAMDCIn/";

declare function xf:ActualizarEstadoRelacionOperRecaudoAMDCIn($codigoContrato as xs:string,
    $codigoDeudor as xs:string,
    $estadoAnterior as xs:string,
    $estadoNuevo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRATO>{ $codigoContrato }</ns0:CONTRATO>
            <ns0:DEUDOR>{ $codigoDeudor }</ns0:DEUDOR>
            <ns0:ESTADO_ANTERIOR>{ $estadoAnterior }</ns0:ESTADO_ANTERIOR>
            <ns0:ESTADO_NUEVO>{ $estadoNuevo }</ns0:ESTADO_NUEVO>
        </ns0:InputParameters>
};

declare variable $codigoContrato as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $estadoAnterior as xs:string external;
declare variable $estadoNuevo as xs:string external;

xf:ActualizarEstadoRelacionOperRecaudoAMDCIn($codigoContrato,
    $codigoDeudor,
    $estadoAnterior,
    $estadoNuevo)