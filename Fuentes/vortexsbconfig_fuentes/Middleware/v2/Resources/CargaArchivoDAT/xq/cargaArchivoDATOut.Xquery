<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/cargarArchivoDAT/xsd/cargarArchivoDAT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaArchivoDATResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarArchivoDAT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoDAT/xq/cargaArchivoDATOut/";

declare function xf:cargaArchivoDATOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:cargaArchivoDATResponse) {
        &lt;ns1:cargaArchivoDATResponse>
            &lt;BANK_BATCH_ID>{ data($outputParameters/ns0:PN_SECSOLICITUD) }&lt;/BANK_BATCH_ID>
        &lt;/ns1:cargaArchivoDATResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:cargaArchivoDATOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/DEI/cargarArchivoDAT/xsd/cargarArchivoDAT_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/cargarArchivoDAT/xsd/cargarArchivoDAT_sp"/>
    </con:dependency>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
</con:xqueryEntry>