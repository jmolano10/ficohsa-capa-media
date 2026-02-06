xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionPrestamo/xsd/ConsultaEstadoTransaccionPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_PTMOOut/";

declare function xf:ConsultaEstadoTransaccionACH_PTMOOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $ERROR_CODE in $outputParameters1/ns0:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters1/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaEstadoTransaccionACH_PTMOOut($outputParameters1)