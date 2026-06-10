<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACH1" element="ns0:consultaFinancierasACH" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaFinacierasACHSolicitud" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace ns2 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIin/";

declare function xf:consultaFinanacierasACHNIin($consultaFinancierasACH1 as element(ns0:consultaFinancierasACH))
    as element(ns2:opConsultaFinacierasACHSolicitud) {
        <ns2:opConsultaFinacierasACHSolicitud>
            <ns1:banco>
                {
                    for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
                    return
                        <ns1:codigoAch>{ data($DESTINATION_CODE) }</ns1:codigoAch>
                }
            </ns1:banco>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
        </ns2:opConsultaFinacierasACHSolicitud>
};

declare variable $consultaFinancierasACH1 as element(ns0:consultaFinancierasACH) external;

xf:consultaFinanacierasACHNIin($consultaFinancierasACH1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/transferencia/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>