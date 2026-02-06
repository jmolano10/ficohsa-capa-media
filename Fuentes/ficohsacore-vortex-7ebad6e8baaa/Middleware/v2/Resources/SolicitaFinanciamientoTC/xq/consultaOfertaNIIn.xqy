xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC1" element="ns0:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/BLAZENI/consultaOferta/xsd/ConsultaOfertaCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOfertaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/consultaOfertaNIIn/";

declare function xf:consultaOfertaNIIn($solicitaFinanciamientoTC1 as element(ns0:solicitaFinanciamientoTC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pv_Identidad>{ data($solicitaFinanciamientoTC1/CUSTOMER_ID) }</ns1:Pv_Identidad>
            <ns1:Pv_Linea>{ data($solicitaFinanciamientoTC1/CREDIT_LINE) }</ns1:Pv_Linea>
        </ns1:InputParameters>
};

declare variable $solicitaFinanciamientoTC1 as element(ns0:solicitaFinanciamientoTC) external;

xf:consultaOfertaNIIn($solicitaFinanciamientoTC1)