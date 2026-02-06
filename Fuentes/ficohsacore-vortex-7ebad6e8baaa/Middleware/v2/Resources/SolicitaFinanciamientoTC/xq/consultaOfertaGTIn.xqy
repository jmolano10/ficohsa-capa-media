xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC" element="ns1:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/BLAZEGT/consultaOferta/xsd/consultaOferta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/consultaOfertaGTIn/";

declare function xf:consultaOfertaGTIn($solicitaFinanciamientoTC as element(ns1:solicitaFinanciamientoTC))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pv_Identidad>{ data($solicitaFinanciamientoTC/CUSTOMER_ID) }</ns0:Pv_Identidad>
            <ns0:Pv_Linea>{ data($solicitaFinanciamientoTC/CREDIT_LINE) }</ns0:Pv_Linea>
        </ns0:InputParameters>
};

declare variable $solicitaFinanciamientoTC as element(ns1:solicitaFinanciamientoTC) external;

xf:consultaOfertaGTIn($solicitaFinanciamientoTC)