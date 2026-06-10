<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAgenciasBanco" element="ns0:consultaAgenciasBanco" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaAgenciasSolicitud" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace ns2 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoNIIn/";

declare function xf:consultaAgenciasBancoNIIn($consultaAgenciasBanco as element(ns0:consultaAgenciasBanco))
    as element(ns2:opConsultaAgenciasSolicitud) {
        <ns2:opConsultaAgenciasSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:oficina>
                {
                    for $BRANCH_CODE in $consultaAgenciasBanco/BRANCH_CODE
                    return
                        <ns1:codOficina>{ data($BRANCH_CODE) }</ns1:codOficina>
                }
            </ns1:oficina>
        </ns2:opConsultaAgenciasSolicitud>
};

declare variable $consultaAgenciasBanco as element(ns0:consultaAgenciasBanco) external;

xf:consultaAgenciasBancoNIIn($consultaAgenciasBanco)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CTS/generalService/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/generalService/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>