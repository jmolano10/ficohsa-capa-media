<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosPasivosClienteIN" element="ns0:sjConsultaActivosPasivosCliente" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteRequest" location="../../../../Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaPasivosClienteIN/";

declare function xf:ConsultaPasivosClienteIN($sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente))
    as element(ns1:consultaPasivosClienteRequest) {
        <ns1:consultaPasivosClienteRequest>
            <CUSTOMER_ID>{ data($sjConsultaActivosPasivosClienteIN/ns0:CUSTOMER_ID) }</CUSTOMER_ID>
            <LIABILITY_TYPE>{ data($sjConsultaActivosPasivosClienteIN/ns0:LIABILITY_TYPE) }</LIABILITY_TYPE>
        </ns1:consultaPasivosClienteRequest>
};

declare variable $sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente) external;

xf:ConsultaPasivosClienteIN($sjConsultaActivosPasivosClienteIN)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaActivosPasivosCliente.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xsd/sjConsultaActivosPasivosCliente"/>
    </con:dependency>
    <con:dependency location="../../../../Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>