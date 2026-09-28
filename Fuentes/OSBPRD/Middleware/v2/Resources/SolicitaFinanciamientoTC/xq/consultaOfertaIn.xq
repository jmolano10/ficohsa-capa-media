(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC" element="ns0:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/VASA/consultaOferta/xsd/consultaOferta_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/consultaOfertaIn/";

declare function xf:consultaOfertaIn($solicitaFinanciamientoTC as element(ns0:solicitaFinanciamientoTC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pv_Identidad>{ data($solicitaFinanciamientoTC/CUSTOMER_ID) }</ns1:Pv_Identidad>
            <ns1:Pv_Linea>{ data($solicitaFinanciamientoTC/CREDIT_LINE) }</ns1:Pv_Linea>
        </ns1:InputParameters>
};

declare variable $solicitaFinanciamientoTC as element(ns0:solicitaFinanciamientoTC) external;

xf:consultaOfertaIn($solicitaFinanciamientoTC)