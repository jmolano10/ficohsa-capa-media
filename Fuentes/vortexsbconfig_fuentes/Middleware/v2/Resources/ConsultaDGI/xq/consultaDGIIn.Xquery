<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDGI" element="ns1:consultaDGI" location="../xsd/consultaDGITypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaDGISolicitud" location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisimpuestos.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDGITypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIIn/";

declare function xf:consultaDGIIn($consultaDGI as element(ns1:consultaDGI),
    $tipoConsultaDGI as xs:string,
    $codigoBancoDGI as xs:string)
    as element(ns2:opConsultaDGISolicitud) {
        <ns2:opConsultaDGISolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:consultaBIT>
                <ns0:valRUC>{ data($consultaDGI/RUC) }</ns0:valRUC>
                <ns0:tipoConsulta>{ $tipoConsultaDGI }</ns0:tipoConsulta>
                <ns0:valCodigoBanco>{ $codigoBancoDGI }</ns0:valCodigoBanco>
                <ns0:bit>{ data($consultaDGI/BILL_NUMBER) }</ns0:bit>
            </ns0:consultaBIT>
        </ns2:opConsultaDGISolicitud>
};

declare variable $consultaDGI as element(ns1:consultaDGI) external;
declare variable $tipoConsultaDGI as xs:string external;
declare variable $codigoBancoDGI as xs:string external;

xf:consultaDGIIn($consultaDGI,
    $tipoConsultaDGI,
    $codigoBancoDGI)]]></con:xquery>
    <con:dependency location="../xsd/consultaDGITypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDGI/xsd/consultaDGITypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/impuesto/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>