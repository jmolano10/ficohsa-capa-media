(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_CONSULTAR_REF_ONLINE/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/consultaReferenciadoEnLineaIn/";

declare function xf:consultaReferenciadoEnLineaIn($contractId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ $contractId }</ns1:CODIGO_CONTRATO>
        </ns1:InputParameters>
};

declare variable $contractId as xs:string external;

xf:consultaReferenciadoEnLineaIn($contractId)