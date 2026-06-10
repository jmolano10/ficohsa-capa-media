<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaSeguroClienteTypes";
(:: import schema at "../xsd/consultaSeguroClienteTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/Insurance";
(:: import schema at "../../../BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes.xsd" ::)

declare variable $ConsultaRequest as element() (:: schema-element(ns1:consultaSeguroClienteRequest) ::) external;

declare function local:func($ConsultaRequest as element() (:: schema-element(ns1:consultaSeguroClienteRequest) ::)) as element() (:: schema-element(ns2:consultaSeguros) ::) {
    <ns2:consultaSeguros>
        <sistema>BANCASEGHN</sistema>
        <noDocumento>{fn:data($ConsultaRequest/NO_DOCUMENTO)}</noDocumento>
        <stsCertificado>{fn:data($ConsultaRequest/STS_CERTIFICADO)}</stsCertificado>
    </ns2:consultaSeguros>
};

local:func($ConsultaRequest)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaSeguroClienteTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaSeguroCliente/xsd/consultaSeguroClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>