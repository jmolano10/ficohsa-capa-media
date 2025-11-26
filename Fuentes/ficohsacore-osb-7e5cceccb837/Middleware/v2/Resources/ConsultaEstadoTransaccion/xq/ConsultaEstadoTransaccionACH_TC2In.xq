(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion1" element="ns1:consultaEstadoTransaccion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_TC2In/";

declare function xf:ConsultaEstadoTransaccionACH_TC2In($consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:GV_TICKET>{ data($consultaEstadoTransaccion1/TICKET) }</ns0:GV_TICKET>
        </ns0:InputParameters>
};

declare variable $consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion) external;

xf:ConsultaEstadoTransaccionACH_TC2In($consultaEstadoTransaccion1)
