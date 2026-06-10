<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCargaArchivoDAT1" element="ns0:consultaCargaArchivoDAT" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCargaArchivoDAT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargaArchivoDAT/xq/consultaCargaArchivoDATIn/";

declare function xf:consultaCargaArchivoDATIn($consultaCargaArchivoDAT1 as element(ns0:consultaCargaArchivoDAT))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
        	&lt;ns1:PN_IDSOLICITUD>{ data($consultaCargaArchivoDAT1/FILE_REQUEST_ID) }&lt;/ns1:PN_IDSOLICITUD>
        &lt;/ns1:InputParameters>
};

declare variable $consultaCargaArchivoDAT1 as element(ns0:consultaCargaArchivoDAT) external;

xf:consultaCargaArchivoDATIn($consultaCargaArchivoDAT1)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp"/>
    </con:dependency>
</con:xqueryEntry>