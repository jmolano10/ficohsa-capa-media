xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_TCOut/";

declare function xf:ConsultaEstadoTransaccionACH_TCOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $GV_MENSAJE in $outputParameters/ns0:GV_MENSAJE
                return
                    <successIndicator>{ data($GV_MENSAJE) }</successIndicator>
            }
            {
                for $GV_COD_ERROR in $outputParameters/ns0:GV_COD_ERROR
                return
                    <messages>{ data($GV_COD_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ConsultaEstadoTransaccionACH_TCOut($outputParameters)