<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaTucaHNTypes";
(:: import schema at "../xsd/consultaTucaHNTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroTucaHN";
(:: import schema at "../../../BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp.xsd" ::)

declare variable $requestService as element() (:: schema-element(ns1:consultaTucaHNRequest) ::) external;

declare function local:consultaTucaHNSPIn($requestService as element() (:: schema-element(ns1:consultaTucaHNRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    &lt;ns2:InputParameters>
        &lt;ns2:P_IDENTIDAD>{fn:data($requestService/CEDULA_IDENTIFICACION_PERSONAL)}&lt;/ns2:P_IDENTIDAD>
    &lt;/ns2:InputParameters>
};

local:consultaTucaHNSPIn($requestService)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaTucaHNTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaTucaHN/xsd/consultaTucaHNTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>