xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../Schemas/services.xsd" ::)

declare namespace dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp";
(:: import schema at "../Schemas/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd" ::)


declare function local:regionalToCore() as element() (:: schema-element(ns1:opBuscarFechaSistemaSolicitud) ::) {
    <ns1:opBuscarFechaSistemaSolicitud>
        <dto:contextoTransaccional>
            <dto:codCanalOriginador>1</dto:codCanalOriginador>
        </dto:contextoTransaccional>
    </ns1:opBuscarFechaSistemaSolicitud>
};

local:regionalToCore()