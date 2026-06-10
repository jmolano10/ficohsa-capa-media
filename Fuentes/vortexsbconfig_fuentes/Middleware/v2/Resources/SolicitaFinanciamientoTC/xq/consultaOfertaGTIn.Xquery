<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:consultaOfertaGTIn($solicitaFinanciamientoTC)]]></con:xquery>
    <con:dependency location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/BLAZEGT/consultaOferta/xsd/consultaOferta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/BLAZEGT/consultaOferta/xsd/consultaOferta_sp"/>
    </con:dependency>
</con:xqueryEntry>