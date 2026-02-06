xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaEstadoRemesaRequest" element="ns0:notificaEstadoRemesaRequest" location="../xsd/notificaEstadoRemesaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Remesas/NotificaEstadoRemesa/xsd/notificaEstadoRemesa_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaEstadoRemesa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesa/xq/notificaEstadoRemesaNormalIn/";

declare function xf:notificaEstadoRemesaNormalIn($notificaEstadoRemesaRequest as element(ns0:notificaEstadoRemesaRequest),
    $numeroContrato as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_CONTRATO>{ $numeroContrato }</ns1:PV_NUMERO_CONTRATO>
            <ns1:PV_TIPO_REQUETS>{ data($notificaEstadoRemesaRequest/REQUEST_TYPE) }</ns1:PV_TIPO_REQUETS>
            <ns1:PV_TIPO_CONSULTA>{ data($notificaEstadoRemesaRequest/QUERY_TYPE) }</ns1:PV_TIPO_CONSULTA>
            <ns1:PV_CANTIDAD>{ data($notificaEstadoRemesaRequest/TOTAL_RECORDS) }</ns1:PV_CANTIDAD>
            <ns1:PV_FECHA_INICIO>{ data($notificaEstadoRemesaRequest/DATA_RANGE/START_DATE) }</ns1:PV_FECHA_INICIO>
            <ns1:PV_FECHA_FIN>{ data($notificaEstadoRemesaRequest/DATA_RANGE/END_DATE) }</ns1:PV_FECHA_FIN>
        </ns1:InputParameters>
};

declare variable $notificaEstadoRemesaRequest as element(ns0:notificaEstadoRemesaRequest) external;
declare variable $numeroContrato as xs:string external;

xf:notificaEstadoRemesaNormalIn($notificaEstadoRemesaRequest,
    $numeroContrato)