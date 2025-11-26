(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ActualizarEstadoRelacionOperacionRecaudoMigracion/FLINK_OSB_ACT_EST_OPER_REC_MIGRACION.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_ACT_EST_OPER_REC_MIGRACION/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/ActualizarEstadoRelacionOperacionRecaudoMigracionIn/";

declare function xf:ActualizarEstadoRelacionOperacionRecaudoMigracionIn($numeroIdentidad as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NUMERO_IDENTIDAD>{ $numeroIdentidad }</ns0:NUMERO_IDENTIDAD>
            <ns0:ESTADO_ANTERIOR>1</ns0:ESTADO_ANTERIOR>
            <ns0:ESTADO_NUEVO>2</ns0:ESTADO_NUEVO>
        </ns0:InputParameters>
};

declare variable $numeroIdentidad as xs:string external;

xf:ActualizarEstadoRelacionOperacionRecaudoMigracionIn($numeroIdentidad)