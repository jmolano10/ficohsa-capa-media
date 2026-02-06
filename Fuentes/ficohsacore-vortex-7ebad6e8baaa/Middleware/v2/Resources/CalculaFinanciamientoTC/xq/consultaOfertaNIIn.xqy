xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculaFinanciamientoTC1" element="ns0:calculaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/BLAZENI/consultaOferta/xsd/ConsultaOfertaCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOfertaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaFinanciamientoTC/xq/consultaOfertaNIIn/";

declare function xf:consultaOfertaNIIn($calculaFinanciamientoTC1 as element(ns0:calculaFinanciamientoTC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pv_Identidad>{ data($calculaFinanciamientoTC1/BASE/CUSTOMER_ID) }</ns1:Pv_Identidad>
            <ns1:Pv_Linea>{ data($calculaFinanciamientoTC1/CREDIT_LINE) }</ns1:Pv_Linea>
        </ns1:InputParameters>
};

declare variable $calculaFinanciamientoTC1 as element(ns0:calculaFinanciamientoTC) external;

xf:consultaOfertaNIIn($calculaFinanciamientoTC1)