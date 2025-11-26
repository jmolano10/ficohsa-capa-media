(:: pragma bea:global-element-return element="ns1:opBuscarFechaSistemaSolicitud" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)

declare namespace ns1 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFechaSistema/xq/consultaFechaSistemaNIIn/";

declare function xf:consultaFechaSistemaNIIn()
as element(ns1:opBuscarFechaSistemaSolicitud) {
    <ns1:opBuscarFechaSistemaSolicitud>
        <ns0:contextoTransaccional>
            <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
        </ns0:contextoTransaccional>
    </ns1:opBuscarFechaSistemaSolicitud>
};


xf:consultaFechaSistemaNIIn()