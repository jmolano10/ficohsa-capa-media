xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculaFinanciamientoTC" element="ns0:calculaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ProcesosHN/consultaOferta/xsd/consultaOferta_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaFinanciamientoTC/xq/consultaOfertaHNIn/";

declare function xf:consultaOfertaHNIn($calculaFinanciamientoTC as element(ns0:calculaFinanciamientoTC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pv_Identidad>{ data($calculaFinanciamientoTC/BASE/CUSTOMER_ID) }</ns1:Pv_Identidad>
            <ns1:Pv_Linea>{ data($calculaFinanciamientoTC/CREDIT_LINE) }</ns1:Pv_Linea>
        </ns1:InputParameters>
};

declare variable $calculaFinanciamientoTC as element(ns0:calculaFinanciamientoTC) external;

xf:consultaOfertaHNIn($calculaFinanciamientoTC)