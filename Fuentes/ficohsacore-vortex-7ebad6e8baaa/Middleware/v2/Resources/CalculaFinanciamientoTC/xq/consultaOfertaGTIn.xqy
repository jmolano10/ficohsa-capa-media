xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculaFinanciamientoTC1" element="ns1:calculaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/BLAZEGT/consultaOferta/xsd/consultaOferta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaFinanciamientoTC/xq/consultaOfertaGTIn/";

declare function xf:consultaOfertaGTIn($calculaFinanciamientoTC1 as element(ns1:calculaFinanciamientoTC))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pv_Identidad>{ data($calculaFinanciamientoTC1/BASE/CUSTOMER_ID) }</ns0:Pv_Identidad>
            <ns0:Pv_Linea>{ data($calculaFinanciamientoTC1/CREDIT_LINE) }</ns0:Pv_Linea>
        </ns0:InputParameters>
};

declare variable $calculaFinanciamientoTC1 as element(ns1:calculaFinanciamientoTC) external;

xf:consultaOfertaGTIn($calculaFinanciamientoTC1)